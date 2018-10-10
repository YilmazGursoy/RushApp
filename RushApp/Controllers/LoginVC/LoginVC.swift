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
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    private func setupUI(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı...",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Şifre...",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    //MARK: IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.view.endEditing(true)
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
                DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {
                    SVProgressHUD.dismiss()
                    self.loginErrorChecks(error: task.error, userName: self.usernameTextField.text!)
                })
            }
        }
        
    }
    
    @IBAction func facebookLoginTapped(_ sender: UIButton) {
        self.view.endEditing(true)
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
    
    private func loginButtonPassive(){
        self.loginButtonOutlet.isEnabled = false
        UIButton.animate(withDuration: 0.2) {
            self.loginButtonOutlet.alpha = 0.5
        }
    }
    
    private func loginButtonActive(){
        self.loginButtonOutlet.isEnabled = true
        UIButton.animate(withDuration: 0.2) {
            self.loginButtonOutlet.alpha = 1.0
        }
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        self.navigationController?.pushVCMainThread(RegisterVC.createFromStoryboard())
    }
    
    @IBAction func forgotMyPasswordTapped(_ sender: UIButton) {
        //TODO:
    }
    
    
    private func loginErrorChecks(error:Error?, userName:String){
        SVProgressHUD.dismiss()
        if let _error = error {
            switch _error._code {
            case ErrorConstants.awsCognitoConfirmEmailCode:
                let vc = ConfirmEmailVC.createFromStoryboard()
                vc.email = userName
                self.navigationController?.pushVCMainThread(vc)
            case ErrorConstants.awsCognitoSignoutCode:
                self.forceOpenViewController(forceViwController: LoginVC.createFromStoryboard())
            case ErrorConstants.noInternetConnection:
                RushLogger.errorLog(message: "Not defining Error with code \(_error._code)")
                self.showErrorMessage(message: "İnternet bağlantı hatası.")
            default:
                RushLogger.errorLog(message: "Not defining Error with code \(_error._code)")
                self.showErrorMessage(message: "Kullanıcı adı / Şifre yanlış :(")
            }
        }
    }
    
}

extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        if newString != nil {
            if newString!.count == 0 {
                self.loginButtonPassive()
            } else {
                if textField == usernameTextField {
                    if passwordTextField.text!.count > 0 {
                        self.loginButtonActive()
                    } else {
                        self.loginButtonPassive()
                    }
                } else {
                    if usernameTextField.text!.count > 0 {
                        self.loginButtonActive()
                    } else {
                        self.loginButtonPassive()
                    }
                }
                
            }
        }
        
        return true
    }
    
}
