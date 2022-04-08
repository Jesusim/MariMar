//
//  ClockCoordinator.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import UIKit
import Swinject

protocol ClockCoordinating: NavigationCoordinating {
    
}

final class ClockCoordinator: NavigationCoordinator<ClockViewController>, ClockCoordinating {
    
    weak var mainCoordinator: MainCoordinating?
    
    init(
        _ resolver: Resolver,
        presentationVC: UINavigationController,
        mainCoordinator: MainCoordinating
    ) {
        super.init(resolver, presentationVC: presentationVC)
        self.mainCoordinator = mainCoordinator
    }

    override var isNavigationBarHidden: Bool {
        return false
    }

    override func instantiateViewController() -> ClockViewController {
        return resolver.resolve(ClockViewController.self, argument: self as ClockCoordinating)!
    }
    
}
