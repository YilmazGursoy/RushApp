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
    
    @IBOutlet weak var confirmCodeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var email:String!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if email != nil {
            self.emailLabel.text = email
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            RushLogger.requestLog(message: "Confirm SignUp Request")
            pool.getUser(self.email).confirmSignUp(self.confirmCodeLabel!.text!).continueWith(block: { (task) -> Any? in
                if task.result != nil {
                    RushLogger.successLog(message: "Confirm Success")
                    self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
                    print(task.result ?? "-")
                    
                } else {
                    RushLogger.errorLog(message: "Confirm Email Failed")
                    print(task.error ?? "-")
                }
                return nil
            })
        }
    }
    
    @IBAction func resendConfirmationCodeTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            RushLogger.functionLog(message: "Resend Confirmation Request")
            pool.getUser(self.email).resendConfirmationCode().continueWith(block: { (task) -> Any? in
                if task.result != nil {
                    RushLogger.successLog(message: "Resend Success")
                    self.showSuccess(title: "", description: "Your new confirmation code has been sending.", doneButtonTapped: {
                        
                    })
                } else {
                    self.showError(title: "", description: "There is an error sending new confirmation code.", doneButtonTapped: {
                        
                    })
                }
                return nil
            })
            
        }
    }
    
    @IBAction func digitTapped(_ sender: UIButton) {
        if confirmCodeLabel.text!.elementsEqual("Confirmation code") {
            confirmCodeLabel.text = ""
        }
        
        if (confirmCodeLabel.text?.count)! <= 5 {
            confirmCodeLabel.text = confirmCodeLabel.text! + sender.currentTitle!
        } else {
            confirmTapped(UIButton())
        }
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        if confirmCodeLabel.text!.elementsEqual("Confirmation code") {
            return
        }
        if (confirmCodeLabel.text?.count)! < 1 {
            confirmCodeLabel.text = "Confirmation code"
        } else {
            confirmCodeLabel.text?.removeLast()
        }
    }
    
}
