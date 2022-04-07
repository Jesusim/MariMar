//
//  HomeAssembly.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import Swinject
import UIKit

final class HomeAssembly: AutoAssembly {
    
    dynamic func homeCoordinator() {
        container.register(
            HomeCoordinating.self
        ) { (
            resolver,
            navigationVC: UINavigationController,
            mainCoordinator: MainCoordinating
        ) -> HomeCoordinator in
            let coordinator = HomeCoordinator(
                resolver,
                presentationVC: navigationVC,
                mainCoordinator: mainCoordinator
            )
            return coordinator
        }
    }
    
    dynamic func homeController() {
        container.register(
            HomeViewController.self
        ) { (
            resolver,
            coordinator: HomeCoordinating
        ) in
            let controller = StoryboardScene.Home.initialScene.instantiate()
            controller.viewOutput = resolver.resolve(
                HomeViewOutput.self,
                arguments: controller as HomeViewInput, coordinator
            )
            return controller
        }
    }

    dynamic func homePresenter() {
        container.register(
            HomeViewOutput.self
        ) { (
            resolver,
            viewInput: HomeViewInput,
            coordinator: HomeCoordinating
        ) -> HomePresenter in
            return HomePresenter(
                viewInput: viewInput,
                coordinator: coordinator
            )
        }
    }
    
}
