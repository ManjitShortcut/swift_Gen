//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//

import Foundation
import  UIKit
class MockRequest: RequestResponse {
    func pause() {
        //no op
    }
   
    func responseWithImage(_ completion: @escaping ResponseCallback<UIImage>) -> Self {
        return self
    }
    
    var data: Data?
    var error: NetworkError?
    var delay: TimeInterval = 2
    var urlPath: URL?
    internal let tragetType: ApiTargetType?

    init(tragetType: ApiTargetType?) {
        self.tragetType = tragetType
        self.delay = tragetType?.diskDelay ?? 3
    }
    private func getDataFromDisk(getErrorModel: Bool = false) -> Data? {
        if let path =  Bundle.main.path(forResource: self.tragetType?.diskPath, ofType: "json") {
            do  {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                return data

            } catch {
                self.error = NetworkError.dataMissing
                return nil
            }
        } else {
            self.error = NetworkError.invalidURL
            return nil
        }
    }
    public func responseDecoded<T: Decodable>(of type: T.Type, parser: DecodableParserProtocol? = nil,
                                              completion: @escaping ResponseCallback<T>) -> Self {
        
        let parser = parser ?? JSONDecodeableParser()
        DispatchQueue.global(qos: .background).async {
            self.data = self.getDataFromDisk()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.delay, execute: {
                self.addParseOperation(parser: DecodableParser<T>(parser: parser)) { (result) in
                    completion(result)
                }
            })
        }
        return self
    }
    internal func addParseOperation<Parser : ResponseParser>( parser: Parser,
                                                              block: @escaping ResponseCallback<Parser.ParsedObject>) {
        
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
    func validateResponse(_ successBlock: @escaping ValidationBlock) -> Self {
        return self
    }
    
    func cancel() {
        // no-op
    }
    var urlRequest: URLRequest?
    var response: URLResponse?
}
extension MockRequest {
    var statusCode: Int? {
        return 200
    }
    var allHeaderFields: [AnyHashable : Any]? {
        return nil
    }
 
}
