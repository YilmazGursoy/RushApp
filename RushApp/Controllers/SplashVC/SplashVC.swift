//
//  SplashVC.swift
//  RushApp
//
//  Created by Most Wanted on 1.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class SplashVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkUser = CheckUserRequest()
        
        self.navigationController?.openForceVCMainThread(MapVC.createFromStoryboard())
        
        AWSCredentialManager.shared.isUserLoggedIn { (isLoggedIn) in
            if isLoggedIn == true {
                checkUser.sendCheckUserRequest(completionBlock: { (result, error) in
                    if error != nil {
                        AWSCredentialManager.shared.logout()
                        self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
                    } else {
                        self.navigationController?.openForceVCMainThread(FeedVC.createFromStoryboard())
                    }
                })
            } else {
                self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
