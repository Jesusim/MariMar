//
//  BombView.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 12.04.2022.
//

import UIKit

@IBDesignable
final class BombView: UIView {
    
    private let rootLayer = CALayer()
    private let emitterLayer = CAEmitterLayer()
    private let fireworkCell = CAEmitterCell()
    
    var onRemoveView: (() -> Void)?
        
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(rootLayer)
        
        emitterLayer.emitterCells = [fireworkCell]
        rootLayer.addSublayer(emitterLayer)
    }
    
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
    }
    
    // MARK: - Setup Layers
    private func setupRootLayer() {
        rootLayer.backgroundColor = UIColor.black.cgColor
    }
    
    private func setupEmitterLayer() {
        emitterLayer.emitterSize = bounds.size
        emitterLayer.emitterPosition = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        emitterLayer.renderMode = CAEmitterLayerRenderMode.additive
    }
    
    private func setupFireworkCell() {
        fireworkCell.contents = UIImage(named: "home")?.cgImage
        fireworkCell.lifetime = 1
        fireworkCell.lifetimeRange = 1
        fireworkCell.birthRate = 2000
        fireworkCell.velocity = 100
        fireworkCell.scale = 0.6
        fireworkCell.spin = 2
        fireworkCell.alphaSpeed = -0.2
        fireworkCell.scaleSpeed = -0.1
        fireworkCell.beginTime = 0.01
        fireworkCell.duration = 0.3
        fireworkCell.emissionRange = CGFloat.pi * 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.emitterLayer.removeAllAnimations()
            self.emitterLayer.removeFromSuperlayer()
            self.removeFromSuperview()
            self.onRemoveView?()
        }
    }
    
    func start() {
        setupRootLayer()
        setupEmitterLayer()
        setupFireworkCell()
    }
    
}
