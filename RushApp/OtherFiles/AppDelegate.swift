//
//  AppDelegate.swift
//  RushApp
//
//  Created by Most Wanted on 29.04.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadAllSharedInstances()
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


extension AppDelegate {
    private func loadAllSharedInstances(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Tamam"
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1))
    }
}
