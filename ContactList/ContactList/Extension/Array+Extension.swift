//
//  Array+Extension.swift
//  DNB_TASK
//
//  Created by Manjit on 05/04/2021.
//

import Foundation
extension Array where Element : Equatable {
    // MARK: Position of the element
    func position(for element: Element)-> Int? {
       return self.firstIndex(of: element)
    }
    // MARK: check item is present or not
    func isItemPresent(for element: Element)-> Bool {
        return self.contains(element)
    }
}
