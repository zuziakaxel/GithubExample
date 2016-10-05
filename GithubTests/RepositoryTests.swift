//
//  RepositoryTests.swift
//  Demo
//
//  Created by Axel Zuziak on 21.09.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import XCTest

class RepositoryTests: XCTestCase {
    
    private let correctJSON: [String: Any] = [
        "name": "Alamofire",
        "description": "Elegant HTTP Networking in Swift",
        "owner": [
            "login": "Alamofire",
            "avatarURL": "https://avatars0.githubusercontent.com/u/7774181?v=3"
        ],
        "stargazers": [
            "totalCount": 19286
        ],
        "forks": [
            "totalCount": 3120
        ]
    ]
    
    func testRepositoryInitializationWithIncorrectJSON() {
        let emptyJSON: [String: AnyObject] = [:]
        
        var JSONWithMissingName: [String: Any] = correctJSON
        JSONWithMissingName.removeValue(forKey: "name")
        
        var JSONWithMissingOwner: [String: Any] = correctJSON
        JSONWithMissingOwner.removeValue(forKey: "owner")
        // ...
        
        XCTAssertNil(Repository(json: emptyJSON))
        XCTAssertNil(Repository(json: JSONWithMissingName))
        XCTAssertNil(Repository(json: JSONWithMissingOwner))
        
    }
    
    
    func testRepositoryInitializationWithCorrectJOSN() {
        XCTAssertNotNil(Repository(json: correctJSON))
    }
}
