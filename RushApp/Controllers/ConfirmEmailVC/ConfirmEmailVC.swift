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
                DispatchQueue.main.async {
                    if task.result != nil {
                        RushLogger.successLog(message: "Confirm Success")
                        self.showSuccess(title: "", description: "Doğrulama başarılı", doneButtonTapped: {
                            if self.navigationController != nil {
                                self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
                            } else {
                                self.dismiss()
                            }
                        })
                        print(task.result ?? "-")
                    } else {
                        RushLogger.errorLog(message: "Confirm Email Failed")
                        self.showError(title: "", description: "Doğrulama kodunuz hatalıdır!", doneButtonTapped: {
                            self.confirmCodeLabel.text = "Doğrulama Kodu"
                        })
                        self.confirmCodeLabel.text = "Doğrulama Kodu"
                        print(task.error ?? "-")
                    }
                }
                return nil
            })
        }
    }
    
    @IBAction func resendConfirmationCodeTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            RushLogger.functionLog(message: "Resend Confirmation Request")
            pool.getUser(self.email).resendConfirmationCode().continueWith(block: { (task) -> Any? in
                DispatchQueue.main.async {
                    if task.result != nil {
                        RushLogger.successLog(message: "Resend Success")
                        self.showSuccess(title: "", description: "Yeni doğrulama kodunuz gönderilmiştir.", doneButtonTapped: {
                            
                        })
                    } else {
                        self.showError(title: "", description: "Yeni doğrulama kodu gönderilirken bir hata oluştu.", doneButtonTapped: {
                            
                        })
                    }
                }
                return nil
            })
            
        }
    }
    
    @IBAction func digitTapped(_ sender: UIButton) {
        if confirmCodeLabel.text!.elementsEqual("Doğrulama Kodu") {
            confirmCodeLabel.text = ""
        }
        
        if (confirmCodeLabel.text?.count)! <= 5 {
            confirmCodeLabel.text = confirmCodeLabel.text! + sender.currentTitle!
        }
        
        if confirmCodeLabel.text?.count == 6 {
            confirmTapped(UIButton())
        }
        
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        if confirmCodeLabel.text!.elementsEqual("Doğrulama Kodu") {
            return
        }
        if (confirmCodeLabel.text?.count)! < 1 {
            confirmCodeLabel.text = "Doğrulama Kodu"
        } else {
            confirmCodeLabel.text?.removeLast()
        }
    }
    
}
