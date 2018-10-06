//
//  Lobby.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

enum LobbyStatus : Int, Codable {
    case open
    case gaming
    case close
}

struct Lobby: Decodable {
    let id: String
    let name:String
    let userId:String
    let isActive: Bool
    let address: String
    let description: String
    let date: Date
    let latitude: Double
    let longitude: Double
    let sender: SimpleUser
    let subscribers: [SimpleUser]
    let game: Game
    let platform: Platform
    let lobbyHasChat: Bool
    let lobbyStatus:LobbyStatus
    let numberOfNeededUser:Int
}

