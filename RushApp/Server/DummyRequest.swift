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
        let lambdaName = "RushApp-Test"
        
        let parameters = ["name":"Yilmaz","surname":"Gürsoy"]
        
        self.requestWith(functionName: lambdaName, andParameters: parameters) { (result, error) -> (Void) in
            completionBlock(result, error)            
        }
        
    }
}
