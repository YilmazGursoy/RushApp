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

let openLobbyFromNotificationKey = "openLobbyFromNotificationKey"

class BaseVC: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AWSErrorManager.shared.delegate = self
        AWSPopupManager.shared.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.openLobbyDetailVC(notification:)), name: NSNotification.Name.init(openLobbyFromNotificationKey), object: nil)
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
    
    @objc private func openLobbyDetailVC(notification:Notification) {
        if let object = notification.object as? [String:Any] {
            if let isLobbyReview = object["isLobbyReview"] as? String {
                if let aps = object["aps"] as? [String:Any] {
                    if let alertT = aps["alert"] as? [String:Any] {
                        if isLobbyReview == "true" {
                            DispatchQueue.main.async {
                                let alert = RushAlertController.createFromStoryboard()
                                alert.createAlert(title: alertT["title"] as! String, description: alertT["body"] as! String, positiveTitle: "Tamam", negativeTitle: "Kapat", positiveButtonTapped: {
                                    self.openLobbyDetail(lobbyId: object["lobbyId"] as! String, userId: object["lobbyUserId"] as! String)
                                }, negativeButtonTapped: {
                                    self.showErrorMessage(message: "Bir hata oluştu.")
                                })
                                if self.tabBarController != nil {
                                    self.tabBarController?.present(alert, animated: false, completion: nil)
                                } else {
                                    self.navigationController?.present(alert, animated: false, completion: nil)
                                }
                            }
                        } else {
                           
                        }
                    }
                }
            }
        }
    }
    
    private func openLobbyDetail(lobbyId:String, userId:String) {
        let request = GetLobbyRequest()
        request.sendRequest(lobbyId: lobbyId, userId: userId, successCompletion: { (lobby) in
            DispatchQueue.main.async {
                let lobbyVC = LobbyDetailVCTheirs.createFromStoryboard()
                lobbyVC.currentLobby = lobby
                lobbyVC.isShowLobbyAlert = true
                self.navigationController?.pushVCMainThread(lobbyVC)
            }
        }) {
            DispatchQueue.main.async {
                self.showErrorMessage(message: "Bir hata oluştu!")
            }
        }
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
