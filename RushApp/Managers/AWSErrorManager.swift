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
            if let userInfo = _error._userInfo {
                if let userInfoType = userInfo["__type"] {
                    if (userInfoType as! String) == ErrorConstants.awsCognitoConfirmEmail {
                        if delegate != nil {
                            delegate.pushViewController(pushViewController: ConfirmEmailVC.createFromStoryboard())
                        }
                    }
                }
            }
        }
    }
    
}
