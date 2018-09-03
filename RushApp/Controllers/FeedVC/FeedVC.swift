//
//  FeedVC.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedVC: BaseVC {
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var credentialIdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeeds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    //MARK: IBActions
    
    
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
    
    private func setupFeeds(){
        for _ in 0...10 {
            let feedView = FeedView.fromNib() as FeedView
            feedView.height(constant: 318)
            self.stackView.addArrangedSubview(feedView)
        }
    }
    
}
