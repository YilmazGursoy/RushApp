//
//  ImageDownloaderManager.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import AWSS3

class ImageDownloaderManager : NSObject {
    
    static func downloadImage(imageName:String, completionBlock:@escaping (URL)->Void) {
        AWSCredentialManager.shared.currentCredential.getIdentityId().continueWith { (task) -> Any? in
            let userId = task.result! as String
            
            let transferManager = AWSS3TransferManager.default()
            let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imageName)
            
            let downloadRequest = AWSS3TransferManagerDownloadRequest()
            
            downloadRequest?.bucket = CognitoConstants.awsS3ProfilePictureBucketName
            downloadRequest?.key = "\(userId)/\(ConstantUrls.profilePictureName)"
            downloadRequest?.downloadingFileURL = downloadingFileURL
            
            transferManager.download(downloadRequest!).continueWith(block: { (task) -> Any? in
                
                if let result = task.result {
                    if let downloadOutput = result as? AWSS3TransferManagerDownloadOutput {
                        if let url = downloadOutput.body as? URL {
                            completionBlock(url)
                        }
                    }
                }
                
                return nil
            })
            return nil
        }
    }
    
    static func downloadProfileImage(userId:String?, completionBlock:@escaping (URL)->Void, failedBlock:@escaping ()->Void) {
        
        if userId != nil {
            let transferManager = AWSS3TransferManager.default()
            let downloadRequest = AWSS3TransferManagerDownloadRequest()
            downloadRequest?.bucket = CognitoConstants.awsS3ProfilePictureBucketName
            downloadRequest?.key = userId! + "/" + ConstantUrls.profilePictureName
            transferManager.download(downloadRequest!).continueWith { (task) -> Any? in
                if let result = task.result {
                    if let downloadOutput = result as? AWSS3TransferManagerDownloadOutput {
                        if let url = downloadOutput.body as? URL {
                            completionBlock(url)
                        }
                    }
                } else {
                    failedBlock()
                }
                return nil
            }
        } else {
            failedBlock()
        }
    }
}
