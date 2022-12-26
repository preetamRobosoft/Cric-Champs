//
//  Validation.swift
//  Cricket
//
//  Created by Preetam G on 07/12/22.
//

import Foundation
import UIKit

public func passwordMatchValidation(password: String, rePassword: String) -> Bool {
    
    if password.trimmingCharacters(in: .whitespacesAndNewlines) != rePassword.trimmingCharacters(in: .whitespacesAndNewlines) {
        
        return false
        
    } else {
        
        return true
        
    }
    
}

public func isValidPassword(password: String) -> Bool {
    
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=])[A-Za-z\\d$@$!%*?&#]{8,10}"
    
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    
}


public func isValidEmail(email: String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    return emailPred.evaluate(with: email)
}

func isStringNumeric(string: String) -> Bool {
    let nums = CharacterSet.decimalDigits.inverted
    return string.rangeOfCharacter(from: nums) == nil
}

func alertAction(controller: UIViewController, message: String) {

    let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

    controller.present(alert, animated: true, completion: nil)

}

func showAlert(controller: UIViewController, title: String, message: String, handlerOK:((UIAlertAction) -> Void)?, handlerCancel: ((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if handlerCancel != nil {
        let action = UIAlertAction(title: "OK", style: .default, handler: handlerOK)
        let (actionCancel) = UIAlertAction(title: "Cancle", style: .destructive, handler: handlerCancel)
        alert.addAction(actionCancel)
        alert.addAction(action)
    } else {
        let action = UIAlertAction(title: "OK", style: .default, handler: handlerOK)
        alert.addAction(action)
    }
    DispatchQueue.main.async {
        controller.present(alert, animated: true, completion: nil)
    }
}
