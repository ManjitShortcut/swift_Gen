//
//  ViewController+Extension.swift
//  DNB_TASK
//
//  Created by Manjit on 04/04/2021.
//

import Foundation

protocol ViewControllerIntilization {
    associatedtype Theme
    associatedtype ViewModel
    var theme: Theme { get set }
    var viewModel: ViewModel { get set }
    func designUI()    
}
