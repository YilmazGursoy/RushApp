//
//  AppDelegate.swift
//  RushApp
//
//  Created by Most Wanted on 29.04.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AWSCredentialManager.shared.getUserPool { (pool) in
            if pool.currentUser()?.isSignedIn == true {
                print("User already logged in with email/password")
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
    }

}

