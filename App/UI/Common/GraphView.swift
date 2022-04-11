//
//  GraphView.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 11.04.2022.
//

import UIKit

@IBDesignable
final class GraphView: UIView {
    
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Gradient
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorLocations: [CGFloat] = [0.3, 1.0]
        
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        ) else {
            return
        }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: bounds.width, y: 0)
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
        roundCorners(corners: .allCorners, radius: 16)
        
        // X
        let width = rect.width
        let height = rect.height
        let margin: CGFloat = 20
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
          // Calculate the gap between points
          let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
          return CGFloat(column) * spacing + margin + 2
        }
        
        // Y
        let topBorder: CGFloat = 50
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else {
          return
        }
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
          let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
          return graphHeight + topBorder - yPoint // Переворот графика
        }
        
        // Color line
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        // Circle on line
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        for i in 1 ..< graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        
        for i in 0 ..< graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 5 / 2
            point.y -= 5 / 2
            
            let circle = UIBezierPath(
                ovalIn: CGRect(
                    origin: point,
                    size: CGSize(
                        width: 5,
                        height: 5
                    )
                )
            )
            circle.fill()
        }
    }

}
