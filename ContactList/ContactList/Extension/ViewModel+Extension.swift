//
//  ViewModelExtension.swift
//  DNB_TASK
//
//  Created by Manjit on 05/04/2021.
//

import Foundation

typealias State<T> = ((LoadingState<T>) -> Void)

protocol DataLoadingState {
    associatedtype Dataload
    var  loadingStateCallback: State<Dataload>? { get }
}

protocol ApiEndPoint {
    associatedtype EndPoint
    var endPoint: EndPoint { get }

}
