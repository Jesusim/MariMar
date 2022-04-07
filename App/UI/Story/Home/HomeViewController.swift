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
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var counterView: CounterView!
    
    var viewOutput: HomeViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusTap(_ sender: UIButton) {
        counterView.counter += 1
        numberLabel.text = "\(counterView.counter)"
    }
    
    @IBAction func minusTap(_ sender: UIButton) {
        counterView.counter -= 1
        numberLabel.text = "\(counterView.counter)"
    }
    
}
