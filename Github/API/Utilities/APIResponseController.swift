//
//  APIResponseController.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Moya
import Result

public enum NetworkError {
    case unauthorized
    case generic(description: String)
    case notFound
    case incorrectData(description: String)
}

extension NetworkError: Swift.Error { }

public class APIResponseController {
    
    public init() {}
    
    func handle(statusCode: Int) -> NetworkError? {
        switch statusCode {
        case 200...300:
            return nil
        case 401:
            return NetworkError.unauthorized
        case 404:
            return NetworkError.notFound
        default:
            return NetworkError.generic(description: "General Error with \(statusCode)")
        }
    }
}

extension APIResponseController {
    
    public func handle(response: Moya.Response?) -> Result<Data, NetworkError> {
        if let response = response {
            if let error = handle(statusCode: response.statusCode) {
                return .failure(error)
            } else {
                return .success(response.data)
            }
        } else {
            return .failure(NetworkError.generic(description: "Did not receive response."))
        }
    }
    
    public func handle(result: Result<Moya.Response, Moya.Error>) -> Result<Data, NetworkError> {
        switch result {
        case .success(let response):
            return handle(response: response)
        case .failure(let error):
            return .failure(.generic(description: error.localizedDescription ))
        }
    }
}
