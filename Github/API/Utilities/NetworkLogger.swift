//
//  NetworkLogger.swift
//  Github
//
//  Created by Axel Zuziak on 03.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Result

public struct NetworkLogger: PluginType {
    public init() {}
    public func willSendRequest(_ request: RequestType, target: TargetType) {
        print("Sending request: \(request.request?.httpMethod ?? ""): \(request.request?.url?.absoluteString ?? String())")
        print("Headers: \(request.request?.allHTTPHeaderFields ?? [:])")
        if let request = request.request, let body = request.httpBody, let data = JSON(data: body).dictionaryObject {
            print("Body: \(data)")
        }
        print("______")
    }
    
    public func didReceiveResponse(_ result: Result<Moya.Response, Moya.Error>, target: TargetType) {
        
        switch result {
        case .success(let response):
            print("Received Response: \(response.statusCode) ")
//            if let data = JSON(data: response.data).dictionaryObject {
//                print("Data: \(data)")
//            }
        case .failure(let error):
            print("Received networking error: \(error)")
        }
        print("______")
    }
}
