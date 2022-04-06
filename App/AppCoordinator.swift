//
//  AppCoordinator.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import UIKit
import Swinject

protocol AppCoordinating {
    /// Запускает навигацию.
    func start(with window: UIWindow)
}

final class AppCoordinator: Coordinator, AppCoordinating {
    private let rootNavigationVC: UINavigationController
    private var window: UIWindow?

    private var child: NavigationCoordinating?

    init(
        resolver: Resolver,
        navigationVC: UINavigationController
    ) {
        self.rootNavigationVC = navigationVC
        super.init(resolver)
    }

    // MARK: - AppCoordinating

    // Запускает навигацию.
    func start(with window: UIWindow) {
        self.window = window

        window.rootViewController = rootNavigationVC
        window.makeKeyAndVisible()

        runMainCoordinator()
    }

    // MARK: - Private

    private func runMainCoordinator() {
        child = resolver.resolve(
            MainCoordinating.self,
            argument: rootNavigationVC
        )!
        
        child?.delegate = self
        child?.start()
    }
}

extension AppCoordinator: NavigationCoordinatorDelegate {
    
    func coordinatorShouldClose(_ coordinator: NavigationCoordinating) {
    }
    
}
