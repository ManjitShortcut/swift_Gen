//
//  UIViewControllExtension.swift
//  DNB_TASK
//
//  Created by Manjit on 26/03/2021.
//
import UIKit
extension UIView {
    func center(to view: UIView, verticalConst: CGFloat = 0, horizontalConst: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: horizontalConst)
        ])
    }
    func setMargin(to view: UIView,  leftMargin: CGFloat = 0, rightMargin: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftMargin),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightMargin)
        ])
    }
    
    func equalAndCenter(to parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            self.heightAnchor.constraint(equalTo: parentView.heightAnchor),
            self.widthAnchor.constraint(equalTo: parentView.widthAnchor)
        ])
    }
    
    // height anchor
    func setHeight(to height: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    func setHeight(to parentView: UIView) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ])
    }
    // set width to fixed value
    func setWidth(to width: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    // set width to parent
    func setWidth(to parent: UIView) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: parent.widthAnchor)
        ])
    }
}
