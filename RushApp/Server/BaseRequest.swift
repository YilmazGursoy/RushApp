//
//  Request.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSLambda

protocol Request {
    var lambdaName:String? {get}
}

extension Request {
    
    func request<U:Decodable>(parameters:Dictionary<String, Any>, completionBlock:@escaping (AnyObject?,U?,Error?)->Void){
        
        let lambdaInvoker = AWSLambdaInvoker.default()
        RushLogger.requestLog(message: lambdaName!)
        RushLogger.functionParametersLog(message: parameters)
        lambdaInvoker.invokeFunction(lambdaName ?? "", jsonObject: parameters)
            .continueWith(block: {(task:AWSTask<AnyObject>) -> Any? in
                self.handleResponse(withError: task.error, withResult: task.result, withLambdaName: self.lambdaName!)
                if task.result != nil {
                    do {
                        if let theJSONData = try? JSONSerialization.data( withJSONObject: task.result!, options: []) {
                            let object = try JSONDecoder().decode(U.self, from: theJSONData)
                            completionBlock(task.result,object,nil)
                        } else {
                            completionBlock(task.result,nil,nil)
                        }
                    } catch {
                        completionBlock(task.result,nil, error)
                    }
                } else {
                    completionBlock(task.result,nil, task.error)
                }
                return nil
        })
    }
    
    
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
        } else {
            RushLogger.successLog(message: name)
        }
    }
}
