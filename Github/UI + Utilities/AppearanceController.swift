//
//  AppearanceController.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import UIKit

public struct AppearanceController {
    struct CommonLayers {
        static func gradientLayer(withFrame frame: CGRect? = nil) -> CAGradientLayer {
            let gradientLayer = CAGradientLayer()
            if let frame = frame {
                gradientLayer.frame = frame
            }
            
            let color1 = UIColor(red:0.28, green:0.79, blue:0.91, alpha:1.00).cgColor
            let color2 = UIColor(red:0.24, green:0.80, blue:0.81, alpha:1.00).cgColor
            gradientLayer.colors = [color1, color2]
            gradientLayer.locations = [0.0, 0.5]
                
            return gradientLayer
        }
    }
}
