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
    
    private var openProfileTapped:((String)->Void)!
    private var currentLobby:Lobby!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func arrangeCell(lobby:Lobby, openProfileTapped:@escaping (String)->Void) {
        self.openProfileTapped = openProfileTapped
        self.currentLobby = lobby
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "tr_TR")
        dateFormatter.dateFormat = "dd MMMM, HH:mm"
        self.lobbyDetailImageView.sd_setImage(with: lobby.game.getNormalImageURL(), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), completed: nil)
        self.gameNameLabel.text = lobby.game.name
        self.descriptionLabel.text = lobby.description
        ImageDownloaderManager.downloadProfileImage(userId: lobby.sender.id, completionBlock: { (url) in
            self.senderProfileImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), completed: nil)
        }) {
            self.senderProfileImageView.image = #imageLiteral(resourceName: "profilePlaceholder")
        }
        
        self.lobbyCreatingDate.text = dateFormatter.string(from: lobby.date)
        self.senderUsername.text = lobby.sender.username
        self.lobbyCreatingLocation.text = lobby.address
        self.lobbyNumberOfNeededGamersLabel.text = "Gamers (max \(lobby.numberOfNeededUser))"
    }
    
    @IBAction func openProfileTapped(_ sender: UIButton) {
        self.openProfileTapped(self.currentLobby.sender.id)
    }
    
}
