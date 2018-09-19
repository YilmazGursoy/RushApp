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
}

class LobbyDetailOneButtonCell: UITableViewCell {
    
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
        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonTapped()
    }
    
}
