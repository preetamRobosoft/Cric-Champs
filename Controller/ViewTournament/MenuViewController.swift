//
//  MenuViewController.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import UIKit

protocol HandleButtonAction {
    func callButtonAction()
}

class MenuViewController: UIViewController {

    var homeDelegate: HandleButtonAction?

    @IBOutlet weak var profileImage: CustomImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        profileImage.setCornerRadius()
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        homeDelegate?.callButtonAction()
    }
    @IBAction func onClickCreateTournament(_ sender: Any) {
    }
    @IBAction func onClickManageTournament(_ sender: Any) {
    }
    @IBAction func onClickViewTournament(_ sender: Any) {
    }
    @IBAction func onClickClose(_ sender: Any) {
        homeDelegate?.callButtonAction()
    }
}
