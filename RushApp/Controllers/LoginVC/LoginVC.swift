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
            
            if task.error == nil {
                
                let checkUserRequest = CheckUserRequest()
                checkUserRequest.sendCheckUserRequest(completionBlock: { (response, error) in
                    SVProgressHUD.dismiss()
                    if error != nil {
                        self.navigationController?.pushVCMainThread(GameSelectionVC.createFromStoryboard())
                    } else {
                        self.navigationController?.pushVCMainThread(FeedVC.createFromStoryboard())
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
                self.navigationController?.pushVCMainThread(FeedVC.createFromStoryboard())
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
