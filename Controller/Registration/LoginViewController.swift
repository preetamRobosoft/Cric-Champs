//
//  LoginViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//

import UIKit

protocol LoggedUser {
    func sendLoggedUser(user: User)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    let loginVM = RegistrationViewModel()
    var loginDelagate: LoggedUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        _ = self.loginButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
    }
    
    @IBAction func onRegisterTapped(_ sender: Any) {

            let registerVC = storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController

            navigationController?.pushViewController(registerVC, animated: true)

        }
    
    @IBAction func backButtonTapped(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
    @IBAction func onClickPasswordShow(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "PasswordViewController") as! PasswordViewController
        vc.isForgotPassword = true
        vc.currentViewModel = loginVM
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onLogInTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            alertAction(controller: self, message: "Email Field is empty")
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            alertAction(controller: self, message: "Password Field is empty")
            return
        }
        
        loginVM.user = User(email: email, password: password, name: nil, photo: nil)
        loginVM.assignHeaders()
        loginVM.logInUser { (user, message, error) in
            DispatchQueue.main.async{
                if let user = user {
                    self.loginDelagate?.sendLoggedUser(user: user)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    alertAction(controller: self, message: message ?? "Unknown Error")
                }
            }
        }
    }
}
