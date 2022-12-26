//
//  OversViewController.swift
//  Cricket
//
//  Created by Preetam G on 09/12/22.
//

import UIKit

class OversViewController: UIViewController {
    var tournamentViewModel = TournamentViewModel.shared
    var isOverSelected = false
    var over: Int?
    
    @IBOutlet weak var proceedButton: GradientButton!
    @IBOutlet weak var overFive: RadioButton!
    @IBOutlet weak var overTen: RadioButton!
    @IBOutlet weak var overfifteen: RadioButton!
    @IBOutlet weak var overTwenty: RadioButton!
    @IBOutlet weak var overTwentyFive: RadioButton!
    @IBOutlet weak var overThirty: RadioButton!
    @IBOutlet weak var overFourty: RadioButton!
    @IBOutlet weak var overFifty: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpButton()
    }
    
    private func setUpButton() {
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    
    @IBAction func onClickProceed(_ sender: Any) {
        if isOverSelected {
            tournamentViewModel.setOver(over: over ?? 0){ success, error in
                DispatchQueue.main.async {
                    if success {
                        let vc = self.storyboard?.instantiateViewController(identifier: "GroundsViewController") as? GroundsViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                    } else {
                        alertAction(controller: self, message: error?.localizedDescription ?? "Unknown Error")
                    }
                }
            }
        } else {
            alertAction(controller: self, message: "Please Select Over")
        }
    }
    
    @IBAction func onSelectButton(_ sender: RadioButton) {
        isOverSelected = true
        sender.changeButtonsStatus(sender: sender, buttons: [overFive, overTen, overfifteen, overTwenty, overTwentyFive, overThirty, overFourty, overFifty])
        let data = (sender.titleLabel?.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        over = Int(data)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
