//
//  OTPVerificationVC.swift
//  Cricket
//
//  Created by Preetam G on 09/12/22.
//

import UIKit

protocol ResetPassword {
    func showSetPasswordView()
}

class OTPVerificationVC: UIViewController {

    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    var registerVM: RegistrationViewModel?
    var isForgotPassword = false
    var resetPasswordDelagate: ResetPassword?

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.verifyButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
    }
    
    @IBAction func onVerifyButtonClick(_ sender: Any) {
        if isForgotPassword {
            otpVerificationForResetPassword()
        } else {
            otpVerificationForRegistration()
        }
    }
    
    private func otpVerificationForRegistration() {
        guard let vc = storyboard?.instantiateViewController(identifier: "SuccessFailViewController") as? SuccessFailViewController else {alertAction(controller: self, message: "Retry registration");return}
        guard let currentEmail = registerVM?.currentUser.email else {
            vc.didSuccessfullyRegister = false
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        registerVM?.currentUserEmail = currentEmail
        registerVM?.otp = Int(otpTextField.text ?? "055111") ?? 055111
        registerVM?.verifyOTP(completion: { _ in print("otp verified")})
        DispatchQueue.main.async {
            vc.didSuccessfullyRegister = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func otpVerificationForResetPassword() {
        guard let currentEmail = registerVM?.currentUserEmail else {
            return
        }
        registerVM?.currentUserEmail = currentEmail
        registerVM?.otp = Int(otpTextField.text ?? "055111") ?? 055111
        registerVM?.resetPasswordOtpVerification { isSucces in
            DispatchQueue.main.async {
                if isSucces {
                    self.resetPasswordDelagate?.showSetPasswordView()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Failed Rset Verification")
                    //Add Action
                }
            }
        }
        
    }
    
    @IBAction func resendOTPButton(_ sender: Any) {
        if !isForgotPassword {
            registerVM?.sendOTP(completion: { (isSuccess) in
            print("resent OTP")
            })
        } else {
            registerVM?.resetPassword(completion: {
                (isSuccess) in
                print("resent OTP")
            })
        }
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
