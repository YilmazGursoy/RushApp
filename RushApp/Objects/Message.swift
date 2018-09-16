//
//  Message.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Message: Codable {
    let id: String
    let name: String
    let message: String
    let date: String
}
