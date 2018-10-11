//
//  CreateLobbyVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation

class CreateLobbyVC: BaseVC {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lobbyNameTextField: UITextField!
    @IBOutlet weak var lobbyDetailTextView: UITextView!
    @IBOutlet weak var choosePlatformTextField: UITextField!
    @IBOutlet weak var chooseGameTextField: UITextField!
    @IBOutlet weak var neededPlayerTextField: UITextField!
    @IBOutlet weak var lobbyPreviwBackView: GradientView!
    @IBOutlet weak var lobbyPreviewButtonOutlet: UIButton!
    
    var platformType:Platform?
    var selectingGame:Game?
    var currentLocation:CLLocation?
    var currentLocationName:String?
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.checkLocation()
        }
    }
    @IBAction func selectPlatformTapped(_ sender: UIButton) {
        let platformVC = PlatformSelectionVC.createFromStoryboard()
        platformVC.selectedPlatform = { platform in
            self.platformType = platform
            self.choosePlatformTextField.text = platform.getPlatformName()
            self.checkPreviewButton()
        }
        self.pushViewController(pushViewController: platformVC)
    }
    
    @IBAction func selectGameTapped(_ sender: UIButton) {
        let gameVC = LobbyGameSelectionVC.createFromStoryboard()
        gameVC.selectedGame = { game in
            self.selectingGame = game
            self.chooseGameTextField.text = game.name
            self.checkPreviewButton()
        }
        self.pushViewController(pushViewController: gameVC)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func checkPreviewButton(){
        if platformType != .empty {
            if selectingGame != nil {
                if currentLocation != nil {
                    if currentLocationName != nil {
                    /**/if lobbyNameTextField.text!.count > 0 {
                    /*****/if lobbyDetailTextView.text!.count > 0 {
                    /*********/if neededPlayerTextField.text!.count >= 1 {
                    /*************/self.lobbyPreviewEnable()
                    /*************/return
                    /*********/}
                    /******/}
                    /***/}
                    }
                }
            }
        }
        self.lobbyPreviewDisable()
    }
    
    func lobbyPreviewEnable(){
        self.lobbyPreviewButtonOutlet.isUserInteractionEnabled = true
        self.lobbyPreviwBackView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
        self.lobbyPreviwBackView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
    }
    
    func lobbyPreviewDisable(){
        self.lobbyPreviewButtonOutlet.isUserInteractionEnabled = false
        self.lobbyPreviwBackView.topColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 0.5)
        self.lobbyPreviwBackView.bottomColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 0.5)
    }
    
    @IBAction func postPublishTapped(_ sender: UIButton) {
        let createLobbyRequest = LobbyCreateRequest()
        SVProgressHUD.show()
        createLobbyRequest.sendLobbyCreateRequest(lobbyName: self.lobbyNameTextField.text!, address: self.currentLocationName!, numberOfNeededUser: Int((self.neededPlayerTextField.text! as NSString).intValue), description: self.lobbyDetailTextView.text!, latitude: self.currentLocation!.coordinate.latitude, longitude: self.currentLocation!.coordinate.longitude, sender: Rush.shared.currentUser, game: self.selectingGame, platform: self.platformType!, completionSuccess: { (lobby) in
            SVProgressHUD.dismiss()
            let vc = LobbyDetailVC.createFromStoryboard()
            vc.isPreview = true
            vc.currentLobby = lobby
            self.navigationController?.pushVCMainThread(vc)
        }) {
            SVProgressHUD.dismiss()
            self.showErrorMessage(message: "There is an error to creating Lobby")
        }
    }
    @IBAction func numberOfNeededTapped(_ sender: UITextField) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            sender.resignFirstResponder()
            self.lobbyDetailTextView.resignFirstResponder()
            
            let actionSheet = UIAlertController(title: "Lütfen gerekli oyuncu sayısını seçiniz.", message: nil, preferredStyle: .actionSheet)
            
            for value in 1..<11 {
                actionSheet.addAction(UIAlertAction.init(title: "\(value)", style: .default, handler: { (action) in
                    self.neededPlayerTextField.text = "\(value)"
                }))
            }
            
            actionSheet.addAction(UIAlertAction.init(title: "Kapat", style: .cancel, handler: { (action) in
                
            }))
            
            self.present(actionSheet, animated: true, completion: nil)
            
        }
    }
}

extension CreateLobbyVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkPreviewButton()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

