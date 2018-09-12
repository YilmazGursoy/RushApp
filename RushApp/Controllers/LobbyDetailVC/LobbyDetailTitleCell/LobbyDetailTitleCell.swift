//
//  LobbyDetailTitleCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class LobbyDetailTitleCell: UITableViewCell {
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
        
    }
    
}
