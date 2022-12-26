//
//  CreateTournamentViewController.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 19/12/22.
//

import UIKit

class CreateTournamentViewController: UIViewController {
    var tournamentViewModel = TournamentViewModel.shared

    @IBOutlet weak var tournamentLogo: CustomImageView!
    @IBOutlet weak var logoBackGround: ProfilePhotoImageView!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var tournamentName: UITextField!
    @IBOutlet weak var createTournament: GradientButton!
    @IBOutlet weak var leagueButton: RadioButton!
    @IBOutlet weak var knockoutButton: RadioButton!
    @IBOutlet weak var individualMatchButton: RadioButton!
    var tournamnetType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        createTournament.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
        tournamentLogo.setCornerRadius()
        logoBackGround.setRadius()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createTournament.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    
    
    @IBAction func onClickSelectImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func onClickSelectTournamentType(_ sender: RadioButton) {
        tournamentViewModel.isTournamentSelected = true
        sender.changeButtonsStatus(sender: sender, buttons: [leagueButton, knockoutButton, individualMatchButton])
        tournamnetType = sender.titleLabel?.text ?? ""
    }

    @IBAction func onClickCreateTournament(_ sender: Any) {
        if validateFields() {
            tournamentViewModel.setParameterForCreateTournament(tournamentType: tournamnetType, tournamentName: tournamentName.text ?? "")
            tournamentViewModel.createTournament{data, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(identifier: "TournamentCodeViewController") as? TournamentCodeViewController
                        vc?.tournament = data
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                } else {
                    alertAction(controller: self, message: error?.localizedDescription ?? "Unknown Error")
                }
            }
        }
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func validateFields() -> Bool {
        var isValid = true
        if tournamentName.text == "" {
            alertAction(controller: self, message: "Enter Tournament Name")
            isValid = false
        }
        if tournamentLogo.image == nil {
            alertAction(controller: self, message: "Select Tournament Logo")
            isValid = false
        }
        if !tournamentViewModel.isTournamentSelected {
            alertAction(controller: self, message: "Select Tournament Type")
            isValid = false
        }
        return isValid
    }
}


extension CreateTournamentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        tournamentLogo.image = fetchedImage
        tournamentViewModel.tournamentLogo = tournamentLogo.image
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
