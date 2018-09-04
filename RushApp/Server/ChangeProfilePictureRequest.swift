//
//  ChangeProfilePictureRequest.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 1.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSS3

class ChangeProfilePictureRequest : Request {
    var lambdaName: String? {
        return LambdaConstants.UserProfilePictureUpdate
    }
    
    
    func changeProfilePicture(userId:String ,requestedImageUrl:URL, imageChangeSuccess:@escaping ()->Void, imageChangeFailed:@escaping ()->Void, uploadingStatus:@escaping (Float)->Void) {
        let transferManager = AWSS3TransferManager.default()
        
        let uploadingFileURL = requestedImageUrl
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest!.bucket = CognitoConstants.awsS3ProfilePictureBucketName
        uploadRequest!.key = "\(userId)/\(ConstantUrls.profilePictureName)"
        uploadRequest!.body = uploadingFileURL
        
        transferManager.upload(uploadRequest!).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Any? in
            
            if let _ = task.error as NSError? {
                imageChangeFailed()
                return nil
            } else {
                imageChangeSuccess()
            }
            return nil
        })
        
        uploadRequest?.uploadProgress = {(bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
                uploadingStatus(Float(totalBytesSent)/Float(totalBytesExpectedToSend))
            })
        }
        
    }
    
    func changeProfilePictureFromDynamo(imageUrl:String, profilePictureChanceSuccess: @escaping ()->Void, profilePictureChangeFailed: @escaping ()->Void) {
        
        let parameters = ["profilePictureUrl":imageUrl]
        
//        self.requestWith(functionName: lambdaName, andParameters: parameters) { (result, error) -> (Void) in
//            if result != nil {
//                profilePictureChanceSuccess()
//            } else {
//                profilePictureChangeFailed()
//            }
//        }
    }
    
}
