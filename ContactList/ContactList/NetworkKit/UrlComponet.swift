//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation

public extension URLComponents {
    mutating func setQueryItems(with parameters: QueryParameters) {
        queryItems = parameters.queryItems
    }
}
