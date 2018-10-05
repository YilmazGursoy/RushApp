//
//  FeedDetailCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedDetailCell: UITableViewCell {

    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var numberOfCommentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var currentFeed:Feed!
    private var likeCompletion:((Bool)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func arrangeCell(feed:Feed, numberOfComments:Int?, likeCompletion:@escaping (Bool)->Void) {
        self.likeCompletion = likeCompletion
        self.currentFeed = feed
        self.profileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: feed.sender.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        self.likeIconImageView.image = UIImage.init(named: "likeIconOff")
        
        Rush.shared.currentUser.likeFeeds?.forEach({ (myFeed) in
            if myFeed.feedId == feed.id {
                self.likeIconImageView.image = UIImage.init(named: "likeIconOn")
            }
        })
        
        self.profileUsername.text = feed.sender.username
        self.numberOfLikeLabel.text = "\(feed.numberOfLike)"
        numberOfComments.map{self.numberOfCommentLabel.text = "\($0)"}
        self.descriptionLabel.text = feed.text
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
        if likeIconImageView.image == UIImage.init(named: "likeIconOff") {
            likeIconImageView.image = UIImage.init(named: "likeIconOn")
            self.currentFeed.numberOfLike += 1
            numberOfLikeLabel.text = "\(self.currentFeed.numberOfLike)"
            likeCompletion?(true)
        } else {
            likeIconImageView.image = UIImage.init(named: "likeIconOff")
            self.currentFeed.numberOfLike -= 1
            if self.currentFeed.numberOfLike < 0 {
                self.currentFeed.numberOfLike = 0
            }
            numberOfLikeLabel.text = "\(self.currentFeed.numberOfLike)"
            likeCompletion?(false)
        }
    }
}
