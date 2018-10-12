//
//  LobbyDetailVCTheirs.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 19.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Lottie
import AWSAppSync

class LobbyDetailVCTheirs: BaseVC {
    
    @IBOutlet weak var lobbyStatusImage: UIImageView!
    @IBOutlet weak var lobbyStatusTitle: UILabel!
    @IBOutlet weak var lobbyStatusBackView: UIView!
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLobbyTopView()
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
    
    private func setupLobbyTopView(){
        if self.currentLobby.lobbyStatus == .open {
            self.lobbyStatusImage.image = #imageLiteral(resourceName: "lobbyWaitingIcon")
            self.lobbyStatusTitle.text = "Lobiye diğer oyuncular bekleniyor..."
            self.lobbyStatusBackView.backgroundColor = #colorLiteral(red: 0.1799041033, green: 0.7921879888, blue: 0.4234254658, alpha: 1)
        } else if self.currentLobby.lobbyStatus == .gaming {
            self.lobbyStatusImage.image = #imageLiteral(resourceName: "gamingIcon")
            self.lobbyStatusTitle.text = "Oyun başladı!"
            self.lobbyStatusBackView.backgroundColor = #colorLiteral(red: 0.1799041033, green: 0.7921879888, blue: 0.4234254658, alpha: 1)
        } else {
            self.lobbyStatusImage.image = #imageLiteral(resourceName: "lobbyEndIcon")
            self.lobbyStatusTitle.text = "Oyun Bitti!"
            self.lobbyStatusBackView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
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
    @IBAction func reportTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name.init(openReportScreenNotificationKey), object: ("Lobi Hakkında Sorun Bildir",ReportValue.lobby, self.currentLobby))
    }
}
