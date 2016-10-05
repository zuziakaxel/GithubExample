//
//  RepositoryDetailPresenter.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

protocol RepositoryDetailPresenterInput {
    func present(repository: Repository)
    func present(readme: String)
    func present(error: NetworkError)
    func presentLoadingState()
}

protocol RepositoryDetailPresenterOutput: class {
    func display(viewModel: RepositoryDetailViewModel)
    func display(readme: String)
    func display(emptyState: ReadmeState.Empty)
    func display(loadingState: ReadmeState.Loading)
}

class RepositoryDetailPresenter: RepositoryDetailPresenterInput {
    weak var output: RepositoryDetailPresenterOutput?

    func present(repository: Repository) {
    
        let viewModel = RepositoryDetailViewModel(title: repository.name,
                                  subtitle: repository.user.nick,
                                  description: repository.description,
                                  image: repository.user.image,
                                  starsCount: String(repository.starsCount),
                                  forksCount: String(repository.forksCount),
                                  issuesCount: String(repository.issuesCount))
        output?.display(viewModel: viewModel)
    }
    
    func present(readme: String) {
        output?.display(readme: MarkdownController().render(markdown: readme))
    }
    
    func present(error: NetworkError) {
        switch error {
        case .notFound:
            self.output?.display(emptyState: ReadmeState.Empty(description: "This repository does not contain Readme."))
        default:
            self.output?.display(emptyState: ReadmeState.Empty(description: "We have troubles loading Readme."))
        }
    }
    
    func presentLoadingState() {
        output?.display(loadingState: ReadmeState.Loading(description: "Loading Readme..."))
    }
}
