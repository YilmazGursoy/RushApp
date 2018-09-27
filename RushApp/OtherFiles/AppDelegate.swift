//
//  AppDelegate.swift
//  RushApp
//
//  Created by Most Wanted on 29.04.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Fabric
import Firebase
import AWSAppSync
import AWSCognito
import Crashlytics
import SVProgressHUD
import FBSDKCoreKit
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appSyncClient: AWSAppSyncClient?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self, AWSCognito.self])
        
        FirebaseApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
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
        SVProgressHUD.setDefaultMaskType(.black)
        self.awsConfirm()
        do {
            let databaseURL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent(database_name)
            let appSyncConfig = try AWSAppSyncClientConfiguration(url: AppSyncEndpointURL,
                                                                  serviceRegion: AppSyncRegion,
                                                                  apiKeyAuthProvider: APIKeyAuthProvider(),
                                                                  databaseURL:databaseURL)
            appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
            appSyncClient?.apolloClient?.cacheKeyForObject = { $0["id"] }
        } catch {
            print("Error initializing AppSync client. \(error)")
        }
    }
}

//MARK: Notifications Methods
extension AppDelegate:UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        Rush.shared.firToken = fcmToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let   tokenString = deviceToken.reduce("", {$0 + String(format: "%02X",    $1)})
        // kDeviceToken=tokenString
        print("deviceToken: \(tokenString)")
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        
        // Print full message.
        handlePushNotification(userInfo: userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        
        // Print full message.
        handlePushNotification(userInfo: userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    @objc fileprivate func handlePushNotification(userInfo: [AnyHashable: Any]) {
        
    }
    
    
    
}

//MARK:-
//MARK:-- AWSConfigurations
extension AppDelegate {
    
    @objc func identityDidChange(notification: NSNotification!) {
        if let userInfo = notification.userInfo as? [String: AnyObject] {
            print("🍎   identity changed from: \(String(describing: userInfo[AWSCognitoNotificationPreviousId])) to: \(String(describing: userInfo[AWSCognitoNotificationNewId]))  h 🍎")
        }
    }
    
    
    func awsConfirm(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.identityDidChange(notification:)),
                                               name: NSNotification.Name.AWSCognitoIdentityIdChanged,
                                               object: nil)
        AWSCredentialManager.shared.loadUserCredentials()
    }
}
