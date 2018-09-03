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
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var credentialIdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "FeedCell", bundle: .main), forCellReuseIdentifier: "FeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 333
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
    
}

extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        return cell
    }
    
}
