//
//  ApiRequest.swift
//  DNB_TASK
//
//  Created by Manjit on 01/04/2021.
//

import Foundation
// web service callback
public enum LoadingState<Value> {
    case idle
    case loading
    case failed(NetworkError)
    case loaded(value: Value)
}

protocol APIRequest {
    func fetch<ENDPOINT: ApiTargetType, OUTPUT: Decodable>(target: ENDPOINT, complitionHandler: @escaping ResponseCallback<OUTPUT>)
    func request<OUTPUT: Decodable>(responseResult: @escaping ResponseCallback<OUTPUT>)
    func fetchMock<ENDPOINT: ApiTargetType, OUTPUT: Decodable>(target: ENDPOINT, complitionHandler: @escaping ResponseCallback<OUTPUT>)
}
extension APIRequest {
    func fetch<ENDPOINT: ApiTargetType, OUTPUT: Decodable>(target: ENDPOINT, complitionHandler: @escaping ResponseCallback<OUTPUT>) {
        NWK.shareNetwork.requestTraget(target).responseDecoded(of: OUTPUT.self, parser: nil) { (response) in
            switch response.result {
            case .success :
                complitionHandler(response)
            case .failure:
                //TODO  check  token error
               // if token is expire then call the refresh token then call the web service
                complitionHandler(response)
            }
        }
    }
    func fetchMock<ENDPOINT: ApiTargetType, OUTPUT: Decodable>(target: ENDPOINT, complitionHandler: @escaping ResponseCallback<OUTPUT>) {
        MockNetwork().request(target).responseDecoded(of: OUTPUT.self, parser: nil) { (response) in
            switch response.result {
            case .success :
                complitionHandler(response)
            case .failure:
                //TODO  check  token error
               // if token is expire then call the refresh token then call the web service
                complitionHandler(response)
            }
        }
    }
}
