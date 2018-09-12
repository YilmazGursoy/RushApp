//
//  Rush.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class Rush {
    static let shared = Rush()
    var currentUser:User!
    var gameList:[Game]!
    var ages:[Bool]!
    var filterPlatform:Platform!
    var filterGame:Game?
    var firToken:String?
}

extension Rush {
    static func resetFilters(){
        Rush.shared.filterGame = nil
        Rush.shared.filterPlatform = .empty
        Rush.shared.ages = Array.init(repeating: false, count: 4)
    }
}

enum Platform : Int {
    case playstation
    case steam
    case xbox
    case origin
    case battleNet
    case epicGames
    case lol
    case empty
}

extension Platform {
    func getPlatformName()->String {
        switch self {
        case .playstation:
            return "Playstation"
        case .steam:
            return "Steam"
        case .xbox:
            return "XBOX Live"
        case .battleNet:
            return "Battle.net"
        case .origin:
            return "Origin"
        case .lol:
            return "League of Legends"
        case .epicGames:
            return "Epic Games"
        case .empty:
            return ""
        }
    }
    
    static func getPlatformFromString(type:String) -> Platform {
        
        if type == "Playstation" {
            return .playstation
        } else if type == "Steam" {
            return .steam
        } else if type == "XBOX Live" {
            return .xbox
        } else if type == "Battle.net" {
            return .battleNet
        } else if type == "Origin" {
            return .origin
        } else if type == "League of Legends" {
            return .lol
        } else if type == "Epic Games" {
            return .epicGames
        } else {
            return .empty
        }
    }    
}

