//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
///

import Foundation
import UIKit
public enum ParserError: Error {
    case dataMissing
    case internalParserError(Error)
}
public protocol DecodableParserProtocol {
    func parse<T: Decodable>(data: Data?) -> Result<T, ParserError>
}
protocol ResponseParser {
    associatedtype ParsedObject
    func parse(data: Data?, type: ParsedObject.Type) -> Result<ParsedObject, ParserError>
}
struct DecodableParser<T: Decodable>:  ResponseParser {
    
    typealias ParsedObject = T
    let parser: DecodableParserProtocol
    init(parser: DecodableParserProtocol) {
        self.parser = parser
    }
    func parse(data: Data?, type: T.Type) -> Result<T, ParserError> {
        if let responseData  = data {
            let result = self.parser.parse(data: responseData) as Result<T, ParserError>
            return result.mapError { error in
                ParserError.internalParserError(error)
            }
        } else {
            return .failure(.dataMissing)
        }
    }
}
struct DataParser: ResponseParser  {
    typealias ParsedObject = Data

    func parse(data: Data?, type: Data.Type) -> Result<Data, ParserError> {
        if let data = data {
            return .success(data)
        } else {
            return .failure(.dataMissing)
        }
    }
}
struct ImageParser: ResponseParser {
    func parse(data: Data?, type: UIImage.Type) -> Result<UIImage, ParserError> {
        if let imageData =  data,let image = UIImage(data: imageData) {
            return .success(image)
        } else {
            return .failure(.dataMissing)
        }
    }    
    typealias ParsedObject = UIImage
}

// parser
public class JSONDecodeableParser: DecodableParserProtocol {
    let jsonDecoder: JSONDecoder
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = decoder
    }
    public func parse<T>(data: Data?) -> Result<T, ParserError> where T: Decodable {
        guard let data = data else {
            return .failure(ParserError.dataMissing)
        }
        return Result { try jsonDecoder.decode(T.self, from: data) }.mapError { error in
            ParserError.internalParserError(error)
        }
    }
}
