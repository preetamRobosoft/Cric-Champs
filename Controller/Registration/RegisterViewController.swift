//
//  RegisterViewController.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var maleGender: RadioButton!
    @IBOutlet weak var femaleGender: RadioButton!
    @IBOutlet weak var customProfileView: ProfilePhotoImageView!
    @IBOutlet weak var triangleView: TriangleView!
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    let registerVM = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setCornerRadius()
        configureButtons()
        customProfileView.setRadius()
    }
    
    func configureButtons() {
        
        _ = self.proceedButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
    }
    
    @IBAction func genderButtonTapped(_ sender: RadioButton) {
        sender.changeButtonsStatus(sender: sender, buttons: [maleGender, femaleGender])
        registerVM.currentUser.gender = sender.title(for: .normal)!.trimmingCharacters(in: .whitespaces)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onClickCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    @IBAction func onRegisterTapped(_ sender: Any) {
        
        guard areValidFields() else { return }
        let passwordVC = self.storyboard?.instantiateViewController(identifier: "PasswordViewController") as! PasswordViewController
        self.navigationController?.pushViewController(passwordVC, animated: true)
        passwordVC.isForgotPassword = false
        passwordVC.currentViewModel = self.registerVM
        
    }
    
    func areValidFields() -> Bool {
        guard let name = nameTextField.text else {
            alertAction(controller: self, message: "Name field is Empty")
            print("empty username")
            return false
        }
        
        guard let email = emailTextField.text else {
            alertAction(controller: self, message: "Email field is Empty")
            print("empty email")
            return false
        }
        
        guard isValidEmail(email: email) else {
            alertAction(controller: self, message: "Email is invalid")
            print("invalid email")
            return false
        }
        guard let phone = phoneTextField.text else {
            alertAction(controller: self, message: "Phone Number can't be empty")
            print("empty phone")
            return false
        }
        
        let newPhone = phone.trimmingCharacters(in: .whitespaces)
        
        if newPhone.count != 10 && isStringNumeric(string: newPhone) {
            alertAction(controller: self, message: "Invalid phone number")
            return false
        }
        
        registerVM.currentUser.username = name
        registerVM.currentUser.email = email
        registerVM.currentUser.phoneNumber = newPhone
        print(newPhone)
        
        return true
    }
    
}


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        profileImage.image = fetchedImage
        registerVM.currentUser.profilePhoto = fetchedImage
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
