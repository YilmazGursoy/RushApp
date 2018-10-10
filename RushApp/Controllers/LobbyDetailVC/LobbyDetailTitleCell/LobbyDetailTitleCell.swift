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
    
    //MARK: Subs Images
    
    @IBOutlet weak var sub1ImageView: UIImageView!
    @IBOutlet weak var sub2ImageView: UIImageView!
    @IBOutlet weak var sub3ImageView: UIImageView!
    @IBOutlet weak var sub4ImageView: UIImageView!
    @IBOutlet weak var sub5ImageView: UIImageView!
    
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
        self.lobbyDetailImageView.sd_setImage(with: lobby.game.getLobbyImageURL(), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), completed: nil)
        self.gameNameLabel.text = lobby.game.name
        self.descriptionLabel.text = lobby.description
        
        self.senderProfileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: lobby.sender.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options:.cacheMemoryOnly, completed: nil)
        
        self.lobbyCreatingDate.text = dateFormatter.string(from: lobby.date)
        self.senderUsername.text = lobby.sender.username
        self.lobbyCreatingLocation.text = lobby.address
        self.lobbyNumberOfNeededGamersLabel.text = "Oyuncular (max \(lobby.numberOfNeededUser))"
        self.subsImagesCreate()
    }
    
    private func subsImagesCreate(){
        for (index, simpleUser) in self.currentLobby.subscribers.enumerated() {
            if index == 0 {
                self.sub1ImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            } else if index == 1 {
                self.sub2ImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            } else if index == 2 {
                self.sub3ImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            } else if index == 3 {
                self.sub4ImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            }  else if index == 4 {
                self.sub5ImageView.sd_setImage(with: User.getProfilePictureFrom(userId: simpleUser.id), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            }
        }
    }
    
    @IBAction func openProfileTapped(_ sender: UIButton) {
        self.openProfileTapped(self.currentLobby.sender.id)
    }
    @IBAction func openSubProfileTapped(_ sender: UIButton) {
        if sender.tag < self.currentLobby.subscribers.count {
            self.openProfileTapped(self.currentLobby.subscribers[sender.tag].id)
        }
    }
}
