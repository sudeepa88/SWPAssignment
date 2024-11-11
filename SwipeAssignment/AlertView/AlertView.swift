//
//  AlertView.swift
//  SwipeAssignment
//
//  Created by Sudeepa Pal on 11/11/24.
//

import UIKit

class AlertView: NSObject {
    static func showAlert(_ title: String, message: String, okTitle: String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        if let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            presentedViewController.present(alert, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

}
