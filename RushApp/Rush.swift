//
//  Rush.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

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

enum Platform : Int, Codable {
    case playstation
    case steam
    case xbox
    case origin
    case battleNet
    case epicGames
    case lol
    case nintendo
    case discord
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
        case .nintendo:
            return "Nintendo"
        case .discord:
            return "Discord"
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
        } else if type == "Nintendo" {
            return .nintendo
        } else if type == "Discord" {
            return .discord
        } else {
            return .empty
        }
    }
    
    static func getPlatformModel(index:Int) -> Platform {
        if index == 0 {
            return .playstation
        } else if index == 1 {
            return .steam
        } else if index == 2 {
            return .xbox
        } else if index == 3 {
            return .origin
        } else if index == 4 {
            return .battleNet
        } else if index == 5 {
            return .epicGames
        } else if index == 6 {
            return .lol
        } else if index == 7 {
            return .nintendo
        } else if index == 8 {
            return .discord
        } else {
            return .empty
        }
    }
    
    func getPlatformImage()->UIImage {
        switch self {
        case .playstation:
            return #imageLiteral(resourceName: "psn")
        case .steam:
            return #imageLiteral(resourceName: "steam")
        case .xbox:
            return #imageLiteral(resourceName: "xbox")
        case .battleNet:
            return #imageLiteral(resourceName: "battleNet")
        case .origin:
            return #imageLiteral(resourceName: "origin")
        case .lol:
            return #imageLiteral(resourceName: "lol")
        case .epicGames:
            return #imageLiteral(resourceName: "epicGames")
        case .nintendo:
            return #imageLiteral(resourceName: "nintendoSwitch")
        case .discord:
            return #imageLiteral(resourceName: "discord")
        case .empty:
            return #imageLiteral(resourceName: "placeholderImage")
        }
    }
    
    func getPlatformLobbyImage()->UIImage {
        switch self {
        case .playstation:
            return #imageLiteral(resourceName: "psnWhite")
        case .steam:
            return #imageLiteral(resourceName: "steamWhite")
        case .xbox:
            return #imageLiteral(resourceName: "xboxWhite")
        case .battleNet:
            return #imageLiteral(resourceName: "battleNetWhite")
        case .origin:
            return #imageLiteral(resourceName: "originWhite")
        case .lol:
            return #imageLiteral(resourceName: "lolWhite")
        case .epicGames:
            return #imageLiteral(resourceName: "epicGamesWhite")
        case .nintendo:
            return #imageLiteral(resourceName: "nintendoWhite")
        case .discord:
            return #imageLiteral(resourceName: "discordWhite")
        case .empty:
            return #imageLiteral(resourceName: "placeholderImage")
        }
    }
}

