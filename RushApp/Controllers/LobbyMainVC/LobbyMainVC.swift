//
//  LobbyMainVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 9.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

let kChangeLobbyTypeNotificationKey = "changeLobbyTypeNotificationKey"

class LobbyMainVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func changeLobbyViewTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            NotificationCenter.default.post(name: Notification.Name(kChangeLobbyTypeNotificationKey), object: 0)
        } else {
            sender.isSelected = true
            NotificationCenter.default.post(name: Notification.Name(kChangeLobbyTypeNotificationKey), object: 1)
        }
    }
}
