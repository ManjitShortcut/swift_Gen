//
//  Location.swift
//  DNB_TASK
//
//  Created by Manjit on 25/03/2021.
//

import Foundation

struct Location: Hashable, Decodable {
    var street: Street
    var city: String
    var state: String
    var country: String
    var postCode: String
    var coordinates: Coordinates
    var timeZone: Timezone

    enum CodingKeys: String, CodingKey {
        case street,city,state,country,coordinates
        case postCode = "postcode"
        case timeZone = "timezone"
    }
    init(from decoder: Decoder) throws {
        // The compiler creates coding keys for each property, so as long as the keys are the same as the property names, we don't need to define our own enum.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(Street.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.timeZone = try container.decode(Timezone.self, forKey: .timeZone)
        // First check for a postcode
        do {
            self.postCode = String(try container.decode(Int.self, forKey: .postCode))
        } catch {
            // The check for a String and then cast it, this will throw if decoding fails
            self.postCode = try container.decode(String.self, forKey: .postCode)
        }

    }
    
}
struct Street: Hashable, Decodable {
    let name: String
    let number: Int
}
