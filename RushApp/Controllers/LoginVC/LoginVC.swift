//
//  LoginVC.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: BaseVC {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    private func setupUI(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username or Email Address",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    //MARK: IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let loginManager = LoginRequest()
        SVProgressHUD.show()
        loginManager.login(withUsername: usernameTextField.text!, andPassword: passwordTextField.text!) { (task) in
            SVProgressHUD.dismiss()
            if task.error == nil {
                let checkUserRequest = CheckUserRequest()
                checkUserRequest.sendCheckUserRequest(userId:nil, completionBlock: { (response, error) in
                    if error != nil {
                        self.navigationController?.pushVCMainThread(GameSelectionVC.createFromStoryboard())
                    } else {
                        Rush.shared.currentUser = response
                        DispatchQueue.main.async {
                            self.pushMainTabBar()
                        }
                    }
                })
            } else {
                
                self.showError(title: "", description: "Username or Password incorrect.", doneButtonTapped: {
                    
                })
            }
            
        }
        
    }
    
    @IBAction func facebookLoginTapped(_ sender: UIButton) {
        let loginManager = LoginRequest()
        loginManager.facebookLogin(withTarget: self) { (isSuccess) in
            if isSuccess == true {
                let checkUserRequest = CheckUserRequest()
                checkUserRequest.sendCheckUserRequest(userId:nil, completionBlock: { (response, error) in
                    if error != nil {
                        self.navigationController?.pushVCMainThread(GameSelectionVC.createFromStoryboard())
                    } else {
                        Rush.shared.currentUser = response
                        DispatchQueue.main.async {
                            self.pushMainTabBar()
                        }
                    }
                })
            }
            
        }
        
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        self.navigationController?.pushVCMainThread(RegisterVC.createFromStoryboard())
    }
    
    @IBAction func forgotMyPasswordTapped(_ sender: UIButton) {
        //TODO:
    }
    
    
}
