//
//  UrlConstant.swift
//  DNB_TASK
//
//  Created by Manjit on 02/04/2021.
//

import Foundation

struct BaseURL {
    //separate out base url base on Scheme
    static  func getBaseUrl() -> String {
        #if PROD
        return BaseURL.prodBaseUrl
        #elseif BETA
        return BaseURL.prodBaseUrl
        #elseif DEV
        return BaseURL.prodBaseUrl
        #else
         return BaseURL.prodBaseUrl
        #endif
    }
    static let prodBaseUrl: String = "https://my-dev.oiidmusic.com"
}

enum UrlPath: String {
    case login =  "/api/login"
    case userList =  "/api/users"
}

enum MockUrlPath: String {
    case login =  "login"
    case userList =  "users"

}
