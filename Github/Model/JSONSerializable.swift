//
//  JSONSerializable.swift
//  Demo
//
//  Created by Axel Zuziak on 21.09.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation


/// Failable init ideally could be replaced with `init throws`
protocol JSONSerializable {
    init?(json: [String: Any])
}

protocol JSONDeserializable { }
