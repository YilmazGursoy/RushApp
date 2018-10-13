//
//  BlockUserVC.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 13.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class BlockUserVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    var blockedUserList:[SimpleUser]? {
        didSet{
            if blockedUserList == nil {
                self.tableView.isHidden = true
            } else {
                if blockedUserList!.count > 0 {
                    self.tableView.isHidden = false
                    DispatchQueue.main.async {
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                    }
                } else {
                    self.tableView.isHidden = true
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "UserCell", bundle: .main), forCellReuseIdentifier: "UserCell")
        getCurrentUser()
    }
    
    private func getCurrentUser(){
        SVProgressHUD.show()
        let request = CheckUserRequest()
        request.sendCheckUserRequest(userId: nil) { (currentUser, error) in
            SVProgressHUD.dismiss()
            if currentUser != nil {
                DispatchQueue.main.async {
                    self.blockedUserList = currentUser?.blackList
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                }
            }
        }
    }

}

extension BlockUserVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedUserList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.arrangeCell(simpleUser: blockedUserList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = blockedUserList![indexPath.row]
        
    }
    
}
