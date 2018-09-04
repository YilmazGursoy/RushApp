//
//  FeedCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 3.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feedDescriptionLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var numberOfShareLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func arrangeCell(feed:Feed) {
        self.usernameLabel.text = feed.sender.username
        self.feedDescriptionLabel.text = feed.text
        self.numberOfLikeLabel.text = "\(feed.numberOfLike)"
        self.numberOfShareLabel.text = "\(feed.numberOfShare)"
        
        self.profileImageView.sd_setImage(with: feed.sender.profilePic, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .avoidAutoSetImage, completed: nil)
        self.feedImageView.sd_setImage(with: feed.picture, placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .avoidAutoSetImage, completed: nil)
    }
    @IBAction func feedTapped(_ sender: UIButton) {
        print("Feed")
    }
    
}
