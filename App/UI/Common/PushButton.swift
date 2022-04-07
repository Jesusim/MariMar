//
//  PushButton.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 04.04.2022.
//

import UIKit

@IBDesignable
final class PushButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = .green
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 50)
        fillColor.setFill()
        path.fill()
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = 4
        plusPath.move(to: CGPoint(
            x: 10,
            y: bounds.height / 2)
        )
        
        plusPath.addLine(to: CGPoint(
            x: bounds.height - 10,
            y: bounds.width / 2)
        )
        
        if isAddButton {
            plusPath.move(to: CGPoint(
                x: bounds.width / 2,
                y: 10)
            )
            
            plusPath.addLine(to: CGPoint(
                x: bounds.width / 2,
                y: bounds.height - 10)
            )
        }
        
        UIColor.white.setStroke()
        plusPath.stroke()
    }
    
}
