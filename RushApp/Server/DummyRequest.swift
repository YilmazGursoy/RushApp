//
//  DummyRequest.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation


class DummyRequest: Request {
    var lambdaName: String?
    
    
    func sendDummyRequest(completionBlock: @escaping (Any? ,Error?) -> Void) {
        let lambdaName = LambdaConstants.GetConfiguration
        
//        self.requestWith(functionName: lambdaName, andParameters: [:]) { (result, error) -> (Void) in
//            completionBlock(result, error)            
//        }
        
    }
}
