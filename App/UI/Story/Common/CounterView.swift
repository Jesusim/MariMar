//
//  CounterView.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 05.04.2022.
//

import UIKit

@IBDesignable
final class CounterView: UIView {
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            /// Set the limit of the shape by 0 and maxCounter
            counter = counter < 0 ? 0 : counter
            counter = counter > maxCounter ? maxCounter : counter
            setNeedsDisplay()
        }
    }
    @IBInspectable var maxCounter: Int = 8
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Shape
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = max(bounds.width, bounds.height)
        
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        let arcShapeRadius = radius / 6
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: (radius / 2) - arcShapeRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        path.lineWidth = arcShapeRadius
        UIColor.gray.setStroke()
        path.stroke()
        
        // Line after the shape
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(maxCounter)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        let outerArcRadius = (radius / 2) - arcShapeRadius * 1.5
        
        let outlinePath = UIBezierPath(
          arcCenter: center,
          radius: outerArcRadius,
          startAngle: startAngle,
          endAngle: outlineEndAngle,
          clockwise: true
        )
        
        let innerArcRadius = bounds.width/2 - arcShapeRadius * 0.5
        
        outlinePath.addArc(
          withCenter: center,
          radius: innerArcRadius,
          startAngle: outlineEndAngle,
          endAngle: startAngle,
          clockwise: false)
        outlinePath.close()
        outlinePath.lineWidth = 3
        UIColor.black.setStroke()
        outlinePath.stroke()
        
    }
}
