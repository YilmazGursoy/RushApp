//
//  ProfileRankCollectionCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class ProfileRankCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func arrangeCell(profileUrls:SocialURL) {
        let platform = Platform.getPlatformModel(index: profileUrls.platform)
        self.name.text = platform.getPlatformName()
        self.imageView.image = platform.getPlatformImage()
    }
    
}
