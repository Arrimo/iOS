//
//  Auth.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/19/21.
//

import Alamofire
import Foundation
import SwiftKeychainWrapper

extension APIManager {
    
    func signInCaretaker(email: String, password: String, completion: @escaping (Bool, String?) -> ()) {
        let url = URL(string: "https://arrimo-api-dev.azurewebsites.net/auth/caretaker/login")
        let parameters = "{\n    \"email\": \"\(email)\",\n    \"password\": \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("TiPMix=41.0795238991638; x-ms-routing-name=self", forHTTPHeaderField: "Cookie")
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(false, error!.localizedDescription)
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if let parsedJson = json {
                        if let token = parsedJson["access_token"] as? String {
                            print("Access Token: \(token)")
                            DispatchQueue.main.async {
                                KeychainWrapper.standard.set(token, forKey: "accessToken")
                                KeychainWrapper.standard.set("userId", forKey: "userId")
                                completion(true, "Success")
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(false, "Incorrect email or password")
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false, "Could not successfully perform this request. Please try again later.")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, "Could not successfully perform this request. Please try again later.")
                    }
                }
            }
        }
        task.resume()
    }
    
    func sendPasswordResetLink(withEmail email: String, completion: @escaping (Bool, String?) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)
        let parameters = "{\n    \"email\": \"\(email)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://arrimo-api-dev.azurewebsites.net/caretakers/forgot-password")!,timeoutInterval: Double.infinity)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error!.localizedDescription)
                }
                semaphore.signal()
                return
            }
            semaphore.signal()
            completion(true, String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        semaphore.wait()
    }
    
    func changePassword(currentPassword: String, newPassword: String, completion: @escaping (Bool, String?) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)
        let parameters = "{\n    \"email\": \"\(RunningInfo.shared.caretaker!.email!)\",\n    \"currentPassword\": \"\(currentPassword)\",\n    \"newPassword\": \"\(newPassword)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://arrimo-api-dev.azurewebsites.net/caretakers/change-password")!,timeoutInterval: Double.infinity)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("TiPMix=88.2382550222046; x-ms-routing-name=self", forHTTPHeaderField: "Cookie")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error!.localizedDescription)
                }
                semaphore.signal()
                return
            }
            DispatchQueue.main.async {
                completion(true, String(data: data, encoding: .utf8) ?? "Password changed".localized())
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()

    }
    
}
