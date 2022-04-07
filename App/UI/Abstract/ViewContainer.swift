//
//  ViewContainer.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 04.04.2022.
//

import UIKit
import PureLayout

/// Абстрактный контейнер отображения.
///
/// Наследуйте от него и создайте одноименный XIB-файл. Контент XIB-файла будет загружен
/// в свойство `content` и расположен на всей доступной площади отображения.
/// Вы также можете добавить любые аутлеты или действия в наследника.
class ViewContainer: UIView {
    /// Контент XIB-файла, которым управляет данный контейнер.
    var content: UIView!

    /// Имя XIB-файла, если наследник использует XIB своего суперкласса.
    var nibName: String? { return nil }

    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        adjustContent()
    }

    // Добавляет контент на отображение.
    private func adjustContent() {
        guard type(of: self) != ViewContainer.self else {
            fatalError("You must inherit from the ViewContainer and create a similar XIB.")
        }

        backgroundColor = .clear

        content = loadContent()
        addSubview(content)
        content.autoPinEdgesToSuperviewEdges()
        self.prepareForDisplay()
    }

    // Загружает контент из XIB-файла.
    private func loadContent() -> UIView {
        let nibName = self.nibName ?? String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: nil)
        let content = nib.instantiate(withOwner: self)

        guard let result = content.first as? UIView else {
            fatalError("The view obtained from XIB does not match of type \(UIView.self)")
        }

        return result
    }

    // MARK: Life cycle

    func prepareForDisplay() {
        // Переопределите функцию для настройки.
    }
}
