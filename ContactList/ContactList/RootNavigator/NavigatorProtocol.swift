//
//  Navigator.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//

import Foundation
import UIKit

typealias CompletionNavigation = (() -> Void)

enum Poptype {
    case root
    case previous
}
protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination, withComplition completion: CompletionNavigation)
    func pop(to type: Poptype, withComplition completion: CompletionNavigation)
}
