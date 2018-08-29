//
//  DummyRequest.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation


class DummyRequest: BaseRequest {
    
    func sendDummyRequest(completionBlock: @escaping (Any? ,Error?) -> Void) {
        let lambdaName = "RushApp-Configurations"
        
        self.requestWith(functionName: lambdaName, andParameters: [:]) { (result, error) -> (Void) in
            completionBlock(result, error)            
        }
        
    }
}
