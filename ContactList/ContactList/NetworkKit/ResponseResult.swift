//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation
public struct ResponseResult<SuccessType> {
    public var request: URLRequest?
    public var response: URLResponse?
    public var data: Data?
    public var result: Result<SuccessType, NetworkError>
    public var responseIsFromCacheProvider: Bool = false
    init(_ result: Result<SuccessType, NetworkError>) {
        self.result = result
    }
}
public extension ResponseResult {
    var statusCode: Int? {
         guard let response = self.response as? HTTPURLResponse else { return nil }
         return response.statusCode
     }
    var allHeaderFields: [AnyHashable: Any]? {
         guard let response = self.response as? HTTPURLResponse else { return nil }
         return response.allHeaderFields
     }
}
