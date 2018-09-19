//
//  Extension+CommentSubscription.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 20.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSAppSync

extension LobbyDetailVCTheirs {
    
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
