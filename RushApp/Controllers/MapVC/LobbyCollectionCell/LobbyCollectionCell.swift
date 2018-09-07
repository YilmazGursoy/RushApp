//
//  LobbyCollectionCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage

class LobbyCollectionCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var numberOfNeededLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var completion:(()->Void)!
    var currentLobby:Lobby!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func arrangeCell(lobby:Lobby, joinTapped:@escaping ()->Void) {
        self.usernameLabel.text = lobby.sender.username
        self.profileImageView.sd_setImage(with: lobby.sender.profilePic, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        
        self.numberOfNeededLabel.text = "Gamers (max \(lobby.numberOfNeededUser)"
        self.gameImageView.sd_setImage(with: lobby.game.getNormalImageURL(), placeholderImage:#imageLiteral(resourceName: "placeholderImage"), options: .cacheMemoryOnly, completed: nil)
        self.currentLobby = lobby
        completion = joinTapped
    }
    @IBAction func joinTapped(_ sender: UIButton) {
        completion()
    }
}
