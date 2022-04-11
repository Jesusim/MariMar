//
//  BombAssembly.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import Swinject
import UIKit

final class BombAssembly: AutoAssembly {
    
    dynamic func bombCoordinator() {
        container.register(
            BombCoordinating.self
        ) { (
            resolver,
            navigationVC: UINavigationController,
            mainCoordinator: MainCoordinating
        ) -> BombCoordinator in
            let coordinator = BombCoordinator(
                resolver,
                presentationVC: navigationVC,
                mainCoordinator: mainCoordinator
            )
            return coordinator
        }
    }
    
    dynamic func bombController() {
        container.register(
            BombViewController.self
        ) { (
            resolver,
            coordinator: BombCoordinating
        ) in
            let controller = StoryboardScene.Bomb.initialScene.instantiate()
            controller.viewOutput = resolver.resolve(
                BombViewOutput.self,
                arguments: controller as BombViewInput, coordinator
            )
            return controller
        }
    }

    dynamic func bombPresenter() {
        container.register(
            BombViewOutput.self
        ) { (
            resolver,
            viewInput: BombViewInput,
            coordinator: BombCoordinating
        ) -> BombPresenter in
            return BombPresenter(
                viewInput: viewInput,
                coordinator: coordinator
            )
        }
    }
    
}
