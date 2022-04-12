//
//  ClockViewController.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import UIKit

protocol BombViewInput {
}

final class BombViewController: ViewController, BombViewInput {
    
    var viewOutput: BombViewOutput!
    
    var itemsAnimator: UIDynamicAnimator?
    var boundaryCollisionBehavior: UICollisionBehavior?
    var gravityBehavior: UIGravityBehavior?
    @IBOutlet weak var containerView: UIView!
    
    var bombs: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gravityBehavior = UIGravityBehavior(items: [])
        boundaryCollisionBehavior = UICollisionBehavior(items: [])
        boundaryCollisionBehavior?.translatesReferenceBoundsIntoBoundary = true
        itemsAnimator = UIDynamicAnimator(referenceView: containerView)
    }
    
    func setupGravity(bomb: UIView) {
        bombs.append(bomb)
      
        gravityBehavior?.addItem(bomb)
        boundaryCollisionBehavior?.addItem(bomb)
       
        itemsAnimator?.addBehavior(gravityBehavior!)
        itemsAnimator?.addBehavior(boundaryCollisionBehavior!)
    }
    
    @IBAction func tapToSetBomb(_ pan: UIPanGestureRecognizer) {
        let location = pan.location(in: containerView)
        let bomb = BombView(
            frame: CGRect(
                origin: CGPoint(
                    x: location.x,
                    y: location.y
                ),
                size: CGSize(
                    width: 30,
                    height: 30
                )
            )
        )
        containerView.addSubview(bomb)
        setupGravity(bomb: bomb)
    }
    
}
