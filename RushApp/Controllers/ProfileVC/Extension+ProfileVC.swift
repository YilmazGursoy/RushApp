//
//  Extension+ProfileVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

//MARK: Helper
extension ProfileVC {
    func registerCollectionViews(){
        self.lobbiesCollectionView.register(UINib.init(nibName: "ProfileLobbyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "ProfileLobbyCollectionCell")
        self.urlCollectionView.register(UINib.init(nibName: "ProfileRankCollectionCell", bundle: .main), forCellWithReuseIdentifier: "ProfileRankCollectionCell")
        self.urlCollectionView.register(UINib.init(nibName: "AddCollectionCell", bundle: .main), forCellWithReuseIdentifier: "AddCollectionCell")
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
            }
        } else {
            let lobbyDetailVC = LobbyDetailVC.createFromStoryboard()
            lobbyDetailVC.currentLobby = self.profileLobbyList[indexPath.row]
            self.navigationController?.pushVCMainThread(lobbyDetailVC)
        }
    }
    
}
