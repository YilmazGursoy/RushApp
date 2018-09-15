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
        case .empty:
            return #imageLiteral(resourceName: "placeholderImage")
        }
    }
    
}

