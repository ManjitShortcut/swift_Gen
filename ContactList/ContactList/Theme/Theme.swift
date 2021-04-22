//
//  Theme.swift
//  DNB_TASK
//
//  Created by Manjit on 27/03/2021.
//

import Foundation
import UIKit

struct Theme {
    static let loginTheme: LoginTheme = LoginTheme()
}

protocol DefaultConfig {
    var backGroundColor: UIColor { get }
    var textDisPlayColor: UIColor { get }
}
extension DefaultConfig {
    var backGroundColor: UIColor {
        UIColor().backGroundColor
    }
    var textDisPlayColor: UIColor {
        UIColor().textDisplayColor
    }
}
struct LoginTheme: DefaultConfig {
    let  spacing: LoginPageSpacing = LoginPageSpacing()
    let  font: LoginPageFont =  LoginPageFont()
    let textColor = UIColor().textFieldTextColor
}
// login spacing
struct LoginPageSpacing {
    let loginViewMargin: CGFloat = 25.0
    let verticalSpacingItem: CGFloat = 3
    let verticalSpacingGroup: CGFloat = 25
    let horizontalSpacing: CGFloat = 8
}
// TODO: will impliment in future
struct LoginPageFont {
    
}

struct FavoritListTheme: DefaultConfig {
    let backgroundColor = UIColor().backGroundColor
    let marign:CGFloat = 0

}
struct  UserListTheme: DefaultConfig {
    let marign:CGFloat = 0
}
