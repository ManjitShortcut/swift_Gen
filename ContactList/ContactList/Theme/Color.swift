//
//  Theme.swift
//  DNB_TASK
//
//  Created by Manjit on 27/03/2021.
//

import Foundation
import UIKit

protocol CustomColor {
    var backGroundColor: UIColor { get }
    var textFieldTextColor: UIColor { get }
    var separatorColor: UIColor{get}
}
extension UIColor: CustomColor {
    public var backGroundColor: UIColor {
        return  UIColor(named: "backgroundColor") ?? UIColor.white
    }
    public var textFieldTextColor: UIColor {
        return  UIColor(named: "textFieldTextColor") ?? UIColor.black
    }
    public var separatorColor: UIColor {
        return  UIColor(named: "separatorColor") ?? UIColor.black
    }
    public var textDisplayColor: UIColor {
        return  UIColor(named: "textDisplayColor") ?? UIColor.black
    }
    // func convert color from hex to color
}
