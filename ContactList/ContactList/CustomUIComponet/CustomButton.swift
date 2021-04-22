//
//  CustomButton.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//
import Foundation
import UIKit
typealias BtnActionCallback = (() -> Void)

final class Button: UIButton {
    fileprivate var btnActionCallBack: BtnActionCallback?
    func configure(title: String = "", backGroundImage: UIImage? = nil, image: UIImage? = nil) ->  Self {
        super.translatesAutoresizingMaskIntoConstraints = false
        super .setTitle(title, for: .normal)
        super .setTitle(title, for: .highlighted)
        super .setTitle(title, for: .selected)
        super .setTitleColor(UIColor.black, for: .normal)
        super .setTitleColor(UIColor.black, for: .selected)
        super .setTitleColor(UIColor.black, for: .highlighted)
        if let image = image {
            super.setImage(image, for: .normal)
            super.setImage(image, for: .highlighted)
            super.setImage(image, for: .selected)
        }
        if let image = backGroundImage {
            super.setBackgroundImage(image, for: .normal)
            super.setBackgroundImage(image, for: .highlighted)
            super.setBackgroundImage(image, for: .selected)
        }
        super.titleLabel?.font =  Font.boldFont
        return self
    }
    func setFont( font: UIFont = Font.boldFont )->  Self {
        super.titleLabel?.font =  font
        return self
    }
    
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            super.layer.cornerRadius = cornerRadius
            super.clipsToBounds = true
            super.layer.masksToBounds = true
        }
    }
}

// add action to button
extension Button: ActionTarget {
    typealias Callback = BtnActionCallback
    func action(handler: @escaping BtnActionCallback, forEvent controlEvent: UIControl.Event = .touchUpInside) {
        if #available(iOS 14.0, *) {
            super.addAction(UIAction(handler: { (_) in
                handler()
            }), for: .touchUpInside)
        } else {
            btnActionCallBack = handler
            super.addTarget(self, action: #selector(triggerActionHandleBlock), for: controlEvent)
        }
    }
    @objc private func triggerActionHandleBlock() {
        btnActionCallBack?()
    }
}
