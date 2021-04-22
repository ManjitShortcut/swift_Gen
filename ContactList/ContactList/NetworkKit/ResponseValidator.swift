//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//

import Foundation
public typealias ValidationBlock = (Data?, URLResponse?, Error?) -> Bool
public protocol ValidateResponse {
    @discardableResult
    func validateResponse(_ successBlock: @escaping ValidationBlock) -> Self
}
public protocol ResponseValidator {
    func validate(data: Data?, urlResponse: URLResponse?, error: Error?) -> Bool
}
/// most common validation, checking status code between 200 and 299
struct DefaultResponseValidator: ResponseValidator {
    fileprivate var acceptableStatusCodes: Range<Int> { return 200..<300 }
    func validate(data: Data?, urlResponse: URLResponse?, error: Error?) -> Bool {
        if let response = urlResponse as? HTTPURLResponse {
            return acceptableStatusCodes.contains(response.statusCode)
        }
        return true
    }
}
