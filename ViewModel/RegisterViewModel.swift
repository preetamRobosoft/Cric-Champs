//
//  RegisterViewModel.swift
//  Cricket
//
//  Created by Preetam G on 07/12/22.
//

import Foundation

class RegistrationViewModel {
    
    var currentUser = NewUser()
    var parameters: [String: Any] = [:]
    var password: String = ""
    var confirmPassword = ""
    let signUpURL = "\(baseURL)/sign-up"
    
    let logInURL = "\(baseURL)/login"
    var user: User?
    var headers: [String: String]? = [:]
    
    var currentUserEmail: String = ""
    var sendOTPURL = "\(baseURL)/send-otp"
    var verifyOTPURL = "\(baseURL)/verify"
    var sendOTPHeaders: [String: String] = [:]
    
    var otp: Int = 0
    var verifyOTPHeaders: [String: String] = [:]
    var verifyOTPParameters: [String: Int] = [:]
    
    func assignSendOTPHeader() {
        sendOTPHeaders["email"] = currentUserEmail
    }
    
    func assignVerifyOTPHeadersParameters() {
        verifyOTPHeaders["email"] = currentUserEmail
        verifyOTPParameters["otp"] = otp
        print(verifyOTPParameters)
    }
    
    func verifyOTP(completion: @escaping((Bool) -> Void)) {
        assignVerifyOTPHeadersParameters()
        print(verifyOTPParameters, "parmeters")
        print(verifyOTPHeaders, "headers")
        let networkManger = NetworkManager()
        networkManger.patchData(url: verifyOTPURL, parameters: verifyOTPParameters, headers: verifyOTPHeaders, image: nil) { (statusCode, error) in
            if error != nil {
                completion(false)
                print(error?.localizedDescription)
                return
            }
            
            if statusCode == 200 {
                print("Succcesfull otp verification")
                completion(true)
            }
        }
    }
    
    func sendOTP(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        assignSendOTPHeader()
        networkManger.postData(url: sendOTPURL, parameters: ["": ""], headers: sendOTPHeaders, image: nil) { (statusCode, error) in
            if error != nil {
                completion(false)
                return
            }
            
            if statusCode == 200 {
                print("OTP sent successfully")
                completion(true)
            }
        }
        
    }
    
    func assignCurrentUser(username: String, gender: String, email: String, phoneNumber: String?, city: String?, age: Int?, password: String) {
        currentUser.username = username
        currentUser.gender = gender
        currentUser.email = email
        currentUser.phoneNumber = phoneNumber
        currentUser.city = city
        currentUser.age = age
        currentUser.password = password
        assignParameters()
    }
    
    func assignHeaders() {
        guard let user = user else { return }
        headers!["email"] = user.emai
        headers!["password"] = user.password
    }
    
    func assignParameters() {
        parameters["username"] = currentUser.username
        parameters["gender"] = currentUser.gender
        parameters["email"] = currentUser.email
        if currentUser.phoneNumber?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            parameters.removeValue(forKey: "phoneNumber")
        } else {
            parameters["phoneNumber"] = "+91\(currentUser.phoneNumber!)"
        }
        parameters["city"] = currentUser.city
        parameters["age"] = currentUser.age
        parameters["password"] = currentUser.password
    }
    
    func registerCurrentUser(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        networkManger.postData(url: signUpURL, parameters: parameters, headers: nil, image: currentUser.profilePhoto) { (statusCode, error) in
            if error != nil {
                completion(false)
                return
            }
            
            if statusCode == 200 {
                print("Successful registration")
                completion(true)
            } else {
                print(statusCode,"Status code")
                completion(false)
            }
        }
    }
    
    func logInUser(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        networkManger.postData(url: logInURL, parameters: ["": ""], headers: headers, image: nil) { (statusCode, error) in
            if error != nil {
                completion(false)
                return
            }
            
            if statusCode == 200 {
                print("Succcesfull login")
                completion(true)
            }
        }
    }
}
