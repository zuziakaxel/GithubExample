//
//  GithubResponseParser.swift
//  Demo
//
//  Created by Axel Zuziak on 21.09.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import UIKit

enum ParserError: Error {
    case invalidJSON(description: String)
}

struct GithubProviderResponseParser {
    
    
    func parse(searchResponseJSON jsonData: Data) throws -> [Repository] {

        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
        let jsonDictionary = json
            else { throw ParserError.invalidJSON(description: "Object is not a JSON.") }
        guard let items = jsonDictionary["items"] as? [[String: Any]]
            else { throw ParserError.invalidJSON(description: "Invalid JSON. Missing property `items`.") }
        return items.flatMap { Repository(json: $0) }
        
    }
    
    func parse(readmeURLResponseJSON jsonData: Data) throws -> URL {
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
        let jsonDictionary = json else {
            throw ParserError.invalidJSON(description: "Object is not a JSON.")
        }
        guard let urlString = jsonDictionary["download_url"] as? String, let url = URL(string: urlString) else {
            throw ParserError.invalidJSON(description: "Invalid JSON. Missing property `download_url`")
        }
        return url
    }
}
