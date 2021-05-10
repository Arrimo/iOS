//
//  API.swift
//  Arrimo
//
//  Created by JJ Zapata on 5/10/21.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func postRequest(parameters: [String: Any], completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://www.myserver.com/api/login") ?? URL(string: "https://www.google.com")
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                print(json)
                completion(json, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        })
        task.resume()
    }
}
