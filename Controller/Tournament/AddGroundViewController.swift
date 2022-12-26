//
//  AddGroundViewController.swift
//  Cricket
//
//  Created by Preetam G on 11/12/22.
//

import UIKit

class AddGroundViewController: UIViewController {

    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var proceedButton: GradientButton!
    @IBOutlet weak var customProfileView: ProfilePhotoImageView!
    @IBOutlet weak var triangleView: TriangleView!
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var groundName: UITextField!
    @IBOutlet weak var cityname: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setCornerRadius()
        configureButtons()
        customProfileView.setRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpFields()
    }
    
    func configureButtons() {
        proceedButton.setUpButtonBackGround( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        proceedButton.setUpButtonBackGround( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    private func setUpFields() {
        if let ground = tournamentViewModel.currentGround {
            groundName.text = ground.groundName
            cityname.text = ground.city
            longitude.text = String(ground.longitude)
            latitude.text = String(ground.latitude)
            guard  let imageUrl = URL(string: (ground.groundPhoto as? String) ?? "" ) else {
                return
            }
            guard  let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            profileImage.image = UIImage(data: imageData)
        }
    }
    
    @IBAction func onClickCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    @IBAction func onClickSaveGround(_ sender: Any) {
        if validateFields(){
            let ground = Ground(groundName: groundName.text!, city: cityname.text!, groundLocation: cityname.text!, latitude: Double(latitude.text!)! , longitude: Double(longitude.text!)!, groundPhoto: profileImage.image, isSaved: false)
                tournamentViewModel.currentGround = ground
                tournamentViewModel.addGround{ success, message , error in
                    DispatchQueue.main.async {
                        if success {
                            self.clearFields()
                        } else {
                            alertAction(controller: self, message: error!.localizedDescription)
                        }
                    }
                }
            }
    }
    
    private func validateFields() -> Bool {
        var isValid = true
        if groundName.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter Ground Name")
        }
        if cityname.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter City Name")
        }
        if profileImage.image == nil {
            isValid = false
            alertAction(controller: self, message: "Select Ground Image")
        }
        if latitude.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter Latitude")
        } else {
            if Double(latitude.text!) == nil {
                isValid = false
                alertAction(controller: self, message: "Enter Valid Latitude")
            }
        }
        if latitude.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter Latitude")
        } else {
            if Double(latitude.text!) == nil {
                isValid = false
                alertAction(controller: self, message: "Enter Valid Latitude")
            }
        }
        if longitude.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter Longitude")
        } else {
            if Double(longitude.text!) == nil {
                isValid = false
                alertAction(controller: self, message: "Enter Valid Longitude")
            }
        }
        return isValid
    }
    
    private func clearFields() {
        groundName.text = ""
        cityname.text = ""
        latitude.text = ""
        longitude.text = ""
        profileImage.image = nil
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        tournamentViewModel.currentGround = nil
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddGroundViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        profileImage.image = fetchedImage
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
