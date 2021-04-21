//
//  UIViewController.swift
//  Arrimo
//
//  Created by JJ Zapata on 4/19/21.
//

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
    
}
