//
//  GameSelectionVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
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
        request.sendGameListRequest { (gameList, error) in
            if let newGameList = gameList {
                var games = newGameList
                games = games.sorted{$0.name < $1.name}
                self.gameList = games
            } else {
                self.pop()
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
            
            var username:String? = nil
            var profileImageUrl:URL? = nil
            SVProgressHUD.show()
            if let fullName = UserProfile.current?.fullName {
                username = fullName
                
                profileImageUrl = UserProfile.current?.imageURLWith(UserProfile.PictureAspectRatio.square, size: CGSize(width: 600, height: 600))
                let session = URLSession.init(configuration: URLSessionConfiguration.default)
                let dataTask = session.dataTask(with: profileImageUrl!, completionHandler: { (data, response, error) in
                    if let imageData = data {
                        let image = UIImage.init(data: imageData)
                        ImageUploadManager.uploadImageOnlyS3(newImage: image!, completionSuccess: { (url) in
                            self.createUserRequest(username: username!, gameIds: ids, imageUrl: url)
                        }, completionFailed: {
                            self.createUserRequest(username: username!, gameIds: ids, imageUrl: nil)
                        })
                    } else {
                        self.createUserRequest(username: username!, gameIds: ids, imageUrl: nil)
                    }
                })
                
                dataTask.resume()
            } else {
                if let poolUserName = pool.currentUser()?.username {
                    username = poolUserName
                } else {
                    return
                }
                self.createUserRequest(username: username!, gameIds: ids, imageUrl: nil)
            }
        }
    }
    
}

//MARK: Private methods
extension GameSelectionVC {
    
    private func createUserRequest(username:String, gameIds:[Game], imageUrl:String?) {
        let createUserRequest = UserCreateRequest()
        createUserRequest.sendUserCreateRequest(games: gameIds, username: username, userProfileImageUrl: imageUrl, completionBlock: { (result, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    self.showError(title: "Hata!", description: "Profiliniz oluşturulurken bir hata oluştu.", doneButtonTapped: {
                        
                    })
                } else {
                    let checkUserRequest = CheckUserRequest()
                    checkUserRequest.sendCheckUserRequest(userId:nil, completionBlock: { (response, error) in
                        if error != nil {
            
                        } else {
                            Rush.shared.currentUser = response
                            DispatchQueue.main.async {
                                self.pushMainTabBar()
                            }
                        }
                    })
                }
            })
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
