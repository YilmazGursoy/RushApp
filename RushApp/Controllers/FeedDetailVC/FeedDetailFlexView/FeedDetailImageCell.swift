//
//  FeedDetailImageCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 26.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage

class FeedDetailImageCell: UITableViewCell {

    @IBOutlet weak var feedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func arrangeDetailFlexTitle(url:URL?) {
        self.feedImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .continueInBackground, completed: nil)
    }
}
