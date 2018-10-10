//
//  TableViewDelegate+LobbyDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 6.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

extension LobbyDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isPreview {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if self.currentLobby.lobbyStatus != .close {
                return 1
            } else {
                return 0
            }
        } else  {
            if self.currentLobby.lobbyStatus != .close {
                return self.comments.count + 1
            } else {
                return self.comments.count
            }
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
            if currentLobby.subscribers.count > currentLobby.numberOfNeededUser {
                if currentLobby.lobbyStatus == .open {
                    cell.arrangeCell(type: .startTheGame) {
                        let alert = RushAlertController.createFromStoryboard()
                        alert.createAlert(title: "Heyy!!", description: "Lobi' de oyunu başlatmak istediğine emin misin? Tüm arkadaşlarının profillerinden gerekli platform için arkadaş olarak eklemeyi unutmamışsındır umarım :)", positiveTitle: "Başlat", negativeTitle: "Vazgeçtim", positiveButtonTapped: {
                            SVProgressHUD.show()
                            let request = ChangeLobbyStatusRequest()
                            request.sendChangeLobbyStatus(lobbyId: self.currentLobby.id, newStatus: LobbyStatus.gaming, successCompletion: { (lobby) in
                                self.currentLobby = lobby
                                self.tableView.reloadData()
                                SVProgressHUD.dismiss()
                            }, errorCompletion: {
                                SVProgressHUD.dismiss()
                                self.showErrorMessage(message: "Bir hata oluştu!")
                            })
                        }, negativeButtonTapped: {
                            
                        })
                        self.tabBarController?.present(alert, animated: false, completion: nil)
                    }
                } else if currentLobby.lobbyStatus == .gaming {
                    cell.arrangeCell(type: .closeLobby) {
                        let alert = RushAlertController.createFromStoryboard()
                        alert.createAlert(title: "Heyy!!", description: "Oyunu bitirmek istediğine emin misin ?", positiveTitle: "Bitir", negativeTitle: "Vazgeçtim", positiveButtonTapped: {
                            SVProgressHUD.show()
                            let request = ChangeLobbyStatusRequest()
                            request.sendChangeLobbyStatus(lobbyId: self.currentLobby.id, newStatus: LobbyStatus.close, successCompletion: { (lobby) in
                                self.currentLobby = lobby
                                self.tableView.reloadData()
                                SVProgressHUD.dismiss()
                            }, errorCompletion: {
                                SVProgressHUD.dismiss()
                                self.showErrorMessage(message: "Bir hata oluştu!")
                            })
                        }, negativeButtonTapped: {
                            
                        })
                        self.tabBarController?.present(alert, animated: false, completion: nil)
                    }
                }
                
            } else {
                cell.arrangeCell(type: .addPlayer) {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                        let friendSelectionVC = FriendSelectionVC.createFromStoryboard()
                        friendSelectionVC.selectedFriendsTapped = { users in
                            
                            var allUsers = [SimpleUser]()
                            users.forEach({ (simpleUser) in
                                if !self.currentLobby.subscribers.contains{$0.id == simpleUser.id} {
                                    allUsers.append(simpleUser)
                                }
                            })
                            
                            SVProgressHUD.show()
                            let request = AddFriendToLobbyRequest()
                            request.sendFriendRequest(lobbyId: self.currentLobby.id, lobbyDate: self.currentLobby.date.timeIntervalSinceReferenceDate, username: Rush.shared.currentUser.username, userId: Rush.shared.currentUser.userId, users: allUsers, successCompletion: {
                                SVProgressHUD.dismiss()
                                self.showSuccess(message: "Davetin arkadaşlarına başarıyla gönderildi :)")
                            }, errrCompletion: {
                                SVProgressHUD.dismiss()
                                
                            })
                        }
                        self.present(friendSelectionVC, animated: false, completion: nil)
                    })
                }
            }
            return cell
        } else {
            
            if self.currentLobby.lobbyHasChat {
                if indexPath.row < self.comments.count {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentCell") as! FeedCommentCell
                    cell.arrange(comment: self.comments[indexPath.row]) { (userId) in
                        ProfileVC.push(in: self.navigationController!, userId: userId)
                    }
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
