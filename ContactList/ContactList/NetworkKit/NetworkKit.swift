//
//  UrlComponet.swift
//  DNB_TASK
//
//  Created by Manjit on 31/03/2021.
//
import Foundation
/// main interface into the Network stack
public protocol NetworkType {
    func requestTraget(_ target: ApiTargetType) -> RequestResponse
    func request(for request: URLRequest) -> RequestResponse
}

public struct NWK: NetworkType {
    public func requestTraget(_ target: ApiTargetType) -> RequestResponse {
        return NWK.shareNetwork.requestTraget(target)
    }
    public func request(for request: URLRequest) -> RequestResponse {
        NWK.shareNetwork.request(for: request)
    }
   static var shareNetwork = Network()
}
