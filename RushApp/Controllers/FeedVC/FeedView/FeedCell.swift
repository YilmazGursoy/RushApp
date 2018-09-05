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
    
    var isTouched: Bool = false {
        didSet {
            var transform = CGAffineTransform.identity
            if isTouched { transform = transform.scaledBy(x: 0.96, y: 0.96) }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouched = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouched = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouched = false
    }
    
    func arrangeCell(feed:Feed) {
        self.usernameLabel.text = feed.sender.username
        self.feedDescriptionLabel.text = feed.text
        self.numberOfLikeLabel.text = "\(feed.numberOfLike)"
        self.numberOfShareLabel.text = "\(feed.numberOfShare)"
        
        self.profileImageView.sd_setImage(with: feed.sender.profilePic, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .continueInBackground, completed: nil)
        self.feedImageView.sd_setImage(with: feed.picture, placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .continueInBackground, completed: nil)
    }
}

