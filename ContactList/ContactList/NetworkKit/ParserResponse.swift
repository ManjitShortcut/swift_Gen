//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//

import Foundation
import UIKit
public typealias ResponseCallback<SuccessType> = (ResponseResult<SuccessType>) -> Void

public protocol ParserResponse {
    @discardableResult
    func responseDecoded<T: Decodable>(of type: T.Type, parser:DecodableParserProtocol?,
                                       completion: @escaping ResponseCallback<T>) -> Self
    @discardableResult
    func responseWithImage(_ completion: @escaping ResponseCallback<UIImage>) -> Self
    
}
extension URLSessionDataRequest: ParserResponse {
    @discardableResult
    public func responseDecoded<T: Decodable>(of type: T.Type, parser:DecodableParserProtocol? = nil,
                                              completion: @escaping ResponseCallback<T>) -> Self {
        startTask()
        let parser = parser ?? self.defaultParser
        addParseOperation(parser:  DecodableParser<T>(parser: parser)) { (result) in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        return self
    }
    @discardableResult
    public func responseWithImage(_ completion: @escaping ResponseCallback<UIImage>) -> Self {
        startTask()
        addParseOperation(parser: ImageParser()) { (result) in
            self.queue.async {
                completion(result)
            }
        }
        return self
    }
    
}
