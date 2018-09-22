//
//  UserCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 22.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func arrangeCell(simpleUser:SimpleUser) {
        self.nameLabel.text = simpleUser.username
        self.profileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
}
