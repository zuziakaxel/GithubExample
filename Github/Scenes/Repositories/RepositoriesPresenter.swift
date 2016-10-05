//
//  RepositoriesPresenter.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

protocol RepositoriesPresenterInput {
    func present(searchResponse: RepositoriesResponse)
    func presentInitialState()
    func presentLoadingState()
}

protocol RepositoriesPresenterOutput: class {
    func display(emptyState: RepositoriesViewModel.EmptyState)
    func display(error: RepositoriesViewModel.Error)
    func display(data: RepositoriesViewModel.Data)
    func display(loadingState: RepositoriesViewModel.LoadingState)
}

class RepositoriesPresenter: RepositoriesPresenterInput {
    weak var output: RepositoriesPresenterOutput!

    func present(searchResponse: RepositoriesResponse) {
        if let error = searchResponse.error {
            present(error: error)
            return
        }
        if let repositories = searchResponse.data , repositories.isEmpty == false {
            present(data: repositories)
        } else {
            presentEmptyState()
        }
    }
    
    private func present(error: Error) {
        output.display(error: RepositoriesViewModel.Error(description: error.localizedDescription))
    }
    
    private func present(data: [Repository]) {
        guard data.isEmpty == false else {
            presentEmptyState()
            return
        }
        let viewModelData = data.map { RepositoriesViewModel.Data.RepositoryViewModel(title: $0.name, subtitle: $0.user.nick, description: "\($0.starsCount) stars", language: $0.language, image: $0.user.image) }
        output.display(data: RepositoriesViewModel.Data(repositories: viewModelData))
    }
    
    private func presentEmptyState() {
        let emptyStateViewModel = RepositoriesViewModel.EmptyState(description: "No results found")
        output.display(emptyState: emptyStateViewModel)
    }
    
    func presentInitialState() {
        output.display(emptyState: RepositoriesViewModel.EmptyState(description: "Type something  ⌨"))
    }
    
    func presentLoadingState() {
        output.display(loadingState: RepositoriesViewModel.LoadingState(description: "Loading..."))
    }
}
