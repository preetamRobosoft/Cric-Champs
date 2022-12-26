//
//  AddUmpireViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

class AddUmpireViewController: UIViewController {
    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var profileBackGround: ProfilePhotoImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var saveUmpireButton: GradientButton!
    @IBOutlet weak var profilePhoto: CustomImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePhoto.setCornerRadius()
        profileBackGround.setRadius()
        saveUmpireButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let umpire = tournamentViewModel.currentUmpire {
            setUpDataForFields(umpire: umpire)
        }
    }
    
    private func setUpDataForFields(umpire: Umpire) {
        name.text = umpire.name.capitalized
        city.text = umpire.place.capitalized
        guard  let imageUrl = URL(string: (umpire.profile as? String) ?? "" ) else {
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        profilePhoto.image = UIImage(data: imageData)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        tournamentViewModel.currentUmpire = nil
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickProceed(_ sender: Any) {
        if validateFields() {
            let umpire = Umpire(name: name.text!, place: city.text!, phone: phone.text!, profile: profilePhoto.image)
                tournamentViewModel.currentUmpire = umpire
                tournamentViewModel.saveUmpire { success, error in
                    DispatchQueue.main.async {
                        if success {
                            self.clearAllFields()
                        } else {
                            alertAction(controller: self, message: error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func clearAllFields() {
        name.text = ""
        profilePhoto.image = nil
        phone.text = ""
        city.text = ""
    }

    
    private func validateFields() -> Bool {
        var isValid = true
        if profilePhoto.image == nil {
            isValid = false
            alertAction(controller: self, message: "Select Profile Photo")
        }
        if name.text == "" {
            alertAction(controller: self, message: "Enter Umpire Name")
        }
        if city.text == "" {
            alertAction(controller: self, message: "Enter City Name")
        }
        return isValid
    }
    
    @IBAction func onClickSelectImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
}

extension AddUmpireViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        profilePhoto.image = fetchedImage
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
