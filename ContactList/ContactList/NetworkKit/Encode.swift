//
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//

import Foundation

public extension Encodable {
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
