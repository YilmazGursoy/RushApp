//
//  RegisterVC.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Firebase

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
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Kullanıcı adı",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-Posta adresiniz",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Şifre", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(0.5)])
        
        passwordAgainTextField.attributedPlaceholder = NSAttributedString(string: "Şifre tekrar", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(0.5)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //MARK: IBActions
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "Register",
            AnalyticsParameterItemName: "Register Tapped",
            AnalyticsParameterContentType: "cont"
            ])
        
        
        if isValidEmail(testStr: emailTextField.text!) {
            if usernameTextField.text!.count > 0 {
                if passwordTextField.text!.count > 0 && passwordAgainTextField.text!.elementsEqual(passwordTextField.text!) {
                    let vc = TermsVC.createFromStoryboard()
                    vc.readAndAcceptTapped = {
                        let registerManager = RegisterRequest()
                        
                        registerManager.register(withUsername: self.usernameTextField.text!, andPassword: self.passwordTextField.text!, andEmail: self.emailTextField.text!) { (response) in
                            if response.error != nil {
                                DispatchQueue.main.async {
                                    if (response.error! as NSError).code == 37 {
                                        self.showError(title: "", description: "Kullanıcı zaten mevcut lütfen farklı bir kullanıcı adı / mail giriniz", doneButtonTapped: {
                                            
                                        })
                                    } else if (response.error! as NSError).code == 14 {
                                        self.showError(title: "", description: "Şifre minimum 1 küçük karakter 1 büyük karakter 1 özel karakter olmak üzere minimum 8 karakterden oluşmalıdır.", doneButtonTapped: {
                                            
                                        })
                                    } else if (response.error! as NSError).code == 13 {
                                        self.showErrorMessage(message: "Lütfen geçerli bir kullanıcı adı giriniz.")
                                    } else {
                                        self.showError(title: "", description: response.error!.localizedDescription, doneButtonTapped: {
                                            
                                        })
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    let confirmVC = ConfirmEmailVC.createFromStoryboard()
                                    confirmVC.email = self.usernameTextField.text
                                    self.navigationController?.pushVCMainThread(confirmVC)
                                }
                            }
                        }
                    }
                    self.navigationController?.presentVCMainThread(vc)
                } else {
                    self.showError(title: "", description: "Lütfen şifreleri aynı giriniz.") {
                        
                    }
                }
                
            } else {
                self.showError(title: "", description: "Lütfen tüm alanları doldurunuz.") {
                    
                }
            }
        } else {
            self.showError(title: "", description: "Lütfen geçerli bir E-Posta adresi giriniz") {
                
            }
        }

        
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
