//
//  BaseVC.swift
//  RushApp
//
//  Created by Most Wanted on 1.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AVFoundation

import SDWebImage
import CoreLocation
import SVProgressHUD

let openLobbyFromNotificationKey = "openLobbyFromNotificationKey"
let openLobbyFromSplashNotificationKey = "openLobbyFromNotificationKey"
let openReportScreenNotificationKey = "openReportScreenNotificationKey"

class BaseVC: UIViewController {
    var player: AVAudioPlayer?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AWSErrorManager.shared.delegate = self
        AWSPopupManager.shared.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.openLobbyDetailVC(notification:)), name: NSNotification.Name.init(openLobbyFromNotificationKey), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openReportScreen(notification:)), name: NSNotification.Name.init(openReportScreenNotificationKey), object: nil)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.tabBarController?.delegate = self
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
        Rush.shared.isTabBarPush = true
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
    
    
    func openLobbyDetail(lobbyId:String, userId:String) {
        let request = GetLobbyRequest()
        request.sendRequest(lobbyId: lobbyId, userId: userId, successCompletion: { (lobby) in
            DispatchQueue.main.async {
                let lobbyVC = LobbyDetailVCTheirs.createFromStoryboard()
                lobbyVC.currentLobby = lobby
                lobbyVC.isShowLobbyAlert = true
                if let currentNavCon = self.tabBarController?.selectedViewController as? UINavigationController {
                    guard let topViewController = currentNavCon.topViewController as? UIViewController else {
                        return
                    }
                    topViewController.navigationController?.pushVCMainThread(lobbyVC)
                } else {
                    self.navigationController?.pushVCMainThread(lobbyVC)
                }
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

extension  BaseVC : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseVC {
    func playSound() {
        guard let url = Bundle.main.url(forResource: "refresh", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            player.volume = 0.3
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
