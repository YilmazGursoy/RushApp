//
//  LobbyDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AWSAppSync
import SVProgressHUD

class LobbyDetailVC: BaseVC {
    
    @IBOutlet weak var lobbyPreviewTitle: UILabel!
    @IBOutlet weak var isPreviewBackgroundView: UIView!
    @IBOutlet weak var lobbyTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentLobby:Lobby!
    var isPreview:Bool = false
    
    var comments:[Comment] = []
    var watcher:AWSAppSyncSubscriptionWatcher<AddCommentSubscriptionSubscription>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.configurateLobbyDelegatesAndRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        watcher?.cancel()
    }
    
    private func setupUI(){
        registerCells()
        self.lobbyTitle.text = currentLobby.name + " Lobby"
        lobbyPreviewTitle.text = currentLobby.name + " Lobby"
        self.isPreviewBackgroundView.isHidden = !isPreview
    }
    
    func registerCells(){
        self.tableView.register(UINib.init(nibName: "LobbyDetailTitleCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailTitleCell")
        self.tableView.register(UINib.init(nibName: "LobbyDetailOneButtonCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailOneButtonCell")
        self.tableView.register(UINib.init(nibName: "MessageCell", bundle: .main), forCellReuseIdentifier: "MessageCell")
        self.tableView.register(UINib.init(nibName: "FeedCommentCell", bundle: .main), forCellReuseIdentifier: "FeedCommentCell")
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func lobbyDismissTapped(_ sender: Any) {
        if let tabbar = UIApplication.shared.keyWindow?.rootViewController as? TabBarController {
            tabbar.selectedIndex = 1
            if let selectedViewController = tabbar.selectedViewController as? UINavigationController {
                let lobbyDetailVC = LobbyDetailVC.createFromStoryboard()
                lobbyDetailVC.currentLobby = self.currentLobby
                selectedViewController.viewControllers.append(lobbyDetailVC)
            }
        }
        self.dismiss()
    }
}
