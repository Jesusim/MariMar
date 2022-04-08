//
//  MainCoordinator.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import UIKit
import Swinject
import Network

protocol MainCoordinating: NavigationCoordinating {
    func tabCoordinator(by child: MainCoordinatorChild) -> NavigationCoordinating?
    func changeTab(on child: MainCoordinatorChild)
}

enum MainCoordinatorChild: Int {
    case home
    case clock
}

private var _sharedMainCoordinator: MainCoordinating!

final class MainCoordinator: NavigationCoordinator<UITabBarController>, MainCoordinating {
    
    class var sharedMainCoordinator: MainCoordinating {
        return _sharedMainCoordinator
    }
    
    override init(_ resolver: Resolver, presentationVC: UINavigationController) {
        super.init(resolver, presentationVC: presentationVC)
        _sharedMainCoordinator = self as MainCoordinating
    }
    
    // MARK: - Override

    override var isNavigationBarHidden: Bool {
        return true
    }

    override var presentationStyle: NavigationStyle {
        return .new
    }

    override func instantiateViewController() -> UITabBarController {
        let tabBar = TabBarController()
        tabBar.eventsDelegate = self
        return tabBar
    }

    override func start() {
        super.start()
        presentingVC.viewControllers = [
            tab(for: .home),
            tab(for: .clock),
        ]
    }

    private func tab(for type: MainCoordinatorChild) -> UINavigationController {
        switch type {
        case .home:
            return homeTab()
        case .clock:
            return clockTab()
        }
    }
    
    func tabCoordinator(by child: MainCoordinatorChild) -> NavigationCoordinating? {
        guard childs.count > child.rawValue else {
            return nil
        }
        return childs[child.rawValue]
    }

    func changeTab(on child: MainCoordinatorChild) {
        guard let tabBar = presentingVC,
              let viewControllers = tabBar.viewControllers else {
            return
        }
        tabBar.selectedIndex = child.rawValue
        // swiftlint:disable:next force_cast
        let rootView = viewControllers[child.rawValue] as! UINavigationController
        rootView.popToRootViewController(animated: false)
    }

    // MARK: - Private

    private func homeTab() -> UINavigationController {
        let homeNavigationVC = UINavigationController()
        homeNavigationVC.tabBarItem = UITabBarItem(
            title: L10n.Tab.home,
            image: Asset.home.image,
            selectedImage: Asset.home.image
        )
        let homeCoordinator = resolver.resolve(
            HomeCoordinating.self,
            arguments: homeNavigationVC, self as MainCoordinating
        )!
        openChild(homeCoordinator)
        return homeNavigationVC
    }
    
    private func clockTab() -> UINavigationController {
        let clockNavigationVC = UINavigationController()
        clockNavigationVC.tabBarItem = UITabBarItem(
            title: L10n.Tab.clock,
            image: Asset.home.image,
            selectedImage: Asset.home.image
        )
        let homeCoordinator = resolver.resolve(
            ClockCoordinating.self,
            arguments: clockNavigationVC, self as MainCoordinating
        )!
        openChild(homeCoordinator)
        return clockNavigationVC
    }
}

extension MainCoordinator: TabBarEventsDelegate {
    
    func tabBar(didSelect viewController: UIViewController) {
    }
    
}
