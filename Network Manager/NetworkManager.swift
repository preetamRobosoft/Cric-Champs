//
//  NetworkManager.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    func getData(url: URL, completion: @escaping ([String: Any]?, Error? ) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { recievedData, response, error in
            if let data = recievedData {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                    if let apidata = jsonData {
                        completion(apidata, nil)
                        print("Response body: \(String(data: data, encoding: .utf8)!)")
                    }
                } catch {
                    completion(nil,error)
                }
            }
            else {
                completion(nil, error)
            }
        }
        task.resume()
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
    
    
    func postData(url: String, parameters: [String: Any], headers: [String: String]?, image: UIImage?, completion: @escaping(Int? , Error?) -> Void) {
        print(parameters, headers)
        let imageData = image?.jpegData(compressionQuality: 0.9)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
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
            
            if let response = response as? HTTPURLResponse {
                
                print("Response", response.statusCode)
                
                
                completion(response.statusCode,nil)
                print("Response body: \(String(data: data!, encoding: .utf8)!)")
            }
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                completion(nil,error)
            }
            
        }.resume()
        
    }
    
    func patchData(url: String, parameters: [String: Any], headers: [String: String]?, image: UIImage?, completion: @escaping(Int? , Error?) -> Void) {
        print(parameters, headers)
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
            
            if let response = response as? HTTPURLResponse {
                
                print("Response", response.statusCode)
                
                
                completion(response.statusCode,nil)
                print("Response body: \(String(data: data!, encoding: .utf8)!)")
            }
            
            if error != nil {
                
                print(error?.localizedDescription as Any)
                completion(nil,error)
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

extension Dictionary {

    func percentEscaped() -> String {

        return map { (key, value) in

            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""

            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""

            return escapedKey + "=" + escapedValue

        }

        .joined(separator: "&")

    }

}

extension CharacterSet {

    static let urlQueryValueAllowed: CharacterSet = {

        let generalDelimitersToEncode = ":#[]@"

        let subDelimitersToEncode = "!$&'()*+,;="



        var allowed = CharacterSet.urlQueryAllowed

        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return allowed

    }()

}

func photoDataToFormData(data: Data, boundary: String, fileName: String) -> NSData {
    var fullData = NSMutableData()
    
    // 1 - Boundary should start with --
    let lineOne = "--" + boundary + "\r\n"
    fullData.append(lineOne.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 2
    let lineTwo = "Content-Disposition: form-data;  name=\"profilePhoto\"; filename=\"" + fileName + "\"\r\n"
    NSLog(lineTwo)
    fullData.append(lineTwo.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 3
    let lineThree = "Content-Type: image/jpeg\r\n\r\n"
    fullData.append(lineThree.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 4
    fullData.append(data)
    
    // 5
    let lineFive = "\r\n"
    fullData.append(lineFive.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 6 - The end. Notice -- at the start and at the end
    let lineSix = "--" + boundary + "--\r\n"
    fullData.append(lineSix.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    return fullData
}
