//
//  AccountSettingsVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class AccountSettingsVC: BaseVC {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.usernameLabel.text = Rush.shared.currentUser.username
        self.emailLabel.text = Rush.shared.currentUser.email ?? "-"
        self.phoneNumberLabel.text = Rush.shared.currentUser.phoneNumber ?? "-"
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        let rushAlert = RushAlertController.createFromStoryboard()
        rushAlert.createAlert(title: "Selamlar \(Rush.shared.currentUser.username)", description: "Çıkış yapmak istediğine emin misin ?", positiveTitle: "Çıkış Yap", negativeTitle: "Vazgeç", positiveButtonTapped: {
            
            AWSCredentialManager.shared.logout { (isCompleted) in
                self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
            }
            
        }) {
            
        }
        
        self.tabBarController?.present(rushAlert, animated: false, completion: nil)
    }
    
}
