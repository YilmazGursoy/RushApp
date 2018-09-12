//
//  Subscriber.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Subscriber: Decodable {
    let id: Int
    let username: String
    let profilePic: URL
}

