//
//  HomeViewController.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 04.04.2022.
//

import UIKit

protocol HomeViewInput {
    
}

final class HomeViewController: ViewController, HomeViewInput {
    
    var viewOutput: HomeViewOutput!
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var counterView: CounterView!
    @IBOutlet private weak var graphView: GraphView!
    
    private var isShowGraphView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func plusTap(_ sender: UIButton) {
        counterView.counter += 1
        numberLabel.text = "\(counterView.counter)"
    }
    
    @IBAction private func minusTap(_ sender: UIButton) {
        counterView.counter -= 1
        numberLabel.text = "\(counterView.counter)"
    }
    
    @IBAction func counterViewTap(_ sender: UITapGestureRecognizer) {
        if isShowGraphView {
            UIView.transition(
                from: graphView,
                to: counterView,
                duration: 1.0,
                options: [.transitionFlipFromLeft, .showHideTransitionViews],
                completion: nil
            )
        } else {
            // Show Graph
            UIView.transition(
                from: counterView,
                to: graphView,
                duration: 1.0,
                options: [.transitionFlipFromRight, .showHideTransitionViews],
                completion: nil
            )
        }
        isShowGraphView.toggle()
    }
}
