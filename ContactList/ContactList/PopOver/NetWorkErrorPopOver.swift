//
//  ErrorPopOver.swift
//  DNB_TASK
//
//  Created by Manjit on 01/04/2021.
//

import Foundation
import UIKit
extension UIViewController {
    // show network error alert, wirk complition handler
    // okAction: @escaping () -> Void = {} if you want any action on the ok button
    func showNetworkError(_ error: NetworkError, okAction: @escaping () -> Void = {}) {
        self.alert(alertTitle: "Error!", withMessage: error.errorMessage, okAction: {
            okAction()
        }, buttonText: "Ok")
    }
    
}
