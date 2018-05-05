//
//  LoginVC.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    //MARK: IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        var loginManager = AWSLoginManager.init()
        
        loginManager.login(withUsername: usernameTextField.text!, andPassword: passwordTextField.text!) { (task) in
            
            
            
        }
        
    }
    
}
