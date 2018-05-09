//
//  ForgotPasswordVC.swift
//  RushApp
//
//  Created by Most Wanted on 8.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//MARK: -
//MARK: -- ForgotPasswordRequest
extension ForgotPasswordVC {
    func sendForgotPasswordRequest(){
        AWSCredentialManager.shared.getUserPool { (pool) in
            pool.getUser("currentUser").changePassword("current", proposedPassword: "new").continueWith(block: { (task) -> Any? in
                
                
                
            })
        }
    }
}
