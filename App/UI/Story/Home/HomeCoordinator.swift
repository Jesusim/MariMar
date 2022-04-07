//
//  HomeCoordinate.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import UIKit
import Swinject

protocol HomeCoordinating: NavigationCoordinating {
    
}

final class HomeCoordinator: NavigationCoordinator<HomeViewController>, HomeCoordinating {
    
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

    override func instantiateViewController() -> HomeViewController {
        return resolver.resolve(HomeViewController.self, argument: self as HomeCoordinating)!
    }
    
}
