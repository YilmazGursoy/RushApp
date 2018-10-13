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
    
    var blockedUserList:[BlockUser]? {
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
                Rush.shared.currentUser = currentUser
                DispatchQueue.main.async {
                    if currentUser?.blackList != nil {
                        var filteredList = currentUser?.blackList!.filter{$0.blockerId == Rush.shared.currentUser.userId}
                        self.blockedUserList = filteredList
                    } else {
                        DispatchQueue.main.async {
                            self.tableView.isHidden = true
                        }
                    }
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
        cell.arrangeCell(simpleUser: blockedUserList![indexPath.row].user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = blockedUserList![indexPath.row]
        
        let alert = RushAlertController.createFromStoryboard()
        alert.createAlert(title: "Uyarı", description: "Kullanıcının bloğunu kaldırmak istediğinize emin misiniz?", positiveTitle: "Bloğu Kaldır", negativeTitle: "İptal", positiveButtonTapped: {
            let request = UnblockUserRequest()
            request.sendUnblockUserRequest(userId: user.user.id, username: user.user.username, successCompletion: { (currentUser) in
                DispatchQueue.main.async {
                    if currentUser.blackList != nil {
                        let filteredList = currentUser.blackList!.filter{$0.blockerId == Rush.shared.currentUser.userId}
                        self.blockedUserList = filteredList
                        self.tableView.reloadData()
                    } else {
                        DispatchQueue.main.async {
                            self.tableView.isHidden = true
                        }
                    }
                }
            }, errorCompletion: {
                self.showError(title: "Hata!", description: "Blok kaldırılırken bir sorun oluştu", doneButtonTapped: {
                    
                })
            })
            
        }) {
            
        }
        
        if tabBarController != nil {
            tabBarController?.present(alert, animated: false, completion: nil)
        } else {
            navigationController?.present(alert, animated: false, completion: nil)
        }
        
    }
    
}
