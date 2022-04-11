//
//  ClockCoordinator.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import UIKit
import Swinject

protocol BombCoordinating: NavigationCoordinating {
    
}

final class BombCoordinator: NavigationCoordinator<BombViewController>, BombCoordinating {
    
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

    override func instantiateViewController() -> BombViewController {
        return resolver.resolve(BombViewController.self, argument: self as BombCoordinating)!
    }
    
}
