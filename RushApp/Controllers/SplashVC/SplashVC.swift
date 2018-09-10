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
        Rush.shared.ages = Array.init(repeating: false, count: 4)
        let checkUser = CheckUserRequest()
        
        AWSCredentialManager.shared.isUserLoggedIn { (isLoggedIn) in
            if isLoggedIn == true {
                
                checkUser.sendCheckUserRequest(completionBlock: { (user, error) in
                    if error != nil {
                        AWSCredentialManager.shared.logout()
                        self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
                    } else {
                        Rush.shared.currentUser = user
                        DispatchQueue.main.async {
                            let window = UIApplication.shared.keyWindow
                            let tabbarController = TabBarController()
                            window?.rootViewController = tabbarController
                            window?.makeKeyAndVisible()
                        }
                    }
                })
            } else {
                self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
