//
//  AWSNetworkErrorManager.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AWSErrorManagerProtocol {
    
    func forceOpenViewController(forceViwController:UIViewController?)
    func pushViewController(pushViewController:UIViewController?)
    func errorMessage(message:String)
    
}

class AWSErrorManager {
    static let shared = AWSErrorManager()
    var delegate:AWSErrorManagerProtocol!
    
    func errorControl(error:Error?, completion:()->Void) {
        
        if let _error = error {
            switch _error._code {
            case ErrorConstants.awsCognitoConfirmEmailCode:
                if delegate != nil {
                    delegate.pushViewController(pushViewController: ConfirmEmailVC.createFromStoryboard())
                    return
                } else {
                    completion()
                }
            case ErrorConstants.awsCognitoSignoutCode:
                if delegate != nil {
                    delegate.forceOpenViewController(forceViwController: LoginVC.createFromStoryboard())
                } else {
                    completion()
                }
            default:
                RushLogger.errorLog(message: "Not defining Error with code \(_error._code)")
                if delegate != nil {
                    
                    return
                }
            }
        }
    }
    
    func errorControl(error:Error?, userName:String, completion:()->Void) {
        SVProgressHUD.dismiss()
        if let _error = error {
            switch _error._code {
            case ErrorConstants.awsCognitoConfirmEmailCode:
                if delegate != nil {
                    let vc = ConfirmEmailVC.createFromStoryboard()
                    vc.email = userName
                    delegate.pushViewController(pushViewController: vc)
                    return
                } else {
                    completion()
                }
            case ErrorConstants.awsCognitoSignoutCode:
                if delegate != nil {
                    delegate.forceOpenViewController(forceViwController: LoginVC.createFromStoryboard())
                } else {
                    completion()
                }
            default:
                RushLogger.errorLog(message: "Not defining Error with code \(_error._code)")
                if delegate != nil {
                    delegate.errorMessage(message: "Username or Password incorrect.")
                    return
                }
            }
        }
    }
    
}
