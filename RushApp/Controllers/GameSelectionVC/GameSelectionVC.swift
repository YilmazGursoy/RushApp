//
//  GameSelectionVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class GameSelectionVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    private var gameList:[Game]! {
        didSet{
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.sendGameList()
        }
    }
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "GameSelectionCell", bundle: .main), forCellReuseIdentifier: "GameSelectionCell")
    }
    
    private func sendGameList(){
        let request = GameListRequest()
        request.sendGameListRequest { (games, error) in
            if games != nil {
                self.gameList = games!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        SVProgressHUD.show()
        var ids:[Game] = []
        self.gameList.forEach { (game) in
            if game.isActive! {
                ids.append(game)
            }
        }
        
        AWSCredentialManager.shared.getUserPool { (pool) in
            let createUserRequest = UserCreateRequest()
            guard let username = pool.currentUser()?.username  else {
                return
            }
            
            createUserRequest.sendUserCreateRequest(games: ids, username: username, completionBlock: { (result, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    self.showError(title: "Failed", description: "There is an error to creating profile.", doneButtonTapped: {
                        
                    })
                } else {
                    let checkUserRequest = CheckUserRequest()
                    checkUserRequest.sendCheckUserRequest(completionBlock: { (response, error) in
                        if error != nil {
                            
                        } else {
                            Rush.shared.currentUser = response
                            DispatchQueue.main.async {
                                let window = UIApplication.shared.keyWindow
                                let tabbarController = TabBarController()
                                window?.rootViewController = tabbarController
                                window?.makeKeyAndVisible()
                            }
                        }
                    })
                }
            })
        }
    }
    
}


extension GameSelectionVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameSelectionCell", for: indexPath) as! GameSelectionCell
        cell.arrangeCell(imageName: self.gameList[indexPath.row].thumbImage! , title: self.gameList[indexPath.row].name, index: indexPath.row, isActive: self.gameList[indexPath.row].isActive!)
        cell.changeActiveHandler = {isActive, index in
            self.gameList[index].isActive = isActive
        }
        return cell
    }
    
}
