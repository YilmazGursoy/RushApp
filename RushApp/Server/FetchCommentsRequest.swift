//
//  FetchCommentsRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 20.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSAppSync

class FetchCommentsRequets: NSObject {
    var appSyncClient:AWSAppSyncClient?
    
    func fetchComments(baseId:String, commentSuccessBlock:@escaping (BaseCommentResponse)->Void, failed:@escaping ()->Void) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.appSyncClient = appDelegate.appSyncClient
            
            self.appSyncClient?.fetch(query: GetCommentQuery(baseId: baseId), cachePolicy: .returnCacheDataAndFetch, queue: DispatchQueue.main, resultHandler: { (response, error) in
                
                if let comments = response?.data?.getCommentsInBaseId {
                    do {
                        
                        if let theJSONData = try? JSONSerialization.data( withJSONObject: comments.jsonObject, options: []) {
                            let object = try JSONDecoder().decode(BaseCommentResponse.self, from: theJSONData)
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
}
