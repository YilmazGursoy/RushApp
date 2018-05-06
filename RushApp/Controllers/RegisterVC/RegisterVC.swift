//
//  RegisterVC.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class RegisterVC: BaseVC {
    //MARK: IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //MARK: IBActions
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        
        let registerManager = RegisterRequest()
        registerManager.register(withUsername: usernameTextField.text!, andPassword: passwordTextField.text!, andEmail: emailTextField.text!, andNickname: nicknameTextField.text!) { (response) in
            
            
            
        }
        
    }
    
}
