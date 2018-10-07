//
//  Extension+FeedVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseMessaging

extension FeedVC {
    func joinLobbyRequest(lobbyRequest:LobbyRequestModel) {
        SVProgressHUD.show()
        let joinLobbyRequest = JoinLobbyRequest()
        joinLobbyRequest.sendRequest(lobbyId: lobbyRequest.lobbyId, userId: lobbyRequest.lobbyUserId, userName: Rush.shared.currentUser.username, successCompletion: { (lobby) in
            SVProgressHUD.dismiss()
            self.removeRequest(lobbyId: lobbyRequest.lobbyId, completion: {
                DispatchQueue.main.async {
                    let rushAlert = RushAlertController.createFromStoryboard()
                    rushAlert.createOneButtonAlert(title: "Heyy!", description: "Artık lobidesin! Lobide arkadaşların ile konuşabilmen ve oyuna başlamanız lobi sahibi tarafından belirlenmektedir.", buttonTitle: "Tamamdır", buttonTapped: {
                        let topicID = lobby.id.replacingOccurrences(of: ":", with: "")
                        Messaging.messaging().subscribe(toTopic: "\(topicID)")
                        self.tableView.reloadData()
                    })
                    self.tabBarController?.present(rushAlert, animated: false, completion: nil)
                }
            })
        }, errorCompletion: {
            SVProgressHUD.dismiss()
            self.errorMessage(message: "Lobiye katılırken bir sorun oluştu.")
        })
    }
    
    func deleteLobbyRequest(lobbyRequest:LobbyRequestModel) {
        self.removeRequest(lobbyId: lobbyRequest.lobbyId) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func removeRequest(lobbyId:String, completion:@escaping ()->Void){
        let request = RemoveLobbyRequest()
        request.sendRemoveRequets(lobbyId: lobbyId, successHandler: { (user) in
            Rush.shared.currentUser = user
            completion()
        }) {
            self.showErrorMessage(message: "Bir sorun oluştu!")
        }
    }
}
