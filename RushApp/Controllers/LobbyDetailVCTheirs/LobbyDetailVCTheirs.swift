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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configurateLobbyDelegatesAndRequest()
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
    
    func configurateLobbyDelegatesAndRequest(){
        self.currentLobby.subscribers.forEach { (simpleUser) in
            if simpleUser.id.elementsEqual(Rush.shared.currentUser.userId) {
                isAlreadySubLobby = true
            }
        }
        
        if currentLobby.lobbyHasChat {
            isLobbyHasChat = true
            let fetchCommentRequest = FetchCommentsRequets()
            fetchCommentRequest.fetchComments(baseId: self.currentLobby.id, commentSuccessBlock: { (baseResponse) in
                self.comments = baseResponse.items
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
                self.subcribeCommentsRequest()
            }) {
                self.isLobbyHasChat = false
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            }
            
            
        } else {
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    func subcribeCommentsRequest(){
        self.subscribeComment(baseId: self.currentLobby.id) { (comment) in
            self.comments.append(comment)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
