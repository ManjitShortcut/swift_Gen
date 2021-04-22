//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//

import Foundation
internal typealias TaskIdentifier = Int
public class Network: NetworkType {
    var urlSession: URLSession!
    var defaultParser: DecodableParserProtocol =  JSONDecodeableParser()
    // swiftlint:disable:next weak_delegate
     var sessionDelegate: NetworkSessionDelegate? = NetworkSessionDelegate()

    public init(urlSessionConfiguration: URLSessionConfiguration = .default,defaultDecodableParser: DecodableParserProtocol = JSONDecodeableParser()) {
        
        self.urlSession = URLSession(configuration: urlSessionConfiguration,
                                     delegate: self.sessionDelegate, delegateQueue: nil)
        self.defaultParser = defaultDecodableParser
    
    }
     public func requestTraget(_ target: ApiTargetType) -> RequestResponse {
        
      let  sessionRequest = URLSessionDataRequest(urlSession: self.urlSession, urlRequest: target.asURLRequest(), defaultParser: defaultParser)
        
            sessionRequest.taskCreation = { [weak sessionRequest] task in
                self.sessionDelegate?.queue.async(flags: .barrier) {
                    self.sessionDelegate?.requests[task.taskIdentifier] = sessionRequest
                }
            }
          return sessionRequest
    }
    // url request for image
     public func request(for request: URLRequest) -> RequestResponse  {
        
        let  sessionRequest = URLSessionDataRequest(urlSession: self.urlSession, urlRequest: request, defaultParser: defaultParser)

        sessionRequest.taskCreation = { [weak sessionRequest] task in
            self.sessionDelegate?.queue.async(flags: .barrier) {
                
                self.sessionDelegate?.requests[task.taskIdentifier] = sessionRequest
            }
        }
      return sessionRequest
    }
    deinit {
        urlSession?.invalidateAndCancel()
        sessionDelegate = nil
        urlSession = nil
    }
}
internal class NetworkSessionDelegate: NSObject, URLSessionDataDelegate {
    
    var requests = [TaskIdentifier: URLSessionDataRequest]()
    let queue: DispatchQueue = DispatchQueue(label: "Network",
                                             qos: .background,
                                             attributes: .concurrent)
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        queue.async(flags: .barrier) {
            if let request = self.requests[task.taskIdentifier] {
                request.urlSession(session, task: task, didCompleteWithError: error)
                self.requests[task.taskIdentifier] = nil
            }
        }
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        queue.async(flags: .barrier) {
            if let request = self.requests[dataTask.taskIdentifier] {
                request.urlSession(session, dataTask: dataTask, didReceive: data)
            }
        }
    }
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        queue.async(flags: .barrier) {
            if let request = self.requests[dataTask.taskIdentifier] {
                request.urlSession(session,
                                   dataTask: dataTask,
                                   didReceive: response,
                                   completionHandler: completionHandler)
            }
        }
    }
}
/// mock implementation of NetworkType using disk requests
public class MockNetwork: NetworkType {
    
    
    
    public init() {}
    //TODO
    public func request(for request: URLRequest) -> RequestResponse {
       return MockRequest.init(tragetType: nil)
        
    }
    public func request(_ target: ApiTargetType) -> RequestResponse {
        return MockRequest.init(tragetType: target)
    }
    public func requestTraget(_ target: ApiTargetType) -> RequestResponse {
      return  MockRequest.init(tragetType: nil)
    }
}
