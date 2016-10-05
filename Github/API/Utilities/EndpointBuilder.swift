//
//  EndpointBuilder.swift
//  Demo
//
//  Created by Axel Zuziak on 21.09.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public class EndpointBuilder<T: TargetType> {
    
    private var httpParameters: [String: String] = [:]
    private var encoding: Alamofire.ParameterEncoding = JSONEncoding()
    
    public init() {}
    func build() -> ((T) -> Endpoint<T>) {
        return { target in
            let url = target.baseURL.absoluteString + target.path
            let endpoint: Endpoint<T> = Endpoint<T>(URL: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
            
            return endpoint.endpointByAddingHTTPHeaderFields(self.httpParameters)
                            .endpointByAddingParameterEncoding(self.encoding)
        }
    }
    
    func add(HTTPParameter parameter: String, forKey key: String) -> EndpointBuilder {
        httpParameters[key] = parameter
        return self
    }
    
    func add(encoding: Alamofire.ParameterEncoding) -> EndpointBuilder {
        self.encoding = encoding
        return self
    }
}

extension String: Alamofire.ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
