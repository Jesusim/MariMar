//
//  HomeViewController.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 04.04.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var counterView: CounterView!
    
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
