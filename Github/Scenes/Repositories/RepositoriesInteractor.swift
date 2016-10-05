//
//  RepositoriesInteractor.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

protocol RepositoriesInteractorInput {
    func didSearch(query: String)
    func didClearInput()
    func didLoad()
}

protocol RepositoriesInteractorOutput {
    func present(searchResponse: RepositoriesResponse)
    func presentInitialState()
    func presentLoadingState()
}

class RepositoriesInteractor: RepositoriesInteractorInput {
    var output: RepositoriesInteractorOutput!
    var worker: RepositoriesWorker = RepositoriesWorker()
    var repositories: [Repository] = []
    
    func didSearch(query: String) {
        output.presentLoadingState()
        worker.search(query: query, completion: { repositories, error in
            self.repositories = repositories
            self.output.present(searchResponse: RepositoriesResponse(error: error, data: repositories))
        })
    }
    
    func didClearInput() {
        worker.cancelSearch()
        repositories = []
        output.presentInitialState()
    }
    
    func didLoad() {
        repositories = []
        output.presentInitialState()
    }
}
