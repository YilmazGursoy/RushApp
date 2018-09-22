//
//  UserListVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 22.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

enum UserListType {
    case followes
    case following
}

class UserListVC: BaseVC {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var list:[SimpleUser]!
    var listType:UserListType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "UserCell", bundle: .main), forCellReuseIdentifier: "UserCell")
        switch listType! {
        case .followes:
            self.titleLabel.text = "Takipçiler"
        case .following:
            self.titleLabel.text = "Takip Edilenler"
        }
    }
}

extension UserListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.arrangeCell(simpleUser: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = list[indexPath.row]
        let profileVC = ProfileVC.createFromStoryboard()
        profileVC.currentUserId = user.id
        profileVC.isMyProfile = false
        self.navigationController?.pushVCMainThread(profileVC)
    }
    
}


