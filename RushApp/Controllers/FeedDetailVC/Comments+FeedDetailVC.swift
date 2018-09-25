//
//  Comments+FeedDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 23.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

import AWSAppSync

extension FeedDetailVC {
    
    func configurateFeedComments(){
        
        let fetchCommentRequest = FetchCommentsRequets()
        
        fetchCommentRequest.fetchComments(baseId: self.feed.id, commentSuccessBlock: { (baseResponse) in
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
    }
    
    func subcribeCommentsRequest(){
        self.subscribeComment(baseId: self.feed.id) { (comment) in
            self.comments.append(comment)
            DispatchQueue.main.async {
                if self.commentButtonType != .hidden {
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath.init(row: self.comments.count, section: 3)], with: .none)
                    self.tableView.endUpdates()
                    self.tableView.scrollToRow(at: IndexPath.init(row: self.comments.count, section: 3), at: .none, animated: true)
                } else {
                    self.tableView.reloadSections(IndexSet.init(integer: 3), with: UITableViewRowAnimation.none)
                }
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
