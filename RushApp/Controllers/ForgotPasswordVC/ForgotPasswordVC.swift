//
//  ForgotPasswordVC.swift
//  RushApp
//
//  Created by Most Wanted on 8.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseVC {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var sendCodeButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupUI(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı:",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    @IBAction func sendConfirmCodeTapped(_ sender: Any) {
        
        
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
                self.sendButtonActive()
            } else {
                self.sendButtonPassive()
            }
        }
        return true
    }
    
}
