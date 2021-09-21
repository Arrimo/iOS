//
//  EmployeeAPI.swift
//  Arrimo
//
//  Created by JJ Zapata on 9/10/21.
//

import SwiftKeychainWrapper
import Foundation
import UIKit

final class EmployeeAPI {
    
    static let shared = EmployeeAPI()
    
    func fetchEmployeeInformation(onCompletion: @escaping (Employee) -> ()) {
        
        let semaphore = DispatchSemaphore (value: 0)
        let key = KeychainWrapper.standard.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: "https://arrimo-api-dev.azurewebsites.net/employees/b2a38764-a4aa-414e-bc3f-f9a7c4e56ccf")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.addValue("TiPMix=99.5416878254813; x-ms-routing-name=self", forHTTPHeaderField: "Cookie")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            do {
                guard let employee = try? JSONDecoder().decode(Employee.self, from: data) else {
                    print("error employee")
                    return
                }
                onCompletion(employee)
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
            print("success")
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
