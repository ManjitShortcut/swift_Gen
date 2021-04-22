//
//  CustomTextField.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//

import Foundation
import UIKit
typealias TextFiledActionCallback = ((String) -> Void)

final class TextFiled: UITextField {
    fileprivate var textFiledActionCallBack: TextFiledActionCallback?
    @discardableResult func configure(placeHolder: String = "", isSeure: Bool = false, font: UIFont = Font.normarlFont, keyBoardType: UIKeyboardType = .default) -> Self {
        super.translatesAutoresizingMaskIntoConstraints = false
        super.placeholder = placeHolder
        super.font = font
        super.textColor = UIColor().textFieldTextColor
        super.keyboardType = keyboardType
        super.isSecureTextEntry = isSeure
        super.borderStyle = .none
        super.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return self
    }
    @discardableResult func returnKey(_ returnKeyBoard: UIReturnKeyType = .done) -> Self {
        super.returnKeyType = returnKeyBoard
        return self
    }
    @discardableResult func contentType(_ contentType: UITextContentType ) -> Self {
        super.textContentType = contentType
        return self
    }
}

// add action to textfiled
extension TextFiled: ActionTarget {
    typealias Callback = TextFiledActionCallback
    func action(handler:@escaping TextFiledActionCallback, forEvent controlEvent: UIControl.Event = .editingChanged) {
        if #available(iOS 14.0, *) {
            super.addAction(UIAction(handler: { (action) in
                if let newTextFiled = action.sender as? UITextField {
                    handler(newTextFiled.text ?? "")
                } else {
                    handler("")
                }
            }), for: controlEvent)
        } else {
            self.textFiledActionCallBack = handler
            super.addTarget(self, action: #selector(TextFiled.textFieldDidChange(_:)), for: controlEvent)
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textFiledActionCallBack?(textField.text ?? "")
    }
}
