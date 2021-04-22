//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation
public protocol ApiTargetType {
    var baseURL: URL { get }
    var headerValues: HTTPHeaders? { get }
    
    var path: String { get }
    var method: HTTPMethod { get }
    var bodyType: HTTPBodyType { get }
    var body: Encodable? { get }
    var queryParameters: QueryParameters? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    
    // for mocks using DiskRequest
    var diskPath: String? { get }
    var diskDelay: TimeInterval { get }
}

// defaults
public extension ApiTargetType {
    var baseURL: URL {
        guard let baseURL = URL(string: BaseURL.getBaseUrl()) else {
            fatalError("no url fount")
        }
        return baseURL
    }
    var path: String {""}
    var bodyType: HTTPBodyType { .none }
    var body: Encodable? { nil }
    var queryParameters: QueryParameters? { nil }
    var headerValues: HTTPHeaders? { nil }
    var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
    var diskPath: String? { nil }
    var method: HTTPMethod { .get }
    var diskDelay: TimeInterval { 3 }
}

extension ApiTargetType {
    func asURLRequest() -> URLRequest? {        
        return URLRequest(baseURL: baseURL, path: path, httpMethod: method, headerValues: headerValues,
                          queryParameters: queryParameters, bodyType: bodyType, body: body, cachePolicy: cachePolicy)
    }
}
