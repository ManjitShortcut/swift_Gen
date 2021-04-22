//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case delete
    case patch
    case put
    var value: String {
        return rawValue.uppercased()
    }
}
public enum NetworkError: Error {
    case invalidURL
    case parsingError(Error)
    case responseError(Error)
    case dataMissing
    case responseMissing
    case middlewareError(Error)
    case validateError
    case cancelled
    case internalParserError(Error)
    
    // Configure error message
    //TODO should configure error message depending upon error code
    var errorMessage:String {
        return "Some thing went wrong,Please try again later."
    }
}
public typealias HTTPHeaders = [String: String]

public enum HTTPBodyType {
    case json
    case formEncoded(parameters: [String: String])
    case none
}
public protocol RequestResponse: ParserResponse,ValidateResponse {
    /// the URLRequest that was sent out
    var urlRequest: URLRequest? { get }

    /// the URLResponse returned. could be a HTTPURLResponse if using URLSessionDataRequest
    var response: URLResponse? { get }

    /// the final collection of data returned
    var data: Data? { get }

    /// if an error was encountered, this will have the error
    var error: NetworkError? { get }

    /// cancels the request
    func cancel()
    func pause()
    var statusCode: Int? { get }
    var allHeaderFields: [AnyHashable: Any]? { get }
}
