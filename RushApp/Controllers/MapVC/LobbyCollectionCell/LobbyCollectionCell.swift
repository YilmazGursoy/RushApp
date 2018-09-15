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
    @IBOutlet weak var isSelectedView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var numberOfNeededLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    var completion:(()->Void)!
    var currentLobby:Lobby!
    
    override var isSelected: Bool {
        didSet {
            if !isHighlighted {
                print("isSelected:",isSelected)
                if isSelected {
                    self.selectingUIConfigure()
                } else {
                    self.unselectedUIConfigure()
                }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func arrangeCell(lobby:Lobby, joinTapped:@escaping ()->Void) {
        self.usernameLabel.text = lobby.sender.username
        ImageDownloaderManager.downloadProfileImage(userId: lobby.sender.id, completionBlock: { (url) in
            self.profileImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), completed: nil)
        }) {
            self.profileImageView.image = #imageLiteral(resourceName: "profilePlaceholder")
        }
        self.numberOfNeededLabel.text = "Gamers (max \(lobby.numberOfNeededUser)"
        self.gameImageView.sd_setImage(with: lobby.game.getNormalImageURL(), placeholderImage:#imageLiteral(resourceName: "placeholderImage"), completed: nil)
        self.currentLobby = lobby
        completion = joinTapped
    }
    @IBAction func joinTapped(_ sender: UIButton) {
        completion()
    }
    
    private func selectingUIConfigure(){
        self.cellBackGradientView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
        self.cellBackGradientView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
        self.cellBackGradientView.backgroundColor = .clear
        self.gradientView.topColor = .clear
        self.gradientView.bottomColor = .clear
        self.gradientView.backgroundColor = .white
        self.joinLabel.textColor = .black
        self.usernameLabel.textColor = .white
        self.numberOfNeededLabel.textColor = .white
    }
    
    private func unselectedUIConfigure(){
        self.cellBackGradientView.topColor = .clear
        self.cellBackGradientView.bottomColor = .clear
        self.cellBackGradientView.backgroundColor = .white
        self.cellBackGradientView.borderColor = #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
        self.gradientView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
        self.gradientView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
        self.joinLabel.textColor = .white
        self.usernameLabel.textColor = .black
        self.numberOfNeededLabel.textColor = .black
    }
    
}
