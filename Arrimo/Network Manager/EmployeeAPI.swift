//
//  EmployeeAPI.swift
//  Arrimo
//
//  Created by JJ Zapata on 9/10/21.
//

import SwiftKeychainWrapper
import Foundation
import UIKit
import JWTDecode    

final class EmployeeAPI {
    
    static let shared = EmployeeAPI()
    
    func fetchEmployeeInformation(onCompletion: @escaping (Employee) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)
        if let key = KeychainWrapper.standard.string(forKey: "accessToken") {
            do {
                let jwt = try JWTDecode.decode(jwt: key)
                guard let id = jwt.subject else {
                    print("error parsing access token to id")
                    return
                }
                var request = URLRequest(url: URL(string: "https://arrimo-api-dev.azurewebsites.net/employees/\(id)")!,timeoutInterval: Double.infinity)
                request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
                request.addValue("TiPMix=99.5416878254813; x-ms-routing-name=self", forHTTPHeaderField: "Cookie")
                request.httpMethod = "GET"
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print("Error: \(String(describing: error))")
                        semaphore.signal()
                        return
                    }
                    print(String(data: data, encoding: .utf8)!)
                    do {
                        guard let employee = try? JSONDecoder().decode(Employee.self, from: data) else {
                            print("Error parsing JSON")
                            return
                        }
                        onCompletion(employee)
                    }
                    semaphore.signal()
                }
                
                task.resume()
                semaphore.wait()
            } catch let error {
                print("error fetching id: \(error.localizedDescription)")
                return
            }
        } else  {
            print("error finding access token")
            return
        }
    }
    
}
