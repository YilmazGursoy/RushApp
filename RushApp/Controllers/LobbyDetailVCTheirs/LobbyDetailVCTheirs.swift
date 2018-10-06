//
//  LobbyDetailVCTheirs.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 19.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSAppSync

class LobbyDetailVCTheirs: BaseVC {
    
    @IBOutlet weak var lobbyTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentLobby:Lobby!
    var isPreview:Bool = false
    var isAlreadySubLobby = false
    var isLobbyHasChat = false
    var comments:[Comment] = []
    var watcher:AWSAppSyncSubscriptionWatcher<AddCommentSubscriptionSubscription>?
    var isShowLobbyAlert:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.configurateLobbyDelegatesAndRequest()
        self.checkIsOpenFromAlert()
    }
    
    private func setupUI(){
        self.registerCells()
        self.lobbyTitle.text = currentLobby.name + " Lobby"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        watcher?.cancel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendComment(_ sender: Any) {
        
    }
    
    private func checkIsOpenFromAlert(){
        if isShowLobbyAlert == true {
            if self.currentLobby.lobbyStatus == .close {
                let rushReview = RushReviewAlertController.createFromStoryboard()
                rushReview.createReviewAlert(positiveButtonTapped: {}) {}
                self.tabBarController?.present(rushReview, animated: false, completion: nil)
            }
        }
    }
}
