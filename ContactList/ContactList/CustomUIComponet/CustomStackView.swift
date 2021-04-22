//
//  CustomStackView.swift
//  DNB_TASK
//
//  Created by Manjit on 27/03/2021.
//

import Foundation
import  UIKit
final class CustomStackView: UIStackView {

    func configure(type: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> Self {
        super.spacing = spacing
        super.translatesAutoresizingMaskIntoConstraints = false
        super.alignment = alignment
        super.axis = type
        super.distribution = distribution
        return self
    }
    func addingSubviews(subViews: [UIView]) {
        subViews.forEach { (view) in
//            view.translatesAutoresizingMaskIntoConstraints = false
            super.addArrangedSubview(view)
        }
    }
    public var backGroundColor: UIColor = UIColor.red {
        didSet {
            super.backgroundColor = backGroundColor
        }
    }

}
