//
//  AlertPopOver.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//

import Foundation
import UIKit

extension UIViewController {
    // show alert with ok button  and title 
    // alert
    func alert(alertTitle: String, withMessage message: String, okAction: @escaping () -> Void = {}, buttonText: String) {
        let alertStyle = UIAlertController.Style.alert
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: alertStyle)
         let ationStyle = UIAlertAction.Style.default
         alert.addAction(UIAlertAction(title: buttonText, style: ationStyle, handler: { _ in
            okAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
