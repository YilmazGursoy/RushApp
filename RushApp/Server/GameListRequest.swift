//
//  GameListRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class GameListRequest: BaseRequest {
    
    func sendGameListRequest(completionBlock: @escaping (GameListModel? ,Error?) -> Void) {
        let lambdaName = "RushApp-GameList"
        let parameter = ["":""]
        
        self.requestWith(functionName: lambdaName, andParameters: parameter) { (result, error) -> (Void) in
            if let games = result as? Array<Any> {
                let gameListModel = GameListModel()
                gameListModel.list = []
                games.forEach({ (game) in
                    if let gameModel = game as? NSDictionary {
                        let gameObject = Game(id: gameModel["ID"] as! Int, name: gameModel["name"] as! String, thumbImage: gameModel["thumbImage"] as! String, normalImage: gameModel["normalImage"] as! String, isActive: false)
                        gameListModel.list.append(gameObject)
                    }
                })
                completionBlock(gameListModel, nil)
            }
            completionBlock(nil,error);
        }
    }
}
