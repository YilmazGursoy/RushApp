//
//  FeedDetailCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedDetailCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var numberOfCommentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func arrangeCell(feed:Feed) {
        self.profileImageView.sd_setImage(with: feed.sender.profilePic, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        self.profileUsername.text = feed.sender.username
        self.numberOfLikeLabel.text = "\(feed.numberOfLike)"
        self.numberOfCommentLabel.text = "\(feed.numberOfShare)"
        self.descriptionLabel.text = feed.text
    }
    
}
