//
//  UIViewControllerExtension.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/26.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style, delay: TimeInterval = 1) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        self.present(alertController, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dismissAlert(_ :)), userInfo: alertController, repeats: false)
    }
    
    @objc
    private func dismissAlert(_ timer: Timer) {
        let alertController = timer.userInfo as! UIAlertController
        alertController.dismiss(animated: true, completion: nil)
    }
}
