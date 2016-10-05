//
//  User.swift
//  Demo
//
//  Created by Axel Zuziak on 21.09.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation


struct User {
    let nick: String
    let avatar: String?
}

extension User: JSONSerializable {
    init?(json: [String : Any]) {
        guard let nick = json["login"] as? String else { return nil }
        self.nick = nick
        self.avatar = json["avatar_url"] as? String
    }
}
