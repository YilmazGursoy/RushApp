//
//  LobbyDetailOneButtonCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 19.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

enum OneButtonType {
    case addPlayer
    case startTheGame
    case joinGame
    case startGameChat
    case closeLobby
}

class LobbyDetailOneButtonCell: UITableViewCell {
    
    @IBOutlet weak var backGradientView: GradientView!
    @IBOutlet weak var button: UIButton!
    var buttonTapped:(()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func arrangeCell(type:OneButtonType, tapped:@escaping ()->Void) {
        buttonTapped = tapped
        switch type {
        case .addPlayer:
            break
        case .joinGame:
            button.setImage(nil, for: .normal)
            button.setTitle("Oyuna Katıl", for: .normal)
        case .startTheGame:
            button.setImage(nil, for: .normal)
            button.setTitle("Oyunu Başlat", for: .normal)
        case .startGameChat:
            button.setImage(UIImage.init(named: "gameChatButtonImage"), for: .normal)
            button.setTitle("  Lobi Sohbetini Başlat", for: .normal)
            backGradientView.topColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 0.5)
            backGradientView.bottomColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 0.5)
        case .closeLobby:
            button.setImage(nil, for: .normal)
            button.setTitle("Oyunu Bitir", for: .normal)
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonTapped()
    }
    
}
