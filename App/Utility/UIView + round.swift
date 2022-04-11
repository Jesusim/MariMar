//
//  UIView + round.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 11.04.2022.
//
import UIKit

extension UIView {

    /// Прокси для установки скругления. Может быть использовано в Interface Builder.
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    /// Задает закругление для указаных углов UIView.
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let cornerRadii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
