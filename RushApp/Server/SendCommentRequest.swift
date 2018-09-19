//
//  SendCommentRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 20.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSAppSync

//let baseId:String
//let commentId:String
//let createdAt:String
//let message:String
//let senderUserId:String
//let senderUserName:String


class SendCommentRequet : NSObject {
    
    var appSyncClient:AWSAppSyncClient?
    
    func sendComment(baseId:String, createdAt:String, message:String, commentSuccessBlock:@escaping (Comment)->Void, failed:@escaping ()->Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
        
        appSyncClient?.perform(mutation: AddCommentMutation(baseId: baseId, createdAt: createdAt, message: message, senderUserId: Rush.shared.currentUser.userId, senderUserName: Rush.shared.currentUser.username), queue: DispatchQueue.main, optimisticUpdate: nil, conflictResolutionBlock: nil, resultHandler: { (result, error) in
            
            if let comments = result?.data?.addComment {
                
                do {
                    
                    if let theJSONData = try? JSONSerialization.data( withJSONObject: comments.jsonObject, options: []) {
                        let object = try JSONDecoder().decode(Comment.self, from: theJSONData)
                        commentSuccessBlock(object)
                    } else {
                        failed()
                    }
                } catch {
                    failed()
                }
                
            } else {
                failed()
            }
        })
    }
}

