//
//  GameListModel.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Game: Decodable {
    let id: String
    let name: String
    var thumbImage:String?
    var normalImage:String?
    var isActive:Bool?
}

extension Game {
    func getThumbImageURL()->URL {
        let imageUrl = thumbImage?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let baseImage = ConstantUrls.rushGameImagesBaseURL + imageUrl!
        return URL.init(string: baseImage)!
    }
    
    func getNormalImageURL()->URL {
        let imageUrl = normalImage?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let baseImage = ConstantUrls.rushGameImagesBaseURL + imageUrl!
        return URL.init(string: baseImage)!
    }
}
