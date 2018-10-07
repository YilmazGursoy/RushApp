//
//  Extension+ProfileVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

private let followingText = "Takip Ediliyor"
private let notConnectText = "+ Takip Et"
private let editText = "Düzenle"

//MARK: Helper
extension ProfileVC {
    func registerCollectionViews(){
        self.lobbiesCollectionView.register(UINib.init(nibName: "ProfileLobbyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "ProfileLobbyCollectionCell")
        self.urlCollectionView.register(UINib.init(nibName: "ProfileRankCollectionCell", bundle: .main), forCellWithReuseIdentifier: "ProfileRankCollectionCell")
        self.urlCollectionView.register(UINib.init(nibName: "AddCollectionCell", bundle: .main), forCellWithReuseIdentifier: "AddCollectionCell")
    
    }
    
    
    
    func sendFollowingReuqest(isSendingFollowing:Bool){
        SVProgressHUD.show()
        if isSendingFollowing {
            let request = SendFollowingRequest()
            request.sendAddUserRequest(userId: self.currentUser.userId, username: self.currentUser.username, responseSuccess: { (newUser) in
                let myProfileRequest = CheckUserRequest()
                self.currentUser = newUser
                myProfileRequest.sendCheckUserRequest(userId: Rush.shared.currentUser.userId, completionBlock: { (user, error) in
                    SVProgressHUD.dismiss()
                    if user != nil {
                        Rush.shared.currentUser = user!
                        self.setupUI(isCacheRefresh: false)
                    } else {
                        self.showErrorMessage(message: "Bir hata oluştu.")
                    }
                })
            }) {
                SVProgressHUD.dismiss()
            }
            
        } else {
            let request = SendRemoveFollowingRequest()
            request.sendRemoveUserRequest(userId: self.currentUserId, responseSuccess: { (newUser) in
                self.currentUser = newUser
                
                let myProfileRequest = CheckUserRequest()
                myProfileRequest.sendCheckUserRequest(userId: Rush.shared.currentUser.userId, completionBlock: { (user, error) in
                    SVProgressHUD.dismiss()
                    if user != nil {
                        Rush.shared.currentUser = user
                        self.setupUI(isCacheRefresh: false)
                    } else {
                        self.showErrorMessage(message: "Bir hata oluştu.")
                    }
                })
                
            }) {
                SVProgressHUD.dismiss()
                
            }
        }
    }
}

extension ProfileVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == urlCollectionView {
            if isMyProfile {
                return 2
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == urlCollectionView {
            if section == 1 {
                return 1
            } else {
                if currentUser.profileUrls != nil {
                    return currentUser.profileUrls!.count
                } else {
                    return 0
                }
            }
        } else {
            return profileLobbyList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == urlCollectionView {
            if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCollectionCell", for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileRankCollectionCell", for: indexPath) as! ProfileRankCollectionCell
                cell.arrangeCell(profileUrls: self.currentUser.profileUrls![indexPath.row])
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileLobbyCollectionCell", for: indexPath) as! ProfileLobbyCollectionCell
            cell.arrangeCell(lobby: self.profileLobbyList[indexPath.row])
            return cell
        }        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == urlCollectionView {
            if indexPath.section == 1 {
                let addrankVC = AddRankOrUrlVC.createFromStoryboard()
                addrankVC.updatedSuccess = {
                    SVProgressHUD.show()
                    self.sendCurrentUserRequest()
                }
                self.navigationController?.pushVCMainThread(addrankVC)
            } else {
                let popUp = RushAlertController.createFromStoryboard()
                
                var descriptionMessage:String = ""
                if isMyProfile {
                    descriptionMessage = "Profiline gitmek istediğine emin misin ?"
                } else {
                    descriptionMessage = "Arkadaşının profiline gitmek istediğine emin misin ?"
                }
                
                popUp.createAlert(title: "Hey!", description: descriptionMessage, positiveTitle: "Hadi Gidelim!", negativeTitle: "Vazgeç", positiveButtonTapped: {
                        guard let url = URL(string: self.currentUser.profileUrls![indexPath.row].url) else { return }
                        UIApplication.shared.open(url)
                }) {
                    
                }
                self.tabBarController?.present(popUp, animated: false, completion: nil)
                
            }
        } else {
            
            if currentUser.userId.elementsEqual(Rush.shared.currentUser.userId) {
                let lobbyDetailVC = LobbyDetailVC.createFromStoryboard()
                lobbyDetailVC.currentLobby = self.profileLobbyList[indexPath.row]
                self.navigationController?.pushVCMainThread(lobbyDetailVC)
            } else {
                let lobbyDetailTheirs = LobbyDetailVCTheirs.createFromStoryboard()
                lobbyDetailTheirs.currentLobby = self.profileLobbyList[indexPath.row]
                self.navigationController?.pushVCMainThread(lobbyDetailTheirs)
            }
        }
    }
    
}
