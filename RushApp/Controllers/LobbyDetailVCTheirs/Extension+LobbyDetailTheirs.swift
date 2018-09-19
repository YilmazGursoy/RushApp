//
//  Extension+LobbyDetailTheirs.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 19.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

extension LobbyDetailVCTheirs : UITableViewDelegate, UITableViewDataSource {
    
    func registerCells(){
        self.tableView.register(UINib.init(nibName: "LobbyDetailTitleCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailTitleCell")
        self.tableView.register(UINib.init(nibName: "LobbyDetailOneButtonCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailOneButtonCell")
        self.tableView.register(UINib.init(nibName: "MessageCell", bundle: .main), forCellReuseIdentifier: "MessageCell")
        self.tableView.register(UINib.init(nibName: "FeedCommentCell", bundle: .main), forCellReuseIdentifier: "FeedCommentCell")
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            if isAlreadySubLobby {
                if isLobbyHasChat {
                    return self.comments.count + 1
                } else {
                    return 0
                }
            } else {
                return 1
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyDetailTitleCell") as! LobbyDetailTitleCell
            cell.arrangeCell(lobby: currentLobby) { (userId) in
                ProfileVC.push(in: self.navigationController!, userId: userId)
            }
            return cell
        } else {
            if isAlreadySubLobby {
                if isLobbyHasChat {
                    
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
                    return UITableViewCell() //TODO:
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyDetailOneButtonCell") as! LobbyDetailOneButtonCell
                cell.arrangeCell(type: .joinGame) {
                    SVProgressHUD.show()
                    let joinLobbyRequest = JoinLobbyRequest()
                    joinLobbyRequest.sendRequest(lobbyId: self.currentLobby.id, userId: self.currentLobby.userId, userName: Rush.shared.currentUser.username, successCompletion: { (lobby) in
                        SVProgressHUD.dismiss()
                        self.currentLobby = lobby
                        self.configurateLobbyDelegatesAndRequest()
                    
                    }, errorCompletion: {
                        SVProgressHUD.dismiss()
                        self.errorMessage(message: "Lobiye katılırken bir sorun oluştu.")
                    })
                    
                }
                return cell
            }
        }
    }
}

