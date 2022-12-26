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
    //var verifyOTPParameters: [String: Int] = [:]
    
    var resetPasswordUrl = "\(baseURL)/forgot-password"
    var resetPasswordOtpVerification = "\(baseURL)/reset"
    var resetPasswordVerifyOTPHeaders: [String: String] = [:]
    var newPasswordHeader: [String: String] = [:]
    var setNewPasswordUrl = "\(baseURL)/reset-password"

    
    //var currentLogedToken = ["Authorization": ""]
    
    func assignSendOTPHeader() {
        sendOTPHeaders["email"] = currentUserEmail
    }
    
    func assignVerifyOTPHeadersParameters() {
        verifyOTPHeaders["email"] = currentUserEmail
        verifyOTPHeaders["otp"] = String(otp)
    }
    
    func assignresetPasswordVerifyOTPHeaders() {
        resetPasswordVerifyOTPHeaders["email"] = currentUserEmail
        resetPasswordVerifyOTPHeaders["otp"] = String(otp)
    }
    
    func verifyOTP(completion: @escaping((Bool) -> Void)) {
        assignVerifyOTPHeadersParameters()
        let networkManger = NetworkManager()
        networkManger.patchData(url: verifyOTPURL, parameters: ["":""], headers: verifyOTPHeaders, image: nil) { (statusCode, error) in
            if error != nil {
                completion(false)
                print(error?.localizedDescription as Any)
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
        networkManger.postData(url: sendOTPURL, parameters: ["": ""], headers: sendOTPHeaders, image: nil, imageFieldName: nil) { (response, data, error) in
            if error != nil {
                completion(false)
                return
            }
            
            if response.statusCode == 200 {
                print("OTP sent successfully")
                completion(true)
            }
        }
        
    }
    
    func resetPassword(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        assignSendOTPHeader()
        networkManger.patchData(url: resetPasswordUrl, parameters: ["":""], headers: sendOTPHeaders, image: nil){ (response, error) in
            if error != nil {
                completion(false)
                return
            }
            if response == 200 {
                print("OTP sent successfully")
                completion(true)
            }
        }
    }
    
    func resetPasswordOtpVerification(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        assignresetPasswordVerifyOTPHeaders()
        networkManger.patchData(url: resetPasswordOtpVerification, parameters: ["":""], headers: resetPasswordVerifyOTPHeaders, image: nil){ (response, error) in
            if error != nil {
                completion(false)
                return
            }
            if response == 200 {
                print("OTP sent successfully")
                completion(true)
            }
        }
    }
    
    func setnewPassword(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        assignHeadersForSetNewPassword()
        print(newPasswordHeader)
        networkManger.patchData(url: setNewPasswordUrl, parameters: ["":""], headers: newPasswordHeader, image: nil){ (response, error) in
            if error != nil {
                completion(false)
                return
            }
            if response == 200 {
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
        headers!["email"] = user.email
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
    
    func assignHeadersForSetNewPassword() {
        newPasswordHeader["email"] = currentUserEmail
        newPasswordHeader["newPassword"] = password
        
    }

    
    func registerCurrentUser(completion: @escaping((Bool) -> Void)) {
        let networkManger = NetworkManager()
        networkManger.postData(url: signUpURL, parameters: parameters, headers: nil, image: currentUser.profilePhoto, imageFieldName: "profilePhoto") { (response, data, error) in
            if error != nil {
                completion(false)
                return
            }

            if response.statusCode == 200 {
                print("Successful registration")
                completion(true)
            } else {
                print(response.statusCode as Any,"Status code")
                completion(false)
            }
        }
    }
        
    func logInUser(completion: @escaping((User?,String?, Error?) -> Void)) {
        let networkManger = NetworkManager()
        networkManger.postData(url: logInURL, parameters: ["": ""], headers: headers, image: nil, imageFieldName: nil) { (response, data, error) in
                if error != nil {
                    completion(nil,nil, error)
                    return
                }
                if response.statusCode == 200 {
                    if let data = data as? [String: Any] {
                    let user = self.fetchLoggedUserData(response: response, data: data)
                    completion(user,nil, nil)
                    }
                }
                if response.statusCode == 406 {
                    if let data = data as? [String: Any] {
                        completion(nil, data["Error Message "] as? String, nil)
                    }
                }
            }
    }
    
    func fetchLoggedUserData(response: HTTPURLResponse, data: [String: Any]) -> User{
        var authorizationToken = ""
        var email = ""
        var name = ""
        var profile = ""
        if let header = response.allHeaderFields as NSDictionary as? [String: Any] {
            if let token = header["Authorization"] as? String {
                authorizationToken = token
            }
        }
        if let mail = data["email"] as? String {
            email = mail
        }
        if let username = data["username"] as? String {
            name = username
        }
        if let photoUrl = data["email"] as? String {
            profile = photoUrl
        }
        print(authorizationToken)
        
        let user = User(email: email, password: "password", name: name, photo: profile, authorization: authorizationToken)
        return user
    }
}
