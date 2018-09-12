//
//  ImageUploadManager.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import AWSS3
import Foundation
import SVProgressHUD


class ImageUploadManager: NSObject {
    static func uploadImage(newImage:UIImage, completionSuccess:@escaping ()->Void, completionFailed:@escaping ()->Void){
        AWSCredentialManager.shared.currentCredential.getIdentityId().continueWith { (task) -> Any? in
            if task.result != nil {
                DispatchQueue.main.async {
                    let userId = task.result! as String
                    
                    guard let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ConstantUrls.profilePictureName) else {
                        return
                    }
                    do {
                        
                        try UIImagePNGRepresentation(newImage)?.write(to: imageURL)
                        let changeProfilePictureRequest = ChangeProfilePictureRequest()
                        changeProfilePictureRequest.changeProfilePicture(userId: userId, requestedImageUrl: imageURL, imageChangeSuccess: {
                            
                            let s3Url = ConstantUrls.profilePictureS3BaseUrl + userId + "/" + ConstantUrls.profilePictureName
                            ChangeProfilePictureRequest().changeProfilePictureFromDynamo(imageUrl: s3Url, profilePictureChanceSuccess: {
                                SVProgressHUD.dismiss()
                                completionSuccess()
                            }, profilePictureChangeFailed: {
                                SVProgressHUD.dismiss()
                                completionFailed()
                            })
                        }, imageChangeFailed: {
                            SVProgressHUD.dismiss()
                            completionFailed()
                            
                        }, uploadingStatus: { (percentage) in
                            if percentage >= 1.0 {
                            } else {
                                SVProgressHUD.showProgress(percentage)
                            }
                        })
                        
                    } catch { }
                    
                }
            } else {
                
            }
            return nil
        }
    }
    
    static func uploadImageOnlyS3(newImage:UIImage, completionSuccess:@escaping (String)->Void, completionFailed:@escaping ()->Void) {
        AWSCredentialManager.shared.currentCredential.getIdentityId().continueWith { (task) -> Any? in
            if task.result != nil {
                DispatchQueue.main.async {
                    let userId = task.result! as String
                    
                    guard let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ConstantUrls.profilePictureName) else {
                        return
                    }
                    do {
                        
                        try UIImagePNGRepresentation(newImage)?.write(to: imageURL)
                        let changeProfilePictureRequest = ChangeProfilePictureRequest()
                        changeProfilePictureRequest.changeProfilePicture(userId: userId, requestedImageUrl: imageURL, imageChangeSuccess: {
                            
                            let s3Url = ConstantUrls.profilePictureS3BaseUrl + userId + "/" + ConstantUrls.profilePictureName
                            
                            completionSuccess(s3Url)
                            
                        }, imageChangeFailed: {
                            SVProgressHUD.dismiss()
                            completionFailed()
                            
                        }, uploadingStatus: { (percentage) in
                            if percentage >= 1.0 {
                            } else {
                                SVProgressHUD.showProgress(percentage)
                            }
                        })
                        
                    } catch { }
                    
                }
            } else {
                
            }
            return nil
        }
    }
}
