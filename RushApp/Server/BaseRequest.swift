//
//  BaseRequest.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSLambda

class BaseRequest: NSObject {
    var customErrorMessage: String?
    var showError = true
    var showUserInfoError = false
    
}

extension BaseRequest {
    
    func requestWith(functionName name:String, andParameters parameters:Any?, withCompletionBlock completionBlock:@escaping (AnyObject?,Error?) -> (Void))  {
        let lambdaInvoker = AWSLambdaInvoker.default()
        RushLogger.requestLog(message: name)
        RushLogger.functionParametersLog(message: parameters)
        lambdaInvoker.invokeFunction(name, jsonObject: parameters)
            .continueWith(block: {(task:AWSTask<AnyObject>) -> Any? in
                
                self.handleResponse(withError: task.error, withResult: task.result, withLambdaName: name)
                completionBlock(task.result,task.error)
                
                return nil
            })
    }
    
    func requestWith(functionName name:String, andParametersArray parameters:[Dictionary<String,Any>]?, withCompletionBlock completionBlock:@escaping (AnyObject?,Error?) -> (Void))  {
        let lambdaInvoker = AWSLambdaInvoker.default()
        
        lambdaInvoker.invokeFunction(name, jsonObject: parameters)
            .continueWith(block: {(task:AWSTask<AnyObject>) -> Any? in
                
                self.handleResponse(withError: task.error, withResult: task.result, withLambdaName: name)
                completionBlock(task.result,task.error)
                
                return nil
            })
    }
    
    private func handleResponse(withError error: Error?, withResult result:Any?, withLambdaName name: String) {
        if error != nil {
            RushLogger.errorLog(message: name)
            AWSErrorManager.shared.errorControl(error: error!)
            print(error!)
        } else {
            RushLogger.successLog(message: name)
            print(result!)
        }
    }
}
