//
//  CreateLobbyVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import CoreLocation

class CreateLobbyVC: BaseVC {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lobbyNameTextField: UITextField!
    @IBOutlet weak var lobbyDetailTextField: UITextField!
    @IBOutlet weak var choosePlatformTextField: UITextField!
    @IBOutlet weak var chooseGameTextField: UITextField!
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
                        if lobbyNameTextField.text!.count > 5 {
                            if lobbyDetailTextField.text!.count > 5 {
                                self.lobbyPreviewEnable()
                                return
                            }
                        }
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
        self.lobbyPreviewButtonOutlet.isUserInteractionEnabled = true
        self.lobbyPreviwBackView.topColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 0.5)
        self.lobbyPreviwBackView.bottomColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 0.5)
    }
}

extension CreateLobbyVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkPreviewButton()
    }
}

