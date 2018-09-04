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
    
    
    func sendGameListRequest(completionBlock: @escaping (GameListModel? ,Error?) -> Void) {
        
        self.requestWithParameters { (response:RushResponse<Game>?, error:Error?) in
            
        }
        
//        self.requestWith(functionName: lambdaName, andParameters: parameter) { (result, error) -> (Void) in
//
//            do {
//                if let theJSONData = try? JSONSerialization.data( withJSONObject: result, options: []) {
//                    let myStructArray = try JSONDecoder().decode([Game].self, from: theJSONData)
//
//                    print(myStructArray)
//                }
//            } catch {
//                print(error)
//            }
//            completionBlock(nil,error);
//        }
    }
}
