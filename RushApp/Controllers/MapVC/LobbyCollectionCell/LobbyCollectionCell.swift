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
    @IBOutlet weak var cellBackGradientView: GradientView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var numberOfNeededLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var subsBackView: UIView!
    
    var completion:(()->Void)!
    var currentLobby:Lobby!
    
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
    
    func arrangeCell(lobby:Lobby, joinTapped:@escaping ()->Void) {
        self.usernameLabel.text = lobby.game.name
        self.profileImageView.image = lobby.platform.getPlatformLobbyImage()
        joinLabel.text = "Katıl"
        lobby.subscribers.forEach { (simpleUser) in
            if Rush.shared.currentUser.userId == simpleUser.id {
                joinLabel.text = "Detay"
            }
        }
        self.numberOfNeededLabel.text = "Oyuncular (max \(lobby.numberOfNeededUser))"
        self.gameImageView.sd_setImage(with: lobby.game.getLobbyImageURL(), placeholderImage:#imageLiteral(resourceName: "placeholderImage"), completed: nil)
        self.currentLobby = lobby
        completion = joinTapped
        self.setupSubsView()
    }
    @IBAction func joinTapped(_ sender: UIButton) {
        completion()
    }
    
    private func setupSubsView(){
        let subsView = RoundProfilesView.fromNib() as! RoundProfilesView
        subsView.create(userList: currentLobby.subscribers)
        subsView.frame = self.subsBackView.bounds
        self.subsBackView.addSubview(subsView)
    }
    
}


//MARK: Custom Animation
extension LobbyCollectionCell {
    
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
