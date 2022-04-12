//
//  BombView.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 12.04.2022.
//

import UIKit

@IBDesignable
final class BombView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let centre = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min((bounds.width / 2) - 10, (bounds.height / 2) - 10)

        let startAngle: CGFloat = 11
        let endAngle: CGFloat = (3 * .pi) / 2

        let circle = UIBezierPath(
            arcCenter: centre,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        UIColor.gray.setFill()
        circle.fill()

        let circleOutLine = UIBezierPath(
            arcCenter: centre,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        UIColor.black.setFill()
        circleOutLine.stroke()
    }
    
}
