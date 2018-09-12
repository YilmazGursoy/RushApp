//
//  LobbyDetailTitleCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class LobbyDetailTitleCell: UITableViewCell {
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var lobbyDetailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var senderProfileImageView: UIImageView!
    @IBOutlet weak var senderUsername: UILabel!
    @IBOutlet weak var lobbyCreatingDate: UILabel!
    @IBOutlet weak var lobbyCreatingLocation: UILabel!
    @IBOutlet weak var lobbyNumberOfNeededGamersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func arrangeCell(lobby:Lobby) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "tr_TR")
        dateFormatter.dateFormat = "dd MMMM, HH:mm"
        self.lobbyDetailImageView.sd_setImage(with: lobby.game.getNormalImageURL(), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .cacheMemoryOnly, completed: nil)
        self.gameNameLabel.text = lobby.game.name
        self.descriptionLabel.text = lobby.description
        self.senderProfileImageView.sd_setImage(with: lobby.sender.profilePic, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        self.lobbyCreatingDate.text = dateFormatter.string(from: lobby.date)
        self.senderUsername.text = lobby.sender.username
        self.lobbyCreatingLocation.text = lobby.address
        self.lobbyNumberOfNeededGamersLabel.text = "Gamers (max \(lobby.numberOfNeededUser))"
    }
    
}
