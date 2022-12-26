//
//  MenuViewController.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import UIKit

class MenuViewController: UIViewController {
    var homeViewModel = HomeViewModel.shared
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpProfile()

    }
    
    func setUpView() {
        profileImage.setCornerRadius()
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        navigationController?.dismiss()
    }
    
    @IBAction func onClickCreateTournament(_ sender: Any) {
        if homeViewModel.user == nil {
            showAlert(controller: self, title: "Alert", message: "Please Login to Create Tournament", handlerOK: { action in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                guard  let loginVc = vc else {
                    return
                }
                loginVc.loginDelagate = self
                self.navigationController?.pushViewController(loginVc, animated: true)
            }, handlerCancel: { actionCancel in
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreateTournamentViewController") as? CreateTournamentViewController
            guard  let tournamentVc = vc else {
                return
            }
            navigationController?.pushViewController(tournamentVc, animated: true)
        }
    }
    @IBAction func onClickManageTournament(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ManageViewController") as? ManageViewController
        guard  let manageVc = vc else {
            return
        }
        navigationController?.pushViewController(manageVc, animated: true)
    }
    
    @IBAction func onClickViewTournament(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewMatchPageController") as? ViewMatchPageController
        guard  let manageVc = vc else {
            return
        }
        navigationController?.pushViewController(manageVc, animated: true)
    }
    @IBAction func onClickClose(_ sender: Any) {
        navigationController?.dismiss()
    }
    
    func setUpProfile() {
        if let user = homeViewModel.user {
            name.text = user.name
            email.text = user.email
            if let imageUrl = URL(string: user.photo!) {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    profileImage.image = UIImage(data: imageData)
                } else {
                    profileImage.image = UIImage(named: "account")
                }
            } else {
                profileImage.image = UIImage(named: "account")
            }
        } else {
            name.text = "Username"
            email.text = "Email"
            profileImage.image = UIImage(named: "account")
        }
    }
}


extension MenuViewController: LoggedUser {
    func sendLoggedUser(user: User) {
        homeViewModel.user = user
    }
}
