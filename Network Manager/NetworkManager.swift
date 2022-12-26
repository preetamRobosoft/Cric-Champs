//
//  NetworkManager.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    func getData(url: String, parameters: [String: Any], headers: [String: String]?, image: UIImage?, completion: @escaping(Any? , Error?) -> Void) {
        
        let imageData = image?.jpegData(compressionQuality: 0.9)
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        for (key, value) in parameters {
            httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
        }
        
        if let image = imageData {
            httpBody.append(convertFileData(fieldName: "profilePhoto",
                                            
                                            fileName: "profile.jpeg",
                                            
                                            mimeType: "img/png",
                                            
                                            fileData: image,
                                            
                                            using: boundary))}
        
        httpBody.appendString("--\(boundary)--")
        
        request.httpBody = httpBody as Data
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data {
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                            completion(jsonData, nil)
                        } catch {
                            completion(nil, error)
                        }
                    }
                }
            }
            if error != nil {
                completion(nil,error)
            }
            
        }.resume()
        
    }
       
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        
        let data = NSMutableData()
        
        
        
        data.appendString("--\(boundary)\r\n")
        
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        
        data.append(fileData)
        
        data.appendString("\r\n")
        
        return data as Data
    }
    
    func convertFormField(named name: String, value: Any, using boundary: String) -> String {
        
        var fieldString = "--\(boundary)\r\n"
        
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        
        fieldString += "\r\n"
        
        fieldString += "\(value)\r\n"
        
        
        return fieldString
        
    }
    
    func postData(url: String, parameters: [String: Any], headers: [String: String]?, image: UIImage?, imageFieldName: String?, completion: @escaping(HTTPURLResponse, Any? , Error?) -> Void) {
        let imageData = image?.jpegData(compressionQuality: 0.9)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        
        for (key, value) in parameters {
            
            httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
            
        }
        
        if let image = imageData {
            httpBody.append(convertFileData(fieldName: imageFieldName ?? "",
                                            
                                            fileName: "profile.jpeg",
                                            
                                            mimeType: "img/png",
                                            
                                            fileData: image,
                                            
                                            using: boundary))}
        
        httpBody.appendString("--\(boundary)--")
        
        request.httpBody = httpBody as Data
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("DESCRIPTION", response.description)
                if let data = data {
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                        completion(response, jsonData, nil)
                    } catch {
                        completion(response, nil, nil)
                    }
                } else {
                    completion(response, nil, nil)
                }
                if error != nil {
                    print(error?.localizedDescription as Any)
                    completion(response, nil, error)
                }
            }
            
        }.resume()
        
    }
    
    func patchData(url: String, parameters: [String: Any], headers: [String: String]?, image: UIImage?, completion: @escaping(Int? , Error?) -> Void) {
        let imageData = image?.jpegData(compressionQuality: 0.9)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "PATCH"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        
        for (key, value) in parameters {
            
            httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
            
        }
        
        if let image = imageData {
            httpBody.append(convertFileData(fieldName: "profilePhoto",
                                            
                                            fileName: "profile.jpeg",
                                            
                                            mimeType: "img/png",
                                            
                                            fileData: image,
                                            
                                            using: boundary))}
        
        httpBody.appendString("--\(boundary)--")
        
        request.httpBody = httpBody as Data
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("RESPONSE",response.statusCode)
                completion(response.statusCode,nil)
            }
            if error != nil {
                print(error?.localizedDescription as Any)
                completion(nil,error)
            }
            
        }.resume()
        
    }
    
    func getTournamentData(url: String, headers: [String: String]?, completion: @escaping(([[String: Any]]?, Int , Error?) -> Void)) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { serviceData, serviceResponse, error in
            guard error == nil else { return }
            guard let response = serviceResponse as? HTTPURLResponse else { return }
            //print("Response", response.statusCode)
            let body = String(data: serviceData!, encoding: .utf8)
            //print("Response body: \(String(describing: body))")
            if response.statusCode == 200 {
                guard let tempData = serviceData else { return }
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments) as? [[String: Any]]{
                        completion(jsonData, response.statusCode, nil)
                    }
                } catch {
                    print("this failed")
                }
            } else {
                //print(response.statusCode)
                //if let response = response as? HTTPURLResponse {
                //print("Response", response.statusCode)
                    //let body = String(data: serviceData!, encoding: .utf8)
                    //print("Response body: \(String(describing: body))")
                //}
                if let tempError = error {
                    completion(nil, response.statusCode, tempError)
                } else {
                    completion(nil, response.statusCode, nil)
                }
                print("Server Error encountered")
            }
        }.resume()
    }
    
    func getTournamentOverViewData(url: String, headers: [String: String]?, completion: @escaping(([String: Any]?, Int , Error?) -> Void)) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { serviceData, serviceResponse, error in
            guard error == nil else { return }
            guard let response = serviceResponse as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let tempData = serviceData else { return }
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments) as? [String: Any]{
                        completion(jsonData, response.statusCode, nil)
                    }
                } catch {
                    print("this failed")
                }
            } else {
                if let tempError = error {
                    completion(nil, response.statusCode, tempError)
                }
                print("Server Error encountered")
            }
        }.resume()
    }
    
    func postLiveScore(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping(String, [String: Any]? , Error?, Int) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
              request.httpBody = data
            } catch {
              print("Error: cannot create JSON from data")
              return
            }
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                
                print("Response", response.statusCode)
                
                let body = String(data: data!, encoding: .nonLossyASCII)
                print("Response body: \(String(describing: body))")
                guard let tempData = data else { return }
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments) as? [String: Any] {
                        completion(body ?? "Undefined Error, Sorry Try Again", jsonData, nil, response.statusCode)
                    }
                } catch {
                    print("this failed")
                }
            }
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                completion("Undefined Error, Sorry Try Again", nil,error, 0)
            }
            
        }.resume()
    }
    
    
    func patchDateTime(url: String, parameters: [String: Any], headers: [String: String]?, image: UIImage?, completion: @escaping(String?, Int? , Error?) -> Void) {
        let imageData = image?.jpegData(compressionQuality: 0.9)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "PATCH"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        
        for (key, value) in parameters {
            
            httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
            
        }
        
        print(httpBody)
        if let image = imageData {
            httpBody.append(convertFileData(fieldName: "profilePhoto",
                                            
                                            fileName: "profile.jpeg",
                                            
                                            mimeType: "img/png",
                                            
                                            fileData: image,
                                            
                                            using: boundary))}
        
        httpBody.appendString("--\(boundary)--")
        
        request.httpBody = httpBody as Data
        
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let message = "\(String(data: data!, encoding: .ascii)!)"
            if let response = response as? HTTPURLResponse {
                
                print("Response", response.statusCode)
                
                
                
                
                completion(message, response.statusCode,nil)
                print("Response body: \(String(data: data!, encoding: .ascii)!)")
            }
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                completion(message, (response as? HTTPURLResponse)?.statusCode, error)
            }
            
        }.resume()
        
    }
    
    func getScoreBoardAPICall(url: String, headers: [String: String]?, completion: @escaping(String, [String: Any]? , Error?, Int) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { serviceData, serviceResponse, error in
            guard error == nil else { return }
            guard let response = serviceResponse as? HTTPURLResponse else { return }

            let body = String(data: serviceData!, encoding: .nonLossyASCII)
            print("Response body: \(String(describing: body))")
            if response.statusCode == 200 {
                guard let tempData = serviceData else { print("service data"); return }
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments) as? [String: Any]{
                        completion(body ?? "Undefined error", jsonData, nil, response.statusCode)
                    }
                } catch {
                    print("this failed")
                }
            } else {
                if let tempError = error {
                    completion(body ?? "Undefined error", nil , tempError, response.statusCode)
                }
                print("Server Error encountered")
            }
        }.resume()
        
    }
    
}

extension NSMutableData {
    
    func appendString(_ string: String) {
        
        if let data = string.data(using: .utf8) {
            
            self.append(data)
            
        }
        
    }
    
}









//
//extension Dictionary {
//
//    func percentEscaped() -> String {
//
//        return map { (key, value) in
//
//            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
//
//            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
//
//            return escapedKey + "=" + escapedValue
//
//        }
//
//        .joined(separator: "&")
//
//    }
//
//}
//
//extension CharacterSet {
//
//    static let urlQueryValueAllowed: CharacterSet = {
//
//        let generalDelimitersToEncode = ":#[]@"
//
//        let subDelimitersToEncode = "!$&'()*+,;="
//
//
//
//        var allowed = CharacterSet.urlQueryAllowed
//
//        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
//
//        return allowed
//
//    }()
//
//}
//
//func photoDataToFormData(data: Data, boundary: String, fileName: String) -> NSData {
//    var fullData = NSMutableData()
//
//    // 1 - Boundary should start with --
//    let lineOne = "--" + boundary + "\r\n"
//    fullData.append(lineOne.data(
//                        using: String.Encoding.utf8,
//        allowLossyConversion: false)!)
//
//    // 2
//    let lineTwo = "Content-Disposition: form-data;  name=\"profilePhoto\"; filename=\"" + fileName + "\"\r\n"
//    NSLog(lineTwo)
//    fullData.append(lineTwo.data(
//                        using: String.Encoding.utf8,
//        allowLossyConversion: false)!)
//
//    // 3
//    let lineThree = "Content-Type: image/jpeg\r\n\r\n"
//    fullData.append(lineThree.data(
//                        using: String.Encoding.utf8,
//        allowLossyConversion: false)!)
//
//    // 4
//    fullData.append(data)
//
//    // 5
//    let lineFive = "\r\n"
//    fullData.append(lineFive.data(
//                        using: String.Encoding.utf8,
//        allowLossyConversion: false)!)
//
//    // 6 - The end. Notice -- at the start and at the end
//    let lineSix = "--" + boundary + "--\r\n"
//    fullData.append(lineSix.data(
//                        using: String.Encoding.utf8,
//        allowLossyConversion: false)!)
//
//    return fullData
//}
