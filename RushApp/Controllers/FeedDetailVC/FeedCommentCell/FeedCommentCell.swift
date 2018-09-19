//
//  FeedCommentCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedCommentCell: UITableViewCell {

    @IBOutlet weak var userProfilePicImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func arrange(comment:Comment) {
        self.usernameLabel.text = comment.senderUserName
        self.userProfilePicImageView.sd_setImage(with: User.getProfilePictureFrom(userId: comment.senderUserId), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        self.messageLabel.text = comment.message
    }
    
}
