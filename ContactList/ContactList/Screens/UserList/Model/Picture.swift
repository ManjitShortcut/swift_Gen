//
//  Picture.swift
//  DNB_TASK
//
//  Created by Manjit on 25/03/2021.
//

import Foundation

struct Picture: Decodable {
    let large: URL?
    let medium: URL?
    let thumbnail: URL?
}
