//
//  TabBarController.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import UIKit

protocol TabBarEventsDelegate: AnyObject {
    func tabBar(didSelect viewController: UIViewController)
}

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    weak var eventsDelegate: TabBarEventsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        UITabBar.appearance().unselectedItemTintColor = UIColor(hex: "707077")
        UITabBar.appearance().tintColor = .black
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        eventsDelegate?.tabBar(didSelect: viewController)
    }
}
