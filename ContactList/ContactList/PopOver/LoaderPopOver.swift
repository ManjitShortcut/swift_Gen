//
//  LoaderPopOver.swift
//  DNB_TASK
//
//  Created by Manjit on 01/04/2021.
//

import Foundation
import UIKit
let loaderTag = 12345
extension UIViewController {
    // todo add navigation bar to view
    open func showLoader(_ title: String = "") {
        self.hideLoader()
        let viewLoaderBg = UIView.init(frame: CGRect.zero)
        viewLoaderBg.backgroundColor = UIColor.clear
        viewLoaderBg.tag = loaderTag

        let imageViewBg = UIImageView.init(frame: CGRect.zero)
        imageViewBg.backgroundColor = UIColor.black
        imageViewBg.alpha = 0.3
        viewLoaderBg .addSubview(imageViewBg)
        imageViewBg.equalAndCenter(to: viewLoaderBg)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tintColor = UIColor.white
        viewLoaderBg .addSubview(activityIndicator)
        activityIndicator.equalAndCenter(to: viewLoaderBg)
        activityIndicator.startAnimating()
        if let navView =  self.navigationController {
            navView.view.addSubview(viewLoaderBg)
            viewLoaderBg.equalAndCenter(to: navView.view)
        } else {
            self.view.addSubview(viewLoaderBg)
            viewLoaderBg.equalAndCenter(to: self.view)
        }
    }
    open func hideLoader() {
        if let navView =  self.navigationController {
            if let loaderView = navView.view.viewWithTag(loaderTag) {
                loaderView.removeFromSuperview()
            }
        } else {
            if let loaderView = self.view.viewWithTag(loaderTag) {
                loaderView.removeFromSuperview()
            }
        }
    }
}
