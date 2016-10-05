//
//  DownloadReadmeOperation.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Result
import Moya
import Alamofire

class DownloadReadmeOperation: ConcurrentOperation {
    
    private let completion: DownloadReadmeOperationCompletionBlock
    private let repository: Repository
    private let credentials = GithubServiceCredentials(baseURL: URL(string: "https://api.github.com")!)
    
    init(repository: Repository, completion: @escaping DownloadReadmeOperationCompletionBlock) {
        self.completion = completion
        self.repository = repository
    }
    
    public override func start() {
        if self.isCancelled {
            self.state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    public override func main() {
        getReadmeURL(success: { url in
            self.getReadme(fromURL: url, success: { readme in
                self.convertReadmeToHTML(readme: readme, success: { readmeHTML in
                    self.finish(withReadme: readmeHTML)
                })
            })
        })
    }
    
    
    private func getReadmeURL(success: @escaping (URL) -> Void) {
        
        let target = GithubService(credentials: credentials, request: .readmeURL(repository: repository))
        let provider = MoyaProvider<GithubService>(endpointClosure: target.endpointClosure, plugins: [NetworkLogger()])
        provider.request(target, completion: { result in
            let result = APIResponseController().handle(result: result)
            switch result {
            case .success(let data):
                do {
                    let url = try GithubProviderResponseParser().parse(readmeURLResponseJSON: data)
                    success(url)
                } catch(let error) {
                    self.finish(withError: .generic(description: error.localizedDescription))
                }
            case .failure(let error):
                self.finish(withError: error)
            }
        })
        
        
    }
    
    private func getReadme(fromURL url: URL, success: @escaping (String) -> Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).responseString(completionHandler: { result in
            if let data = result.data {
                if let html = String(data: data, encoding: .utf8) {
                    return success(html)
                }
            }
            self.finish(withError: .incorrectData(description: "Cannot convert response data to String."))
        })
    }
    
    private func convertReadmeToHTML(readme: String, success: @escaping (String) -> Void) {
        let target = GithubService(credentials: credentials, request: .readmeRender(readme: readme))
        let provider = MoyaProvider<GithubService>(endpointClosure: target.endpointClosure, plugins: [NetworkLogger()])
        provider.request(target, completion: { result in
            let result = APIResponseController().handle(result: result)
            switch result {
            case .success(let data):
                if let html = String(data: data, encoding: .utf8) {
                    return success(html)
                }
                self.finish(withError: .incorrectData(description: "Cannot convert response data to String."))
            case .failure(let error):
                self.finish(withError: error)
            }
        })
    }
    
    private func finish(withError error: NetworkError) {
        completion(.failure(error))
        state = .finished
    }
    
    private func finish(withReadme readme: String) {
        completion(.success(readme))
        state = .finished
    }
}
