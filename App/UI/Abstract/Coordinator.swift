//
//  Coordinator.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import Swinject
import UIKit

/// Абстрактный класс роутера, содержащий резольвер.
class Coordinator {
    /// Резольвер контейнера Swinject.
    let resolver: Resolver

    init(_ resolver: Resolver) {
        self.resolver = resolver
    }
}

/// Протокол основного роутера навигации.
protocol NavigationCoordinating: AnyObject {
    /// Делегат жизненного цикла координатора.
    var delegate: NavigationCoordinatorDelegate? { get set }

    /// Презентует модуль на основном контроллере.
    func start()

    /// Закрывает модуль.
    func close()
}

/// Делегат жизненного цикла координатора.
protocol NavigationCoordinatorDelegate: AnyObject {
    /// Координатор запрашивает закрытие.
    func coordinatorShouldClose(_ coordinator: NavigationCoordinating)
}

/// Абстрактный класс роутера навигации.
class NavigationCoordinator<T: UIViewController>: Coordinator,
    NavigationCoordinating,
    NavigationCoordinatorDelegate {
    /// Стиль презентации модуля.
    enum NavigationStyle {
        /// Использовать родительскую иерархию навигации.
        case parent
        /// Создать новый `UINavigationController`.
        case new
        /// Заменить текущий стэк контроллеров.
        case replaceStack
    }

    /// Контроллер, на котором происходит презентация.
    private(set) var presentationVC: UINavigationController
    /// Контроллер модуля.
    private(set) var presentingVC: T!
    /// Дочерний роутер.
    private(set) var childs: [NavigationCoordinating] = []

    /// Делегат жизненного цикла координатора.
    weak var delegate: NavigationCoordinatorDelegate?

    /// Конструктор класса, с использованием резольвера и презентующего контроллера.
    init(_ resolver: Resolver, presentationVC: UINavigationController) {
        self.presentationVC = presentationVC
        super.init(resolver)
    }

    // MARK: - Public

    /// Стиль презентации модуля.
    var presentationStyle: NavigationStyle {
        return .parent
    }

    var prefersLargeTitles: Bool {
        return false
    }

    /// Показывать ли бар навигации.
    /// По-умолчанию, показывать.
    var isNavigationBarHidden: Bool {
        return false
    }

    var isAnimating: Bool {
        return true
    }

    /// Создает модуль.
    ///
    /// Эта функция будет вызвана, который координатор должен представить модуль.
    /// Наследник должен переопределить эту функцию и создать мордуль.
    func instantiateViewController() -> T {
        preconditionFailure("Необходимо переопределить эту функции в наследнике!")
    }

    /// Показать дочерний координатор.
    func openChild(_ child: NavigationCoordinating) {
        child.delegate = self
        child.start()
        childs.append(child)
    }

    // MARK: - NavigationCoordinating

    func start() {
        presentingVC = self.instantiateViewController()

        if let lifeCycleSender = presentingVC as? ViewController {
            lifeCycleSender.lifeCycleDelegate = self
        }
        var navigationVC: UINavigationController
        switch presentationStyle {
        case .parent, .replaceStack:
            navigationVC = presentationVC
        case .new:
            navigationVC = UINavigationController()
            navigationVC.modalPresentationStyle = .overFullScreen
        }
        
        self.prepareNavigationController(navigationVC)

        if presentationStyle != .replaceStack {
            navigationVC.pushViewController(presentingVC, animated: isAnimating)
        }

        if presentationStyle == .new {
            presentationVC.present(
                navigationVC,
                animated: isAnimating,
                completion: nil
            )
            presentationVC = navigationVC
            presentationVC.setNavigationBarHidden(isNavigationBarHidden, animated: true)
        }

        if presentationStyle == .replaceStack {
            navigationVC.setViewControllers([presentingVC], animated: isAnimating)
        }
    }
    
    func prepareNavigationController(_ navigationController: UINavigationController) {
        // Do Nothing...
    }

    func close() {
        delegate?.coordinatorShouldClose(self)
        if presentationStyle == .new {
            presentationVC.dismiss(animated: true, completion: nil)
        } else {
            presentationVC.popViewController(animated: isAnimating)
        }
    }

    func coordinatorShouldClose(_ coordinator: NavigationCoordinating) {}
}

extension NavigationCoordinator: ViewLifeCycleDelegate {
    func viewWillAppear() {
        presentationVC.setNavigationBarHidden(isNavigationBarHidden, animated: true)
        presentationVC.navigationBar.prefersLargeTitles = prefersLargeTitles
    }

    func viewWillDisappear() { }
}
