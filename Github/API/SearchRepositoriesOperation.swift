//
//  SearchRepositoriesOperation.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Moya

typealias SearchRepositoriesOperationCompletionBlock = (_ repositories: [Repository], _ error: RepositoriesError?) -> Void
class SearchRepositoriesOperation: ConcurrentOperation {
    
    let query: String
    let completion: SearchRepositoriesOperationCompletionBlock
    
    init(query: String, completion: @escaping SearchRepositoriesOperationCompletionBlock) {
        self.query = query
        self.completion = completion
    }
    
    public override func start() {
        if self.isCancelled {
            self.state = .finished
        } else {
            state = .ready
            sleep(1)
            main()
        }
    }
    
    public override func main() {
        guard self.isCancelled == false else {
            state = .finished
            return
        }
        state = .executing
        let credentials = GithubServiceCredentials(baseURL: URL(string: "https://api.github.com")!)
        let target = GithubService(credentials: credentials, request: .repositories(searchQuery: query, page: 1))
        let provider = MoyaProvider<GithubService>(endpointClosure: target.endpointClosure, plugins: [NetworkLogger()])
        provider.request(target, completion: { result in
            switch result {
            case .success(let response):
                do {
                    let repositories = try GithubProviderResponseParser().parse(searchResponseJSON: response.data)
                    self.completion(repositories, nil)
                } catch(let error) {
                    self.completion([], RepositoriesError.CannotFetch(error.localizedDescription))
                }
            case .failure(let error):
                self.completion([], RepositoriesError.CannotFetch(error.localizedDescription))
            }
            self.state = .finished
        })
    }
}
