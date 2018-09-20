//
//  AppSync+LobbyDetail.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 20.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSAppSync

extension LobbyDetailVC {
    
    func configurateLobbyDelegatesAndRequest(){
        
        if currentLobby.lobbyHasChat {
            let fetchCommentRequest = FetchCommentsRequets()
            
            fetchCommentRequest.fetchComments(baseId: self.currentLobby.id, commentSuccessBlock: { (baseResponse) in
                self.comments = baseResponse.items
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
                self.subcribeCommentsRequest()
            }) {
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            }
            
            
        } else {
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    func subcribeCommentsRequest(){
        self.subscribeComment(baseId: self.currentLobby.id) { (comment) in
            self.comments.append(comment)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath.init(row: self.comments.count, section: 2), at: .bottom, animated: true)
            }
        }
    }
    
    func subscribeComment(baseId:String, commentsUpdate:@escaping (Comment)->Void) {
        do {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let appSyncClient = appDelegate.appSyncClient
            
            self.watcher = try appSyncClient?.subscribe(subscription: AddCommentSubscriptionSubscription(baseId: baseId), resultHandler: { (result, transaction, error) in
                if let comments = result?.data?.subscribeToEventComments {
                    
                    do {
                        
                        if let theJSONData = try? JSONSerialization.data( withJSONObject: comments.jsonObject, options: []) {
                            let object = try JSONDecoder().decode(Comment.self, from: theJSONData)
                            
                            var isContain = false
                            self.comments.forEach({ (comment) in
                                if comment.commentId.elementsEqual(object.commentId) {
                                    isContain = true
                                }
                            })
                            
                            if !isContain {
                                RushLogger.successLog(message: "New message getting")
                                commentsUpdate(object)
                            }
                        }
                    } catch {
                        
                    }
                }
            })
            
        } catch {
            RushLogger.errorLog(message: error.localizedDescription)
        }
        
    }
}
