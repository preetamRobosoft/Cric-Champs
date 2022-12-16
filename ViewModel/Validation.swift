//
//  Validation.swift
//  Cricket
//
//  Created by Preetam G on 07/12/22.
//

import Foundation
import UIKit

public func passwordMatchValidation(password: String, rePassword: String) -> Bool {
    
    if password != rePassword {
        
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

func validateMobileNumber(number: String) -> Bool {
    
    let phoneRegEx = "^[+91][0-9]{10}$"
    
    let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)

    return phonePred.evaluate(with: number)

}

func alertAction(controller: UIViewController, message: String) {

    let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

    controller.present(alert, animated: true, completion: nil)

}
