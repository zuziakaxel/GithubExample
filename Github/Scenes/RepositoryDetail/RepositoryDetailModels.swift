//
//  RepositoryDetailModels.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import UIKit

struct RepositoryDetailViewModel {
    let title: String
    let subtitle: String
    let description: String
    let image: ImageType
    let starsCount: String
    let forksCount: String
    let issuesCount: String
}

struct ReadmeState {
    struct Empty {
        let description: String
    }
    
    struct Loading {
        let description: String
    }
}

