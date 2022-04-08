//
//  ClockView.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import UIKit

let kSeconds = 60
let kMinutes = 60
let kHours = 12 * 5

@IBDesignable
final class ClockView: UIView {
    
    @IBInspectable var counterSeconds: Double = 0
    @IBInspectable var counterMinutes: Int = 0
    @IBInspectable var counterHours: Int = 0
    
    @IBInspectable var isNeedCircle: Bool = false

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Shape
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min((bounds.width / 2) - 10, (bounds.height / 2) - 10)
        
        let startAngle: CGFloat = 11
        let endAngle: CGFloat = (3 * .pi) / 2
        
        if isNeedCircle {
            let circle = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            
            UIColor.gray.setFill()
            circle.fill()
            
            let circleOutLine = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            
            UIColor.black.setFill()
            circleOutLine.stroke()
        }
        
        // Hours
        let angleDifference: CGFloat = .pi * 2
        let arcLengthPerGlass = angleDifference / CGFloat(kHours)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counterHours) + startAngle
        let outerArcRadius = radius

        let outlinePath = UIBezierPath(
          arcCenter: center,
          radius: outerArcRadius,
          startAngle: startAngle,
          endAngle: outlineEndAngle,
          clockwise: true
        )
        outlinePath.lineWidth = 0
        outlinePath.stroke()

        let hourLine = UIBezierPath()
        hourLine.move(to: center)
        hourLine.addLine(to: outlinePath.currentPoint)
        hourLine.lineWidth = 5
        UIColor.red.setStroke()
        hourLine.stroke()
        
        // Minutes
        let angleDifferenceM: CGFloat = .pi * 2
        let arcLengthPerM = angleDifferenceM / CGFloat(kMinutes)
        let outlineEndAngleM = arcLengthPerM * CGFloat(counterMinutes) + startAngle
        let outerArcRadiusM = radius

        let outlinePathM = UIBezierPath(
          arcCenter: center,
          radius: outerArcRadiusM,
          startAngle: startAngle,
          endAngle: outlineEndAngleM,
          clockwise: true
        )
        outlinePathM.lineWidth = 0
        outlinePathM.stroke()

        let minetsLine = UIBezierPath()
        minetsLine.move(to: center)
        minetsLine.addLine(to: outlinePathM.currentPoint)
        minetsLine.lineWidth = 3
        UIColor.green.setStroke()
        minetsLine.stroke()
        
        // Seconds
        let angleDifferenceS: CGFloat = .pi * 2
        let arcLengthPerS = angleDifferenceS / CGFloat(kSeconds)
        let outlineEndAngleS = arcLengthPerS * CGFloat(counterSeconds) + startAngle
        let outerArcRadiusS = radius

        let outlinePathS = UIBezierPath(
          arcCenter: center,
          radius: outerArcRadiusS,
          startAngle: startAngle,
          endAngle: outlineEndAngleS,
          clockwise: true
        )
        outlinePathS.lineWidth = 0
        outlinePathS.stroke()

        let secondsLine = UIBezierPath()
        secondsLine.move(to: center)
        secondsLine.addLine(to: outlinePathS.currentPoint)
        secondsLine.lineWidth = 1
        UIColor.black.setStroke()
        secondsLine.stroke()
        
        // In shape
        let circleIn = UIBezierPath(
            arcCenter: center,
            radius: radius / 12,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        UIColor.black.setFill()
        circleIn.fill()
        
        moveLines()
    }
    
    func moveLines() {
        if counterSeconds >= Double(kSeconds) {
            counterMinutes += 1
            counterSeconds = 0
        }
        
        if counterMinutes >= kMinutes {
            counterHours += 1
            counterMinutes = 0
        }
        
        if counterHours >= kHours {
            counterHours = 0
        }
    }

}
