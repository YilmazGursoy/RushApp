//
//  FeedVC.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedVC: BaseVC {

    @IBOutlet weak var credentialIdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    //MARK: IBActions
    
    
    @IBAction func requestTapped(_ sender: UIButton) {
        DummyRequest().sendDummyRequest(completionBlock: { (result, error) in
            
            
            
        })
    }
    
    @IBAction func isUserLoggedInTapped(_ sender: UIButton) {
        
        AWSCredentialManager.shared.isUserLoggedIn { (isLoggedIn) in
            
            if isLoggedIn == true {
                RushLogger.successLog(message: "Already Logged In")
            } else {
                RushLogger.errorLog(message: "Not Logged In")
            }
            
        }
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.logout()
        self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func displayCredentialTapped(_ sender: UIButton) {
        AWSCredentialManager.shared.currentCredential.getIdentityId().continueWith { (task) -> Any? in
            if task.result! != nil {
                DispatchQueue.main.async {
                    self.credentialIdLabel.text = task.result! as String
                }
            } else {
                DispatchQueue.main.async {
                    self.credentialIdLabel.text = "nil"
                }
            }
            return nil
        }
    }
    
}
