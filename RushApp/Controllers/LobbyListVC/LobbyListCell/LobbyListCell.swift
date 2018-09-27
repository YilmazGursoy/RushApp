//
//  LobbyListCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage

class LobbyListCell: UITableViewCell {
    @IBOutlet weak var lobbyBackView: UIView!
    @IBOutlet weak var lobbyImageView: UIImageView!
    @IBOutlet weak var lobbyGamePlatformImageView: UIImageView!
    @IBOutlet weak var lobbyGameName: UILabel!
    @IBOutlet weak var lobbyGameNeededPlayerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func arrangeCell(lobby:Lobby, index:Int) {
        self.lobbyGamePlatformImageView.image = lobby.platform.getPlatformLobbyImage()
        self.lobbyImageView.sd_setImage(with: lobby.game.getNormalImageURL(), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .cacheMemoryOnly, completed: nil)
        self.lobbyGameName.text = lobby.game.name
        self.lobbyGameNeededPlayerLabel.text = "Gamers (max \(lobby.numberOfNeededUser))"
        if index % 2 == 0 {
            self.lobbyBackView.backgroundColor = .white
        } else {
            self.lobbyBackView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 0.26)
        }
    }
    
}
