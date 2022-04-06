//
//  AutoAssembly.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import Swinject
import Foundation

/// Автоматический сборщик.
///
/// Swinject отличается от Typhoon отсутствием рантайма.
/// Он не может самостоятельно получить селекторы всех регистраций и
/// сделать автоматический вызов.
/// Этот класс призван решить эту проблему.
@objcMembers
class AutoAssembly: NSObject, Assembly {
    /// Рабочий контейнер сборщика, передается Swinject'ом.
    var container: Container!

    /// Перебирает все селекторы и делает вызов.
    ///
    /// Метод должен быть помечен как `dynamic`, не принимать аргументов
    /// и не возвращать значение. Помечать класс или методы как `@objc`
    /// не требуется.
    func assemble(container: Container) {
        self.container = container

        // Получает список методов текущего класса.
        var count = UInt32()
        let pointer = class_copyMethodList(type(of: self), &count)
        let list = Array(UnsafeBufferPointer(start: pointer, count: Int(count)))

        // Для всех методов, которые соответствуют сигнатуре -[NSObject some].
        // Для Swift-разработчиков немного матчасти.
        // Любой метод Obj-C содержит минимум два аргумента:
        // Указатель на объект, которому посылается сообщение и вызываемый селектор.
        // Так что метод @objc func someFunc() с точки зрения Objc-C имеет вид
        // void someFunc(SomeObject *self, SEL _cmd) {}.
        // Больше инфы: https://habr.com/ru/post/270913/
        list.forEach { method in
            let selector = method_getName(method)
            guard selector != #selector(NSObject.init),
                  method_getNumberOfArguments(method) == 2,
                  String(cString: method_copyReturnType(method)) == "v" else {
                return
            }

            perform(selector)
        }
    }
}
