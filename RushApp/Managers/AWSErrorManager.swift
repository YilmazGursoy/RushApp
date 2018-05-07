//
//  AWSNetworkErrorManager.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

protocol AWSErrorManagerProtocol {
    
    func forceOpenViewController(forceViwController:UIViewController?)
    func pushViewController(pushViewController:UIViewController?)
    
}

class AWSErrorManager {
    static let shared = AWSErrorManager()
    var delegate:AWSErrorManagerProtocol!
    
    func errorControl(error:Error?) {
        
        if let _error = error {
            switch _error._code {
            case ErrorConstants.awsCognitoConfirmEmailCode:
                if delegate != nil {
                    delegate.pushViewController(pushViewController: ConfirmEmailVC.createFromStoryboard())
                    return
                }
            case ErrorConstants.awsCognitoSignoutCode:
                if delegate != nil {
                    delegate.forceOpenViewController(forceViwController: LoginVC.createFromStoryboard())
                }
            default:
                RushLogger.errorLog(message: "Not defining Error with code \(_error._code)")
            }
        }
    }
    
}
