//
//  AsyncImageView.swift
//  DNB_TASK
//
//  Created by Manjit on 03/04/2021.
//

import Foundation
import UIKit
protocol AsyncImageView {
    func loadRemoteImage(from url: URL?, placeHolder: UIImage?)
}
//TODO : Improvement needed
protocol CacheImageProtocol {
    associatedtype KeyType
    func setImage(for image: UIImage, for key: KeyType)
    func getImageForkey( for key:KeyType)-> UIImage?
}
class CacheImage: CacheImageProtocol {
    var nsCache = NSCache<NSURL, UIImage>()
    static var shareInstance = CacheImage()
    func setImage( for image: UIImage, for key: URL) {
        CacheImage.shareInstance.nsCache.setObject(image, forKey: key as NSURL)
    }
    func getImageForkey(for key: URL) -> UIImage? {
        return CacheImage.shareInstance.nsCache.object(forKey: key as NSURL)
    }
}
extension UIImageView: AsyncImageView {
    func loadRemoteImage(from url: URL?, placeHolder: UIImage? = nil) {
        if let dummyImage = placeHolder  {
            self.image = dummyImage
        }
        guard let url = url else {
            return
        }
        if let image = CacheImage.shareInstance.getImageForkey(for: url) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
            NWK.shareNetwork.request(for: urlRequest).responseWithImage({ [weak self] (responseResult)  in
                switch responseResult.result {
                case .success(let newImage) :
                    DispatchQueue.main.async {
                        self?.image = newImage
                        CacheImage.shareInstance.setImage(for: newImage, for: url)
                    }
                case .failure :
                    DispatchQueue.main.async {
                        self?.image = placeHolder
                    }
                }
            })
        }
        
    }
}
