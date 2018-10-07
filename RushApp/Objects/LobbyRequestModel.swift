//
//  LobbyRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct LobbyRequestModel : Codable {
    let lobbyId:String
    let lobbyUserId:String
    let username:String
    let userId:String
}
