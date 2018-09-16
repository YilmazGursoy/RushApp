//
//  ProfileLobbyCollectionCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileLobbyCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lobbyImageView: UIImageView!
    @IBOutlet weak var lobbyNameLabel: UILabel!
    
    var isTouched: Bool = false {
        didSet {
            var transform = CGAffineTransform.identity
            if isTouched { transform = transform.scaledBy(x: 0.96, y: 0.96) }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func arrangeCell(lobby:Lobby) {
        self.lobbyNameLabel.text = lobby.name
        self.lobbyImageView.sd_setImage(with: lobby.game.getLobbyImageURL(), placeholderImage: #imageLiteral(resourceName: "placeholderImage"), completed: nil)
    }

}

//MARK: Custom Animation
extension ProfileLobbyCollectionCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouched = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouched = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouched = false
    }
    
}
