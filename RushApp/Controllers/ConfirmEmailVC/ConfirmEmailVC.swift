//
//  ConfirmEmailVC.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider

class ConfirmEmailVC: BaseVC {
    //MARK: IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            RushLogger.requestLog(message: "Confirm SignUp Request")
            pool.getUser(self.usernameTextField.text!).confirmSignUp(self.confirmationTextField.text!).continueWith(block: { (task) -> Any? in
                
                if task.result != nil {
                    RushLogger.successLog(message: "Confirm Success")
                    print(task.result)
                    
                } else {
                    
                    RushLogger.errorLog(message: "Confirm Email Failed")
                    print(task.error)
                }
                
                
                return nil
            })
        }
    }
    
    @IBAction func resendConfirmationCodeTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            RushLogger.functionLog(message: "Resend Confirmation Request")
            pool.getUser(self.usernameTextField.text!).resendConfirmationCode().continueWith(block: { (task) -> Any? in
                if task.result != nil {
                    RushLogger.successLog(message: "Resend Success")
                    self.showInfoAlert(withTitle: "Uyarı", andMessage: "Doğrulama kodunuz mailinize gönderilmiştir.")
                } else {
                    RushLogger.errorLog(message: "Resend Failed")
                    self.showInfoAlert(withTitle: "Hata", andMessage: "Doğrulama kodu gönderilirken bir sorun oluştu.")
                }
                return nil
            })
            
        }
    }
    
}
