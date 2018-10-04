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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            if self.isLobbyHasChat {
                return 46
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if self.isLobbyHasChat {
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
        }
        return nil
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
                        
                        let rushAlert = RushAlertController.createFromStoryboard()
                        rushAlert.createOneButtonAlert(title: "Heyy!", description: "Artık lobidesin! Lobide arkadaşların ile konuşabilmen ve oyuna başlamanız lobi sahibi tarafından belirlenmektedir.", buttonTitle: "Tamamdır", buttonTapped: {
                            self.currentLobby = lobby
                            self.configurateLobbyDelegatesAndRequest()
                        })
                        self.tabBarController?.present(rushAlert, animated: false, completion: nil)
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

