//
//  PasswordViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//

import UIKit

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var setPasswordView: UIView!
    @IBOutlet weak var forgotPassword: UIView!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var isForgotPassword = false
    var isResetPassword = false
    var currentViewModel: RegistrationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        
        _ = self.proceedButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
        
        if isForgotPassword {
            setUpForgotPassword()
            
        } else {
            setUpSetPassword()
        }
    }
    func setUpSetPassword() {
        setPasswordView.isHidden = false
        forgotPassword.isHidden = true
    }
    
    func setUpForgotPassword() {
        setPasswordView.isHidden = true
        forgotPassword.isHidden = false
    }
    
    @IBAction func passEyeButtonTapped(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func rePassEyeTapped(_ sender: Any) {
        if confirmPasswordTextField.isSecureTextEntry {
            confirmPasswordTextField.isSecureTextEntry = false
        } else {
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onProceedTapped(_ sender: Any) {
        if isForgotPassword {
            onProceedClickForForgotPassword()
        } else {
            onProceedClickForSetUpPassword()
        }
            
    }
    
    func onProceedClickForSetUpPassword() {
        currentViewModel?.password = passwordTextField.text!
        currentViewModel?.confirmPassword = confirmPasswordTextField.text!
        
        guard passwordMatchValidation(password: currentViewModel!.password  , rePassword: currentViewModel!.confirmPassword) else {
            alertAction(controller: self, message: "Password Doesn't Match")
            print("password doesnt match")
            return
        }
        if isResetPassword {
            setNewPassword()
        } else {
            registerUser()
        }
    }
    
    private func registerUser(){
        guard let password = currentViewModel?.password else {return}
        currentViewModel?.currentUser.password = password
        currentViewModel?.assignParameters()
        currentViewModel?.registerCurrentUser { isSuccess in
            if isSuccess {
                print("Successful registraion")
                self.currentViewModel?.currentUserEmail = (self.currentViewModel?.currentUser.email)!
                self.currentViewModel?.sendOTP() { didSendOTP in
                    if didSendOTP {
                        print("OTP Sent")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    guard let vc =  self.storyboard?.instantiateViewController(identifier: "SuccessFailViewController") as? SuccessFailViewController
                    else {
                        return
                    }
                    vc.didSuccessfullyRegister = false
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
        let otpVC = storyboard?.instantiateViewController(identifier: "OTPVerificationVC") as! OTPVerificationVC
        otpVC.registerVM = currentViewModel
        navigationController?.pushViewController(otpVC, animated: true)
    }
    
    private func setNewPassword() {
        currentViewModel?.password = passwordTextField.text!
        currentViewModel?.setnewPassword{ isSuccess in
            if isSuccess {
                print("Sucess")
            }
            
        }
    }
    
    private func resetPassword() {
        currentViewModel?.password = passwordTextField.text!
        currentViewModel?.setnewPassword { isSuccess in
            if isSuccess {
                print("Successful Password Updation")
            } else {
                print("RESET FAILED")
            }
        }
    }
    
    func onProceedClickForForgotPassword() {
        if let email = emailTextField.text, email != ""{
            currentViewModel?.currentUserEmail = email
        }
        currentViewModel?.resetPassword { isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    let otpVC = self.storyboard?.instantiateViewController(identifier: "OTPVerificationVC") as! OTPVerificationVC
                    otpVC.isForgotPassword = true
                    otpVC.resetPasswordDelagate = self
                    otpVC.registerVM = self.currentViewModel
                    self.navigationController?.pushViewController(otpVC, animated: true)
                } else {
                    print("ERROR")
                }
            }
        }
    }
}


extension PasswordViewController: ResetPassword {
    func showSetPasswordView() {
        self.isResetPassword = true
        self.isForgotPassword = false
        setUpSetPassword()
        
    }
}
