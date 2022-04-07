//
//  ViewController.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 06.04.2022.
//

import UIKit

/// Делегат жизненного цикла отображения.
protocol ViewLifeCycleDelegate: AnyObject {
    /// Отображение будет отрисовано.
    func viewWillAppear()
    /// Отображение будет скрыто.
    func viewWillDisappear()
}

/// Базовый контроллер в проекте,
class ViewController: UIViewController {
    /// Делегат жизненного цикла отображения.
    weak var lifeCycleDelegate: ViewLifeCycleDelegate?

    // MARK: - Override

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifeCycleDelegate?.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifeCycleDelegate?.viewWillDisappear()
    }
}
