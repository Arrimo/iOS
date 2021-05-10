//
//  UIViewController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/19/21.
//

import CoreLocation
import MBProgressHUD
import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Haptic Feedback
    
    func add3DMotion(withFeedbackStyle style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred(intensity: 1.0)
    }
    
    func addErrorNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
    }
    
    func addSuccessNotification() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
    }
    
    // MARK: - Dialog
    
    func showLoading() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // MARK: - Alerts
    
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Segues
    
    func passNavigationTo(nextViewController viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func sendToPauseScreen(withAction action: String) {
        let controller = PauseController()
        controller.action = action
        controller.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Logistics
    
    func sendJSON(action: String, long: Double, lat: Double, user: Patient?, caretaker: Caretaker?, tasks: [Task]?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.mm.yyyy HH:MM:SS"
        let params : [String : Any] = [
            "id" : "CareTakerID",
            "clientId" : "CLIENT ID",
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
