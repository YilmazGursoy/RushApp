//
//  FriendSelectionCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 8.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FriendSelectionCell: UITableViewCell {

    @IBOutlet weak var backHighlightView: UIView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAddImageView: UIImageView!
    @IBOutlet weak var userAddBackGradientView: GradientView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        
    }
}
