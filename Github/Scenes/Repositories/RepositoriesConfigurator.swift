//
//  RepositoriesConfigurator.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension RepositoriesViewController: RepositoriesPresenterOutput { }

extension RepositoriesInteractor: RepositoriesViewControllerOutput { }

extension RepositoriesPresenter: RepositoriesInteractorOutput { }

class RepositoriesConfigurator {
    // MARK: Object lifecycle

    static let sharedInstance = RepositoriesConfigurator()
    private init() { }

    // MARK: Configuration

    func configure(viewController: RepositoriesViewController) {
        let router = RepositoriesRouter()
        router.viewController = viewController

        let presenter = RepositoriesPresenter()
        presenter.output = viewController

        let interactor = RepositoriesInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
