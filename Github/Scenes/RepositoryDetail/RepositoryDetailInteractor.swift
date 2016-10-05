//
//  RepositoryDetailInteractor.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Alamofire
import Foundation

protocol RepositoryDetailInteractorInput {
    func loadData()
    var repository: Repository! { get set }
}

protocol RepositoryDetailInteractorOutput {
    func presentLoadingState()
    func present(repository: Repository)
    func present(readme: String)
    func present(error: NetworkError)
}

class RepositoryDetailInteractor: RepositoryDetailInteractorInput {

    var output: RepositoryDetailInteractorOutput!
    var worker: RepositoryDetailWorker = RepositoryDetailWorker()
    var repository: Repository!

    func loadData() {
        output.present(repository: repository)
        output.presentLoadingState()
        worker.loadMarkdownURL(forRepository: repository, completion: { result in
            switch result {
            case .success(let readme):
                self.output.present(readme: readme)
            case .failure(let error):
                self.output.present(error: error)
            }
            
        })
    }
}
