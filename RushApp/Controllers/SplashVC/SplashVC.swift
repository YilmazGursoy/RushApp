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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CacheManager.shared.getCachedObject(withKey: CacheConstants.OnboardingCacheKey) == nil {
            pushOnboardingVC()
        } else {
            checkUserAndPushViews()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension SplashVC {
    
    func pushOnboardingVC(){
        self.navigationController?.pushVCMainThread(OnboardingVC.createFromStoryboard())
    }
    
    func checkUserAndPushViews(){
        Rush.shared.ages = Array.init(repeating: false, count: 4)
        Rush.shared.filterPlatform = Platform.empty
        let checkUser = CheckUserRequest()
        AWSCredentialManager.shared.isUserLoggedIn { (isLoggedIn) in
            if isLoggedIn == true {
                checkUser.sendCheckUserRequest(userId:nil, completionBlock: { (user, error) in
                    if error != nil {
                        AWSCredentialManager.shared.logout(completion: { (isLogout) in
                            self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
                        })
                    } else {
                        Rush.shared.currentUser = user
                        let updateRequest = UpdateFirebaseTokenRequest()
                        updateRequest.sendUpdateFirebaseToken(completion: { (response, isFirNil) in
                            if isFirNil{
                                DispatchQueue.main.async {
                                    self.pushMainTabBar()
                                }
                            } else {
                                if response != nil {
                                    DispatchQueue.main.async {
                                        self.pushMainTabBar()
                                    }
                                }
                            }
                        })
                    }
                })
            } else {
                AWSCredentialManager.shared.logout(completion: { (isLogout) in
                    self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
                })
            }
        }
    }
    
}
