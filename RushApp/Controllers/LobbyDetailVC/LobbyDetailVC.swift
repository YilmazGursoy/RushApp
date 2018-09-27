//
//  LobbyDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSAppSync
import SVProgressHUD

class LobbyDetailVC: BaseVC {
    
    @IBOutlet weak var lobbyPreviewTitle: UILabel!
    @IBOutlet weak var isPreviewBackgroundView: UIView!
    @IBOutlet weak var lobbyTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentLobby:Lobby!
    var isPreview:Bool = false
    
    var comments:[Comment] = []
    var watcher:AWSAppSyncSubscriptionWatcher<AddCommentSubscriptionSubscription>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.configurateLobbyDelegatesAndRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        watcher?.cancel()
    }
    
    private func setupUI(){
        registerCells()
        self.lobbyTitle.text = currentLobby.name + " Lobby"
        lobbyPreviewTitle.text = currentLobby.name + " Lobby"
        self.isPreviewBackgroundView.isHidden = !isPreview
    }
    
    func registerCells(){
        self.tableView.register(UINib.init(nibName: "LobbyDetailTitleCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailTitleCell")
        self.tableView.register(UINib.init(nibName: "LobbyDetailOneButtonCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailOneButtonCell")
        self.tableView.register(UINib.init(nibName: "MessageCell", bundle: .main), forCellReuseIdentifier: "MessageCell")
        self.tableView.register(UINib.init(nibName: "FeedCommentCell", bundle: .main), forCellReuseIdentifier: "FeedCommentCell")
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension LobbyDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isPreview {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else  {
            return self.comments.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyDetailTitleCell") as! LobbyDetailTitleCell
            cell.arrangeCell(lobby: currentLobby) { (userId) in
                ProfileVC.push(in: self.navigationController!, userId: userId)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyDetailOneButtonCell") as! LobbyDetailOneButtonCell
            if currentLobby.subscribers.count >= currentLobby.numberOfNeededUser {
                cell.arrangeCell(type: .startTheGame) {
                    //MARK: Start Game Tapped
                }
            } else {
                cell.arrangeCell(type: .addPlayer) {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                        let friendSelectionVC = FriendSelectionVC.createFromStoryboard()
                        self.present(friendSelectionVC, animated: false, completion: nil)
                    })
                }
            }
            return cell
        } else {
            
            if self.currentLobby.lobbyHasChat {
                if indexPath.row < self.comments.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentCell") as! FeedCommentCell
                    cell.arrange(comment: self.comments[indexPath.row])
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
                    cell.arrange { (message) in
                        let commentRequest = SendCommentRequet()
                        commentRequest.sendComment(baseId: self.currentLobby.id, createdAt: "\(Date.timeIntervalBetween1970AndReferenceDate)", message: message, commentSuccessBlock: { (comment) in
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }, failed: {
                            self.showErrorMessage(message: "Yorum gönderilirken bir sorun oluştu.")
                        })
                    }
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyDetailOneButtonCell") as! LobbyDetailOneButtonCell
                cell.arrangeCell(type: .startGameChat) {
                    SVProgressHUD.show()
                    let request = ChangeLobbyChatStatusRequest()
                    request.sendRequest(lobbyId: self.currentLobby.id, successCompletion: { (lobby) in
                        SVProgressHUD.dismiss()
                        self.currentLobby = lobby
                        self.configurateLobbyDelegatesAndRequest()
                        
                    }, errorCompletion: {
                        SVProgressHUD.dismiss()
                        self.showErrorMessage(message: "Lobi sohbeti açılırken bir sorun oluştu.")
                    })
                    
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            if self.currentLobby.lobbyHasChat {
                return 46
            } else {
                return 20
            }
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            if self.currentLobby.lobbyHasChat {
                if self.currentLobby.lobbyHasChat {
                    let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 46))
                    titleView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
                    
                    let label = UILabel.init(frame: titleView.bounds)
                    label.textAlignment = .center
                    label.font = UIFont.init(name: "OpenSans-Bold", size: 12.0)
                    label.textColor = #colorLiteral(red: 0.1529411765, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
                    label.text = "Lobi Konuşmaları"
                    
                    titleView.addSubview(label)
                    
                    return titleView
                }
            } else {
                let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 1))
                titleView.backgroundColor = .white
                
                let seperatorView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 1))
                seperatorView.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 0.38)
                titleView.addSubview(seperatorView)
                return titleView
            }
        }
        
        return nil
    }
    
}
