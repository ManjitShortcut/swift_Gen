//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation
public struct QueryParameters {
    public var queryDictionary: [String: Any]
    
    /// Defines how dictionaires should be formatted within a query string
    public enum DictionaryFormat {
        /// param.key1=value1&param.key2=value2&param.key3.key4=value3
        case dotNotated
        //TODO future
        /// param[key1]=value1&param[key2]=value2&param[key3][key4]=value3
        case subscripted
    }

    public var dictionaryFormat: DictionaryFormat = .subscripted
    public init(_ queryDictionary: [String: Any]) {
        self.queryDictionary = queryDictionary
    }
    public var queryItems: [URLQueryItem] {
          return queryDictionary.flatMap { kvp in
              queryItemsFrom(parameter: (kvp.key, kvp.value))
          }
      }
    private func queryItemsFrom(parameter: (String, Any)) -> [URLQueryItem] {
          let name = parameter.0
          var value: String?
          if let parameterValue = parameter.1 as? String {
              value = parameterValue
          } else if let parameterValue = parameter.1 as? NSNumber {
              value = parameterValue.stringValue
          } else if parameter.1 is NSNull {
              value = nil
          } else {
              value = "\(parameter.1)"
          }
          return [URLQueryItem(name: name, value: value)]
      }
}
