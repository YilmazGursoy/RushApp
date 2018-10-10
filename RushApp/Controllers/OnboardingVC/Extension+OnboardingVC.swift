//
//  Extension+OnboardingVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

extension OnboardingVC {
    
    func registerOnboardingVC(){
        CacheManager.shared.cache(object: "PASS", withKey: CacheConstants.OnboardingCacheKey)
        checkUserAndPushViews()
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
