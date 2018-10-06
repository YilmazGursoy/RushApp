//
//  BaseVC.swift
//  RushApp
//
//  Created by Most Wanted on 1.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation
import SVProgressHUD

class BaseVC: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AWSErrorManager.shared.delegate = self
        AWSPopupManager.shared.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.shared().clearMemory()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func pop(){
        self.hidesBottomBarWhenPushed = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismiss(){
        if self.navigationController != nil {
            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func pushMainTabBar(){
        let window = UIApplication.shared.keyWindow
        let tabbarController = TabBarController()
        tabbarController.tabBar.backgroundImage = UIImage()
        tabbarController.tabBar.isTranslucent = true
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
    }
    @IBAction func closeKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}

//MARK: Core Location
extension BaseVC {
    func checkLocalization(completion:@escaping (CLAuthorizationStatus)->Void) {
        switch(CLLocationManager.authorizationStatus())
        {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(.authorizedWhenInUse)
        case .notDetermined:
            completion(.notDetermined)
            
        case .restricted:
            completion(.restricted)
        default:
            completion(.denied)
        }
    }
}
