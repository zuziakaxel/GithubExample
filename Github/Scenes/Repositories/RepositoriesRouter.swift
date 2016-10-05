//
//  RepositoriesRouter.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

protocol RepositoriesRouterInput {
    func navigate(toViewController: UIViewController)
    func navigateToDetail(repository: Repository)
    func viewController(forRepository repository: Repository) -> UIViewController
}

class RepositoriesRouter: RepositoriesRouterInput {
    weak var viewController: RepositoriesViewController!

    func navigate(toViewController viewController: UIViewController) {
        self.viewController.show(viewController, sender: nil)
    }
    
    func navigateToDetail(repository: Repository) {
        viewController.show(viewController(forRepository: repository), sender: nil)
    }
    
    func viewController(forRepository repository: Repository) -> UIViewController {
        let storyboard = UIStoryboard(name: "RepositoryDetail", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RepositoryDetailViewController") as! RepositoryDetailViewController
        vc.output.repository = repository
        return vc
    }
}
