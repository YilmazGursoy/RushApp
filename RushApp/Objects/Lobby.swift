//
//  Lobby.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

enum LobbyStatus {
    case open
    case gaming
    case close
}

struct Lobby: Decodable {
    let id: String
    let isActive: Bool
    let address: String
    let description: String
    let date: String
    let latitude: Double
    let longitude: Double
    let sender: Sender
    let subscribers: [Subscriber]
    let game: Game
    let platform: Int
    let lobbyHasChat: Bool
    let lobbyStatus:Int
    let numberOfNeededUser:Int
}
