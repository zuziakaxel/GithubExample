//
//  RepositoriesWorker.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import Moya

enum RepositoriesError: Swift.Error {
    case CannotFetch(String)
    case Cancelled
}

class RepositoriesWorker {
    
    private var shouldCancelPreviousRequest: Bool = false
    private var isRequesting: Bool = false
    private var operationQueue = OperationQueue()
    
    func search(query: String, completion: @escaping (_ repositories: [Repository], _ error: RepositoriesError?) -> Void ) {
        operationQueue.cancelAllOperations()
        let operation = SearchRepositoriesOperation(query: query, completion: completion)
        operationQueue.addOperation(operation)
    }
    
    func cancelSearch() {
        operationQueue.cancelAllOperations()
    }
}



