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
}
