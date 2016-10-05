//
//  MarkdownController.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation

public class MarkdownController {
    private let markdownPlaceholder = "@@@MARKDOWN@@@"
    
    private func string(fromFile file: String, ofType type: String) -> String {
        let path = Bundle.main.path(forResource: file, ofType: type)
        if let path = path {
            return try! String(contentsOfFile: path)
        } else {
            fatalError("Invalid File")
        }
    }
    
    private func prepareTemplate() -> String {
        return string(fromFile: "markdown", ofType: "html")
    }
    
    public func render(markdown: String) -> String {
        return prepareTemplate().replacingOccurrences(of: markdownPlaceholder, with: markdown)
    }
}
