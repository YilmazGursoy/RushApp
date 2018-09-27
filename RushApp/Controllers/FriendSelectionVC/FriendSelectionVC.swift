//
//  FriendSelectionVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

//TODO:Make this code below to dynamic

class FriendSelectionVC: BaseVC {
    @IBOutlet private weak var tableView: UITableView!
    private var selectedIndexes:[Bool] = []
    
    private var allFriends:[SimpleUser]! {
        didSet{
            self.selectedIndexes = Array.init(repeating: false, count: self.allFriends.count)
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        sendFriendListRequest()
    }

    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "FriendSelectionCell", bundle: .main), forCellReuseIdentifier: "FriendSelectionCell")
        
    }
    
    private func sendFriendListRequest(){
        self.allFriends = Rush.shared.currentUser.followers
        if self.allFriends.count == 0 {
            self.tableView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func doneTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        
        
    }
    
}


extension FriendSelectionVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendSelectionCell") as! FriendSelectionCell
        cell.arrangeCell(index: indexPath.row, simpleUser:self.allFriends[indexPath.row], isSelected: self.selectedIndexes[indexPath.row]) { (index, isSelected) in
            self.selectedIndexes[index] = isSelected
        }
        return cell
    }
    
}
