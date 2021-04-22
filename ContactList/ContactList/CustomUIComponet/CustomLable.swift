//
//  CustomLable.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//

import Foundation
import UIKit

final class CustomLable: UILabel {
    @discardableResult func configureLable(name: String = "", color: UIColor = UIColor().textDisplayColor, font: UIFont = Font.normarlFont) -> Self {
        super.translatesAutoresizingMaskIntoConstraints = false
        super.frame = CGRect.zero
        super.textColor = color
        super.font = font
        super.text = name
        return self
    }
    // you can overide all property
    //

//     override var textColor: UIColor? {
//        get{ return super.textColor}
//        set{
//            super.textColor = foregroundColor
//        }
//    }
    // yiu can over ride font and back ground color also
//    override var font: UIFont! {
//        get{return super.font}
//        set {
//        }
//    }
//    private var normalFont: UIFont?
//      didSet {
//
//    }
}
