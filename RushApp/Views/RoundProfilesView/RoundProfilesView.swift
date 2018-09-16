//
//  RoundProfilesView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 16.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class RoundProfilesView: UIView {

    @IBOutlet weak var secondBackView: GradientView!
    @IBOutlet weak var firstBackView: GradientView!
    @IBOutlet weak var thirdBackView: GradientView!
    @IBOutlet weak var firstProfileImageView: UIImageView!
    @IBOutlet weak var secondProfileImageView: UIImageView!
    @IBOutlet weak var thirdProfileImageView: UIImageView!
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing:  "RoundProfilesView"), owner: nil, options: nil)![0] as! T
    }
    
    func create(userList:[SimpleUser]) {
        for (index, simpleUser) in userList.enumerated() {
            if index == 0 {
                firstBackView.isHidden = false
                firstProfileImageView.isHidden = false
                firstProfileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options:.cacheMemoryOnly, completed: nil)
            } else if index == 1 {
                secondBackView.isHidden = false
                secondProfileImageView.isHidden = false
                secondProfileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options:.cacheMemoryOnly ,completed: nil)
            } else if index == 3 {
                thirdBackView.isHidden = false
                thirdProfileImageView.isHidden = false
                thirdProfileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options:.cacheMemoryOnly ,completed: nil)
            } else {
                return
            }
        }
    }
}
