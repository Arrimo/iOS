//
//  AppDelegate.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/15/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setNavigationBarDefaults()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func setNavigationBarDefaults() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.tekturBold(size: 17)!, NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    private func sendJSON(action: String, long: Double, lat: Double, user: String?, caretaker: String?, tasks: [Task]?) {
        let formatter = ISO8601DateFormatter()
        let params : [String : Any] = [
            "caretaker" : "\(String(describing: caretaker ?? "nil"))",
            "patient" : "\(String(describing: user ?? "nil"))",
            "time" : formatter.string(from: Date()),
            "action" : action,
            "lat" : lat,
            "long" : long
//            "tasks" : json!
        ]
        print(params)
//        APIManager.shared.postRequest(parameters: params) { result, error in
//            if let result = result {
//                print("success: \(result)")
//            } else if let error = error {
//                print("error: \(error.localizedDescription)")
//                self.simpleAlert(title: "Error", message: error.localizedDescription)
//            }
//        }
    }


}

