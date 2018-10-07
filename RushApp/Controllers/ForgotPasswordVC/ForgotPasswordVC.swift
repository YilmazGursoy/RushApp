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
}
