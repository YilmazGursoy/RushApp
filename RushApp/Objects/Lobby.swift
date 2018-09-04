//
//  Lobby.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Lobby: Codable {
    let id: String
    let isActive: Bool
    let address: String
    let description: String
    let date: String
    let latitude: Double
    let longitude: Double
    let messages: [Message]
    let sender: Sender
    let subscribers: [Subscriber]
    
    let game: Game
}
