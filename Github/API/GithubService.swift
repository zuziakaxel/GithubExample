//
//  GithubService.swift
//  Github
//
//  Created by Axel Zuziak on 03.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Moya
import Alamofire

struct GithubServiceCredentials {
    let baseURL: URL
}

struct GithubService {
    let credentials: GithubServiceCredentials
    let request: Request
    
    init(credentials: GithubServiceCredentials, request: GithubService.Request) {
        self.credentials = credentials
        self.request = request
    }
    
    enum Request {
        case repositories(searchQuery: String, page: Int)
        case readmeURL(repository: Repository)
        case readmeRender(readme: String)
    }
}

extension GithubService: TargetType {
    var baseURL: URL { return credentials.baseURL }
    
    var path: String {
        switch request {
        case .repositories(_, _):
            return "/search/repositories"
        case .readmeURL(let repository):
            return "/repos/\(repository.user.nick)/\(repository.name)/readme"
        case .readmeRender(_):
            return "/markdown/raw"
        }
    }
    
    var method: Moya.Method {
        switch request {
        case .readmeRender(_):
            return .POST
        default:
            return Moya.Method.GET
        }
    }
    
    var parameters: [String : Any]? {
        switch request {
        case .repositories(let searchQuery, let page):
            return ["q" : searchQuery, "page": page]
        default:
            return nil
        }
        
    }
    var sampleData: Data { return Data() }
    var task: Task { return .request }
    
    var endpointClosure: ((GithubService) -> Endpoint<GithubService>) {
        let builder = EndpointBuilder<GithubService>()
        switch request {
        case .repositories(let searchQuery, let page):
            return builder
                .add(HTTPParameter: searchQuery, forKey: "q")
                .add(HTTPParameter: "\(page)", forKey: "page")
                .add(encoding: URLEncoding())
                .build()
        case .readmeRender(let readme):
            return builder
            .add(HTTPParameter: "text/plain", forKey: "Content-Type")
            .add(encoding: readme)
            .build()
        default: return builder.build()
        }
    }
}
