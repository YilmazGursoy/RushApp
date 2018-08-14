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
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Your Email Address",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(0.5)])
        
        passwordAgainTextField.attributedPlaceholder = NSAttributedString(string: "Repeat Password", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(0.5)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //MARK: IBActions
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        if isValidEmail(testStr: emailTextField.text!) {
            if usernameTextField.text!.count > 0 {
                if passwordTextField.text!.count > 0 && passwordAgainTextField.text!.elementsEqual(passwordTextField.text!) {
                    let registerManager = RegisterRequest()
                    
                    registerManager.register(withUsername: usernameTextField.text!, andPassword: passwordTextField.text!, andEmail: emailTextField.text!) { (response) in
                        if response.error != nil {
                            DispatchQueue.main.async {
                                if (response.error! as NSError).code == 37 {
                                    self.showError(title: "", description: "User already exist please enter different username/mail", doneButtonTapped: {
                                        
                                    })
                                } else if (response.error! as NSError).code == 14 {
                                    self.showError(title: "", description: "Password must have 1 uppercase, 1 lowercase, 1 special characters and minimum 8 digits.", doneButtonTapped: {
                                        
                                    })
                                } else {
                                    self.showError(title: "", description: response.error!.localizedDescription, doneButtonTapped: {
                                        
                                    })
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                let confirmVC = ConfirmEmailVC.createFromStoryboard()
                                confirmVC.email = self.emailTextField.text
                                self.navigationController?.pushVCMainThread(confirmVC)
                            }
                        }
                    }
                } else {
                    self.showError(title: "", description: "Please enter the same password.") {
                        
                    }
                }
                
            } else {
                self.showError(title: "", description: "Please fill all fields.") {
                    
                }
            }
        } else {
            self.showError(title: "", description: "Please enter valid Email address") {
                
            }
        }
        
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
