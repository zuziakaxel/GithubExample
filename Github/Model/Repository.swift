//
//  Repository.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation

struct Repository {
    let name: String
    let description: String
    let starsCount: Int
    let forksCount: Int
    let issuesCount: Int
    let user: User
    let language: String
}

extension Repository: JSONSerializable {
    init?(json: [String : Any]) {
        guard let name = json["name"] as? String,
            let ownerJSON = json["owner"] as? [String: Any],
            let owner = User(json: ownerJSON)
            else { return nil }
        
        guard let starsCount = json["stargazers_count"] as? Int,
            let forksCount = json["forks_count"] as? Int,
            let issuesCount = json["open_issues_count"] as? Int
            else { return nil }
        self.name = name
        self.user = owner
        self.starsCount = starsCount
        self.forksCount = forksCount
        self.issuesCount = issuesCount
        self.description = json["description"] as? String ?? ""
        self.language =  json["language"] as? String ?? ""
    }
}

