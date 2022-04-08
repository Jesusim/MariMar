//
//  ClockViewController.swift
//  MariMar
//
//  Created by Kolesnikov Dmitry on 07.04.2022.
//

import UIKit

protocol ClockViewInput {
}

final class ClockViewController: ViewController, ClockViewInput {
    
    var viewOutput: ClockViewOutput!
    @IBOutlet weak var clockView: ClockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpClock()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.clockView.counterSeconds += 1
            self.clockView.setNeedsDisplay()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpClock()
    }
    
    private func setUpClock() {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        if hour > 12 {
            clockView.counterHours = (hour - 12) * 5
        } else {
            clockView.counterHours = hour * 5
        }
        clockView.counterMinutes = minutes
        clockView.counterSeconds = seconds
    }

}
