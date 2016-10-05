//
//  RepositoryTableViewCell.swift
//  Github
//
//  Created by Axel Zuziak on 02.10.2016.
//  Copyright © 2016 SwiftyDev Axel Zuziak. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLeftLabel: UILabel!
    @IBOutlet weak var descriptionRightLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var backgroundContainerView: UIView!
    
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        layoutImageView()
        backgroundContainerView.layer.cornerRadius = 4.0
        backgroundContainerView.layer.masksToBounds = true
        
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    func configure(withViewModel viewModel: RepositoriesViewModel.Data.RepositoryViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        descriptionLeftLabel.text = viewModel.language
        descriptionRightLabel.text = viewModel.description
        avatarImageView.set(imageType: viewModel.image)
        backgroundImageView.set(imageType: viewModel.image)
        layoutImageView()
    }
    
    private func layoutImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2.0
        avatarImageView.layer.masksToBounds = true
        layoutIfNeeded()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        animateTouchEvent(touched: selected)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        animateTouchEvent(touched: highlighted)
    }
    
    private func animateTouchEvent(touched: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            
            if touched {
//                self.backgroundImageView.backgroundColor = UIColor(red: 142/255, green: 148/255, blue: 168/255, alpha: 1.0)
                self.backgroundImageView.backgroundColor = UIColor.gray
            } else {
                self.backgroundImageView.backgroundColor = UIColor.white
            }
        })
    }
}
