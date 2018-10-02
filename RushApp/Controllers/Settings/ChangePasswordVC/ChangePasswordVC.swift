//
//  ChangePasswordVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import FacebookCore
import SVProgressHUD

class ChangePasswordVC: BaseVC {
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordAgainTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AWSCredentialManager.shared.getUserPool { (pool) in
            if pool.currentUser() == nil {
                self.showError(title: "Uyarı", description: "Facebook ile girişlerde şifre değiştirilemez") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        if AccessToken.current?.authenticationToken != nil {
            self.showError(title: "Uyarı", description: "Facebook ile girişlerde şifre değiştirilemez") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func changePasswordTapped(_ sender: UIButton) {
        if oldPasswordTextField.text?.count == 0 || newPasswordTextField.text?.count == 0 || newPasswordAgainTextField.text?.count == 0 {
            self.showErrorMessage(message: "Lütfen gerekli alanları doldurunuz.")
        } else {
            SVProgressHUD.show()
            if self.newPasswordTextField.text!.elementsEqual(self.newPasswordAgainTextField.text!) {
                AWSCredentialManager.shared.getUserPool { (pool) in
                    pool.currentUser()?.changePassword(self.oldPasswordTextField.text!, proposedPassword: self.newPasswordTextField.text!).continueWith(block: { (task) -> Any? in
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                        }
                        if task.error != nil {
                            self.showErrorMessage(message: "Şifre hatalı ya da uygun değil.")
                        } else {
                            self.showSuccess(message: "Şifreniz başarı ile değiştirilmiştir.")
                        }
                        return nil
                    })
                }
            } else {
                self.showErrorMessage(message: "Yeni şifreler birbirinden farklı.")
            }
        }
    }
    
}
