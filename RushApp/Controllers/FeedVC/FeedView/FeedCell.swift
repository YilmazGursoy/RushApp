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
    
    @IBOutlet private weak var likeIconImageView: UIImageView!
    @IBOutlet private weak var pictureBackView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var feedDescriptionLabel: UILabel!
    @IBOutlet private weak var feedImageView: UIImageView!
    @IBOutlet private weak var numberOfLikeLabel: UILabel!
    @IBOutlet private weak var numberOfShareLabel: UILabel!
    
    private var didSelectCompletion:((UIView,Int)->Void)?
    private var sendLike:((Int,Bool)->Void)?
    private var currentFeed:Feed!
    private var indexPath:IndexPath!
    
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
    
    func arrangeCell(feed:Feed, indexPath:IndexPath,selectCompletion:@escaping (UIView,Int)->Void, sendLike:@escaping (Int,Bool)->Void) {
        self.sendLike = sendLike
        self.currentFeed = feed
        self.usernameLabel.text = feed.sender.username
        self.feedDescriptionLabel.text = feed.text
        self.numberOfLikeLabel.text = "\(feed.numberOfLike)"
        self.numberOfShareLabel.text = "\(feed.numberOfComment ?? 0)"
        if let feedImage = feed.picture {
            self.pictureBackView.isHidden = false
            self.feedImageView.sd_setImage(with: feedImage, placeholderImage: #imageLiteral(resourceName: "placeholderImage"), completed: nil)
        } else{
            self.pictureBackView.isHidden = true
        }
        var isLike = false
        Rush.shared.currentUser.likeFeeds?.forEach({ (stepFeed) in
            if stepFeed.feedId == feed.id {
                isLike = true
                self.likeIconImageView.image = #imageLiteral(resourceName: "likeIconOn")
            }
        })
        
        if isLike == false {
            self.likeIconImageView.image = #imageLiteral(resourceName: "likeIconOff")
        }
        
        self.dateLabel.text = Date().offset(from: Date.init(timeIntervalSince1970: feed.date.timeIntervalSinceReferenceDate))
        self.profileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: feed.sender.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), completed: nil)
        self.didSelectCompletion = selectCompletion
        self.indexPath = indexPath
    }
    @IBAction func likeTapped(_ sender: UIButton) {
        if self.likeIconImageView.image == #imageLiteral(resourceName: "likeIconOn") {
            self.likeIconImageView.image = #imageLiteral(resourceName: "likeIconOff")
            sendLike?(self.indexPath.row, false)
            self.numberOfLikeLabel.text = "\((self.numberOfLikeLabel.text! as NSString).intValue - 1)"
        } else {
            self.likeIconImageView.image = #imageLiteral(resourceName: "likeIconOn")
            sendLike?(self.indexPath.row, true)
            self.numberOfLikeLabel.text = "\(self.currentFeed.numberOfLike+1)"
        }
    }
}

//MARK: Custom Animation
extension FeedCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouched = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.didSelectCompletion!(self.pictureBackView,indexPath.row)
        isTouched = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("Cancel!")
        isTouched = false
    }
    
}
