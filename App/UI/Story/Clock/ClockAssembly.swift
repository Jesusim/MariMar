//
//  ClockAssembly.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import Swinject
import UIKit

final class ClockAssembly: AutoAssembly {
    
    dynamic func clockCoordinator() {
        container.register(
            ClockCoordinating.self
        ) { (
            resolver,
            navigationVC: UINavigationController,
            mainCoordinator: MainCoordinating
        ) -> ClockCoordinator in
            let coordinator = ClockCoordinator(
                resolver,
                presentationVC: navigationVC,
                mainCoordinator: mainCoordinator
            )
            return coordinator
        }
    }
    
    dynamic func clockController() {
        container.register(
            ClockViewController.self
        ) { (
            resolver,
            coordinator: ClockCoordinating
        ) in
            let controller = StoryboardScene.Clock.initialScene.instantiate()
            controller.viewOutput = resolver.resolve(
                ClockViewOutput.self,
                arguments: controller as ClockViewInput, coordinator
            )
            return controller
        }
    }

    dynamic func clockPresenter() {
        container.register(
            ClockViewOutput.self
        ) { (
            resolver,
            viewInput: ClockViewInput,
            coordinator: ClockCoordinating
        ) -> ClockPresenter in
            return ClockPresenter(
                viewInput: viewInput,
                coordinator: coordinator
            )
        }
    }
    
}
