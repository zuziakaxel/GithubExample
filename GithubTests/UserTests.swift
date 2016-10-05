//
//  User.swift
//  Demo
//
//  Created by Axel Zuziak on 21.09.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import XCTest

class UserTests: XCTestCase {
    
    let correctJSON: [String: Any] = [
        "login": "Great Developer",
        "avatarURL": "https://avatars0.githubusercontent.com/u/7774181?v=3"
    ]
    
    func testUserInitializationWithIncorrectJSON() {
        var JSONWithMissingNickName = correctJSON
        JSONWithMissingNickName.removeValue(forKey: "login")
        
        XCTAssertNil(User(json: JSONWithMissingNickName))
    }
    
    func testUserInitializationWithCorrectJSON() {
        XCTAssertNotNil(User(json: correctJSON))
    }
}
