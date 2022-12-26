//
//  TournamentCodeViewController.swift
//  Cricket
//
//  Created by Preetam G on 09/12/22.
//

import UIKit

class TournamentCodeViewController: UIViewController {

    var tournament: Tournament?
    
    @IBOutlet weak var tournamentCode: UILabel!
    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var proceedButton: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    override func viewDidLayoutSubviews() {
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    func setData() {
        if let data = tournament {
            tournamentCode.text = data.tournamentCode
            tournamentName.text = data.name
        }
    }
    @IBAction func onClickProceed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddTeamListViewController") as! AddTeamListViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
