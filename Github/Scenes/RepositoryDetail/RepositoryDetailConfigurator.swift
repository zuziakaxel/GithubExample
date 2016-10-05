//
//  RepositoryDetailConfigurator.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension RepositoryDetailViewController: RepositoryDetailPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension RepositoryDetailInteractor: RepositoryDetailViewControllerOutput {

}

extension RepositoryDetailPresenter: RepositoryDetailInteractorOutput {

}

class RepositoryDetailConfigurator {
    // MARK: Object lifecycle

    static let sharedInstance = RepositoryDetailConfigurator()
    private init() { }

    // MARK: Configuration

    func configure(viewController: RepositoryDetailViewController) {
        let router = RepositoryDetailRouter()
        router.viewController = viewController

        let presenter = RepositoryDetailPresenter()
        presenter.output = viewController

        let interactor = RepositoryDetailInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
