//
//  ImageType.swift
//  Github
//
//  Created by Axel Zuziak on 04.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import UIKit

public enum ImageType {
    case local(imageName: String?)
    case network(url: URL, placeholderImageName: String?)
}

extension UIImageView {
    func set(imageType image: ImageType) {
        switch image {
        case .local(let imageName):
            self.image = UIImage(named: imageName ?? "")
        case .network(let url, let placeholderImageName):
            self.af_setImage(withURL: url, placeholderImage: UIImage(named: placeholderImageName ?? ""))
        }
    }
}
