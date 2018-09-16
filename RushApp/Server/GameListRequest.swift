//
//  GameListRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class GameListRequest: Request {
    
    var lambdaName: String? {
        return LambdaConstants.GetGameList
    }
    
    func sendGameListRequest(completionBlock: @escaping ([Game]? ,Error?) -> Void) {
        self.request(parameters: [:]) { (result:AnyObject? ,response:[Game]?, error:Error?) in
            completionBlock(response, error)
        }
    }
}
