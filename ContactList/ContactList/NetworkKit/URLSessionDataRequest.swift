//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation

public class  URLSessionDataRequest: NSObject,RequestResponse {
    
    internal let queue = DispatchQueue(label: "no.NetworkKit.Requests",
                                       qos: .background,
                                       attributes: .concurrent)
    internal var afterRequestQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.isSuspended = true
        return operationQueue
    }()
    public let urlSession: URLSession
    public var urlRequest: URLRequest?
    public var response: URLResponse?
    
    public var data: Data? // reponse data
    internal var isCancelled = false
    public var error: NetworkError?
    // internal use
    private lazy var receivedData: Data? = Data()
    internal var task: URLSessionTask?
    internal var taskCreation: ((URLSessionTask) -> Void)?
    internal let defaultParser: DecodableParserProtocol

    public func cancel() {
        isCancelled = true
        task?.cancel()
    }
    public func pause() {
        
    }
    public init(urlSession: URLSession,
                urlRequest: URLRequest?, defaultParser: DecodableParserProtocol) {
        self.urlSession = urlSession
        self.urlRequest = urlRequest
        self.defaultParser = defaultParser
        super.init()
    }
    func startTask() {
        guard let urlRequest = urlRequest else {
            self.error = NetworkError.invalidURL
            self.finish()
            return
        }
        let task = urlSession.dataTask(with: urlRequest)
        self.task = task
        taskCreation?(task)
        taskCreation = nil
        if task.state != .running,
            task.state != .canceling,
            task.state != .completed {
            urlSession.delegateQueue.addOperation {
                task.resume()
            }
        }
    }
    internal func finish() {
        afterRequestQueue.isSuspended = false
    }
    internal func addParseOperation<Parser : ResponseParser>( parser: Parser,
                                                              block: @escaping ResponseCallback<Parser.ParsedObject>) {
        afterRequestQueue.addOperation {
            
            guard self.urlRequest != nil else {
                self.error = NetworkError.invalidURL
                let result = Result<Parser.ParsedObject, NetworkError>.failure(NetworkError.invalidURL)
                block(self.responseWithResult(result))
                return
            }
            if !DefaultResponseValidator().validate(data: self.data, urlResponse: self.response, error: self.error) {
                self.error = NetworkError.validateError
                let result = Result<Parser.ParsedObject, NetworkError>.failure(NetworkError.validateError)
                block(self.responseWithResult(result))
            } else {
                if let err  =  self.error {
                    let result = Result<Parser.ParsedObject, NetworkError>.failure(err)
                    block(self.responseWithResult(result))
                    return
                }
                let result = self.parseResponse(data: self.data, parser: parser).mapError { error in
                    NetworkError.parsingError(error)
                }
                block(self.responseWithResult(result))
            }
        }
    }
    internal func parseResponse<Parser: ResponseParser>(data: Data?,
                                                        parser: Parser) -> Result<Parser.ParsedObject, ParserError> {
        guard let data = data else {
            return .failure(.dataMissing)
        }
        return parser.parse(data: data, type: Parser.ParsedObject.self)
    }
    
    internal func responseWithResult<ParsedObject>(
        _ result: Result<ParsedObject, NetworkError>) -> ResponseResult<ParsedObject> {
        var response = ResponseResult(result)
        response.data = self.data
        response.response = self.response
        response.request = self.urlRequest
        return response
    }
}

public extension URLSessionDataRequest {
    var statusCode: Int? {
        guard let response = self.response as? HTTPURLResponse else { return nil }
        return response.statusCode
    }
    func localizedStringForStatusCode() -> String? {
        guard let statusCode = self.statusCode else { return nil }
        return HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }

    var allHeaderFields: [AnyHashable: Any]? {
        guard let response = self.response as? HTTPURLResponse else { return nil }
        return response.allHeaderFields
    }
}
extension URLSessionDataRequest: URLSessionDataDelegate {
    // TODO Need to handle Certificate pinning
    // swiftlint:disable:TODO certificate pinning
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response as? HTTPURLResponse
        completionHandler(.allow)
    }
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.receivedData?.append(data)
    }
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            self.error = .responseError(error)
            finish()
        }
        if let receivedData = self.receivedData,
            receivedData.count > 0 {
            self.data = self.receivedData
            self.receivedData = nil
            finish()
        }
    }
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let error = error {
            self.error = .responseError(error)
        }
        finish()
    }
    
}
