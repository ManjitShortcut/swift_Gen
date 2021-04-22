//
//  Encription.swift
//  DNB_TASK
//
//  Created by Manjit on 28/03/2021.
//

import Foundation

struct Encription {
    static let shard = Encription()
    var encriptionKey: String = "encriptionkey"
    func encripted() -> String {
        return "encriptedPasscode"
    }
}
// encription from string
protocol Encript {
   func encriptToString() ->Self
}
extension String:Encript {
    //TODO : Newr future
    func encriptToString() ->Self {
       return self //Encription.shard.encripted()
    }
}
