//
//  RepositoryDetailWorker.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Result

typealias DownloadReadmeOperationCompletionBlock = (Result<String, NetworkError>) -> Void

class RepositoryDetailWorker {
    
    private var operationQueue = OperationQueue()
    
    func loadMarkdownURL(forRepository repository: Repository, completion: @escaping (Result<String, NetworkError>) -> Void) {
        operationQueue.cancelAllOperations()
        let operation = DownloadReadmeOperation(repository: repository, completion: completion)
        operationQueue.addOperation(operation)
    }
}
