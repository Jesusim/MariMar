//
//  AppAssembly.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import UIKit
import Swinject

/// Сборщик корневых объектов приложения.
final class AppAssembly: AutoAssembly {
    dynamic func appCoordinator() {
        container.register(AppCoordinating.self) { (resovler) -> AppCoordinator in
            return AppCoordinator(
                resolver: resovler,
                navigationVC: UINavigationController()
            )
        }.inObjectScope(.container)
    }

    dynamic func mainCoordinator() {
        container.register(
            MainCoordinating.self
        ) { (resolver, navigationVC: UINavigationController) -> MainCoordinator in
            let controller = UIViewController()
            controller.view.backgroundColor = .white
            navigationVC.viewControllers = [controller]
            return MainCoordinator(
                resolver,
                presentationVC: navigationVC
            )
        }.inObjectScope(.container)
    }
}
