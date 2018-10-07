//
//  ForgotPasswordVC.swift
//  RushApp
//
//  Created by Most Wanted on 8.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgotPasswordVC: BaseVC {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailCodeTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordAgainTextField: UITextField!
    
    @IBOutlet weak var sendCodeButtonOutlet: UIButton!
    @IBOutlet weak var emailCodeBackView: UIView!
    @IBOutlet weak var newPasswordBackView: UIView!
    @IBOutlet weak var newPasswordAgainBackView: UIView!
    
    @IBOutlet weak var usernameBackView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupUI(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        emailCodeTextField.attributedPlaceholder = NSAttributedString(string: "E-Postanıza gönderilen kodu giriniz",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        newPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Yeni şifreniz",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        newPasswordAgainTextField.attributedPlaceholder = NSAttributedString(string: "Yeni şifre tekrar",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    @IBAction func sendConfirmCodeTapped(_ sender: Any) {
        if emailCodeBackView.isHidden {
            self.sendResetPasswordCodeRequest()
        } else {
            self.sendResetPasswordRequest()
        }
    }
    
    private func openPasswordViews(){
        self.usernameTextField.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.emailCodeBackView.isHidden = false
            self.emailCodeBackView.alpha = 1.0
            self.newPasswordBackView.isHidden = false
            self.newPasswordBackView.alpha = 1.0
            self.newPasswordAgainBackView.isHidden = false
            self.newPasswordAgainBackView.alpha = 1.0
            self.sendButtonPassive()
        }, completion: nil)
    }
    
    private func sendResetPasswordCodeRequest(){
        AWSCredentialManager.shared.getUserPool { (pool) in
            SVProgressHUD.show()
            pool.getUser(self.usernameTextField.text!).forgotPassword().continueWith(block: { (task) -> Any? in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    if task.error != nil {
                        if task.error!._code == 18 {
                            self.showError(title: "Hata!", description: "Lütfen daha sonra tekrar deneyiniz.", doneButtonTapped: {
                                
                            })
                        } else {
                            self.showError(title: "Hata!", description: "Kullanıcı adınız sistemimizde kayıtlı değildir.", doneButtonTapped: {
                                
                            })
                        }
                        
                    } else {
                        self.openPasswordViews()
                    }
                    
                }
                return nil
            })
        }
    }
    
    private func sendResetPasswordRequest(){
        AWSCredentialManager.shared.getUserPool { (pool) in
            pool.getUser(self.usernameTextField.text!).confirmForgotPassword(self.emailCodeTextField.text!, password: self.newPasswordTextField.text!).continueWith(block: { (task) -> Any? in
                DispatchQueue.main.async {
                    if task.error != nil {
                        
                        self.showErrorMessage(message: "Şifre minimum 1 küçük karakter 1 büyük karakter 1 özel karakter olmak üzere minimum 8 karakterden oluşmalıdır.")
                    } else {
                        self.showSuccess(title: "Heyy!", description: "Şifreniz başarıyla değiştirilmiştir.", doneButtonTapped: {
                            self.pop()
                        })
                    }
                }
                return nil
            })
        }
    }
    
}

//MARK: -
//MARK: -- ForgotPasswordRequest
extension ForgotPasswordVC {
    func sendForgotPasswordRequest(){
        
    }
    
    private func sendButtonPassive(){
        self.sendCodeButtonOutlet.isEnabled = false
        UIButton.animate(withDuration: 0.2) {
            self.sendCodeButtonOutlet.alpha = 0.5
        }
    }
    
    private func sendButtonActive(){
        self.sendCodeButtonOutlet.isEnabled = true
        UIButton.animate(withDuration: 0.2) {
            self.sendCodeButtonOutlet.alpha = 1.0
        }
    }
}


extension ForgotPasswordVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        if newString != nil {
            if newString!.count > 0 {
                if self.emailCodeBackView.isHidden {
                    self.sendButtonActive()
                } else {
                    if textField == self.newPasswordTextField {
                        if self.emailCodeTextField.text!.count > 0 && newString!.count > 0 && self.newPasswordAgainTextField.text!.count > 0 && self.newPasswordAgainTextField.text == newString! {
                            self.sendButtonActive()
                        } else {
                            self.sendButtonPassive()
                        }
                    } else if textField == self.newPasswordAgainTextField {
                        if self.emailCodeTextField.text!.count > 0 && newString!.count > 0 && self.newPasswordTextField.text!.count > 0 && self.newPasswordTextField.text == newString! {
                            self.sendButtonActive()
                        } else {
                            self.sendButtonPassive()
                        }
                    } else {
                        if self.emailCodeTextField.text!.count > 0 && self.newPasswordTextField.text!.count > 0 && self.newPasswordAgainTextField.text!.count > 0 && self.newPasswordAgainTextField.text == self.newPasswordTextField.text! {
                            self.sendButtonActive()
                        } else {
                            self.sendButtonPassive()
                        }
                    }
                    
                }
            } else {
                self.sendButtonPassive()
            }
        }
        return true
    }
    
}
