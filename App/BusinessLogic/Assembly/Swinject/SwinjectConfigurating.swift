//
//  SwinjectConfigurating.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import Swinject
import UIKit

protocol SwinjectConfigurating {
    /// Основной DI-контейнер.
    var resolver: Resolver { get }
}

final class SwinjectConfigurator: SwinjectConfigurating {
    /// Singleton-экземпляр конфигуратора.
    static var shared: SwinjectConfigurator = {
        let configurator = SwinjectConfigurator()
        configurator.configure()
        return configurator
    }()

    var resolver: Resolver {
        return container
    }

    // Основной DI-контейнер.
    private let container = Container()

    // Провайдер сборщиков.
    private let assembler: Assembler

    // Сделан приватным, чтобы пользовались только `shared`.
    private init() {
        assembler = Assembler(container: container)
    }

    // Находит все сборщики в проекте и активирует их.
    private func configure() {
        let assemblies = assemblyList()
        assembler.apply(assemblies: assemblies)
    }

    // Находит все сборщики в проекте и возвращает их в виде массива.
    private func assemblyList() -> [Assembly] {
        var count: UInt32 = 0

        guard
            let executablePath = Bundle.main.executablePath,
            let cString = executablePath.cString(using: .ascii),
            let classNames = objc_copyClassNamesForImage(cString, &count)
        else {
            preconditionFailure("Не удалось получить список классов для бандла \(Bundle.main)!")
        }

        var list = [Assembly]()
        for index in 0..<Int(count) {
            let pointer = classNames[index]

            guard let className = NSString(
                cString: pointer,
                encoding: String.Encoding.utf8  .rawValue
            ) else {
                continue
            }

            let aClass: AnyClass? = NSClassFromString(className as String)
            if let assembly = aClass as? (NSObject & Assembly).Type,
               assembly != AutoAssembly.self {
                list.append(assembly.init())
            }
        }

        return list
    }
}

