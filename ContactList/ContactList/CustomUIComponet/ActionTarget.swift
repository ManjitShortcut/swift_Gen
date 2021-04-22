//
//  ActionTarge.swift
//  DNB_TASK
//
//  Created by Manjit on 28/03/2021.
//

import Foundation
import UIKit
// this protocol is basically used for add action to textfiled and button
// you can also add it to slider and switch
protocol ActionTarget {
 associatedtype Callback
    func action(handler: Callback, forEvent controlEvent: UIControl.Event)
}
