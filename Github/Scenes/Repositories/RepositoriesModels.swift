//
//  RepositoriesModels.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright (c) 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import UIKit

struct RepositoriesRequest {
    struct Search {
        let query: String
    }
}

struct RepositoriesResponse {
    let error: Error?
    let data: [Repository]?
}

struct RepositoriesViewModel {
    struct Error {
        let description: String
    }
    
    struct EmptyState {
        let description: String
    }
    
    struct LoadingState {
        let description: String
    }
    
    struct Data {
        struct RepositoryViewModel {
            let title: String
            let subtitle: String
            let description: String
            let language: String
            let image: ImageType
        }
        let repositories: [RepositoryViewModel]
    }
}

extension User {
    var avatarURL: URL? {
        guard let avatar = avatar else { return nil }
        return URL(string: avatar)
    }
    
    var image: ImageType {
        if let url = avatarURL {
            return ImageType.network(url: url, placeholderImageName: "avatar")
        } else {
            return ImageType.local(imageName: "avatar")
        }
    }
}
