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
        
            
        }
        
    }
}
