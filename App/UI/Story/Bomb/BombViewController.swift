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
    
    @IBOutlet weak var containerView: UIView!
    
    var viewOutput: BombViewOutput!
    
    var itemsAnimator: UIDynamicAnimator?
    var boundaryCollisionBehavior: UICollisionBehavior?
    var gravityBehavior: UIGravityBehavior?
    
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
        boundaryCollisionBehavior?.collisionDelegate = self
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

extension BombViewController: UICollisionBehaviorDelegate {
    
    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item1: UIDynamicItem,
        with item2: UIDynamicItem,
        at p: CGPoint
    ) {
        let bomb = item2 as? BombView
        bomb?.start()
        bomb?.onRemoveView = {
            self.bombs.removeAll(where: { $0 == bomb })
            self.gravityBehavior?.removeItem(item2)
            self.boundaryCollisionBehavior?.removeItem(item2)
        }
    }
    
    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying?,
        at p: CGPoint
    ) {
        let bomb = item as? BombView
        bomb?.start()
        bomb?.onRemoveView = {
            self.bombs.removeAll(where: { $0 == bomb })
            self.gravityBehavior?.removeItem(item)
            self.boundaryCollisionBehavior?.removeItem(item)
        }
    }
    
}
