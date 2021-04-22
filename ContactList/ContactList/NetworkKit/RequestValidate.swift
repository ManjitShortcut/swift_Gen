//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation
extension URLSessionDataRequest: ValidateResponse {
    @discardableResult
    public func validateResponse(_ successBlock: @escaping ValidationBlock) -> Self {
        return self
    }
}

public extension URLSessionDataRequest {
    //Todo need to validate before orocessing the request
    func validate(with validator: ResponseValidator) -> Self {
        afterRequestQueue.addOperation {
            if !validator.validate(data: self.data, urlResponse: self.response, error: self.error) {
                self.error = NetworkError.validateError
            }
        }
        return self
    }
    func validate(_ successBlock: @escaping ValidationBlock) -> Self {
        afterRequestQueue.addOperation {
            if !successBlock(self.data, self.response, self.error) {
                self.error = NetworkError.validateError
            }
        }
        return self
    }
    func validate() -> Self {
        afterRequestQueue.addOperation {
            if !DefaultResponseValidator().validate(data: self.data, urlResponse: self.response, error: self.error) {
                self.error = NetworkError.validateError
            }
        }
        return self
    }
}
