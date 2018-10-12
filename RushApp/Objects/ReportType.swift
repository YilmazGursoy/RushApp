//
//  ReportType.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 12.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

enum ReportType : Int {
    case spam
    case naked
    case harassing
}

enum ReportValue{
    case user
    case lobby
    case feed
    case comment
}
