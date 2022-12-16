//
//  AddPlayerViewController.swift
//  Cricket
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class AddPlayerViewController: UIViewController {
    
       @IBOutlet weak var designationSwitch: UISwitch!
       @IBOutlet weak var captainButton: RadioButton!
       @IBOutlet weak var viceCaptainButton: RadioButton!
       @IBOutlet weak var expertiseSwitch: UISwitch!
       @IBOutlet weak var battingSwitch: UISwitch!
       @IBOutlet weak var bowlingSwitch: UISwitch!
       @IBOutlet weak var bowlingTypeSwitch: UISwitch!
       override func viewDidLoad() {
           super.viewDidLoad()
           setUpSwitch()
       }
       
       private func setUpSwitch() {
           designationSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
           expertiseSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
           bowlingSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
           battingSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
           bowlingTypeSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
       }
       
       @IBAction func onSelectDesignation(_ sender: Any) {
           if designationSwitch.isOn {
               captainButton.isEnabled = true
               viceCaptainButton.isEnabled = true
           } else {
               captainButton.isEnabled = false
               viceCaptainButton.isEnabled = false
           }
       }
       

   }

