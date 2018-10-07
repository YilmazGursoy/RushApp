//
//  LobbyRequestCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class LobbyRequestCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var applyTapped:(()->Void)?
    private var cancelTapped:(()->Void)?
    private var profileTapped:((String)->Void)?
    private var currentUserId:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
    }
    
    func arrangeCell(lobbyRequest:LobbyRequestModel, applyTapped:@escaping ()->Void, cancelTapped:@escaping ()->Void, profileTapped:@escaping (String)->Void) {
        
        self.currentUserId = lobbyRequest.userId
        self.applyTapped = applyTapped
        self.cancelTapped = cancelTapped
        self.profileTapped = profileTapped
        
        self.messageLabel.text = "\(lobbyRequest.username) seni lobiye davet ediyor!"
        self.profilePictureImageView.sd_setImage(with: User.getProfilePictureFrom(userId: lobbyRequest.userId), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        applyTapped?()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        cancelTapped?()
    }
    @IBAction func profileTapped(_ sender: Any) {
        profileTapped?(currentUserId)
    }
}
