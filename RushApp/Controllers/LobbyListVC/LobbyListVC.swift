//
//  LobbyListVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class LobbyListVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var lobbies:[Lobby]! {
        didSet {
            var filterLobbies = [Lobby]()
            if Rush.shared.filterGame != nil {
                filterLobbies = lobbies.filter{$0.game.id == Rush.shared.filterGame?.id}
            } else {
                filterLobbies = lobbies
            }
            var lastLobbies = [Lobby]()
            if Rush.shared.filterPlatform != .empty {
                lastLobbies = filterLobbies.filter{$0.platform == Rush.shared.filterPlatform}
            } else {
                lastLobbies = filterLobbies
            }
            filteredLobbies = lastLobbies
        }
    }
    
    var filteredLobbies:[Lobby]! {
        didSet{
            
            if filteredLobbies.count > 0 {
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNotifications()
        self.checkLocalization { (status) in
            if status == CLAuthorizationStatus.authorizedWhenInUse {
                self.getLobbyListRequest()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateFilters(notification:)), name: NSNotification.Name(rawValue: kUpdateFilter), object: nil)
    }
    
    @objc private func updateFilters(notification:Notification) {
        self.getLobbyListRequest()
    }
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "LobbyListCell", bundle: .main), forCellReuseIdentifier: "LobbyListCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func getLobbyListRequest(){
        let request = LobbyRequest()
        SVProgressHUD.show()
        request.sendGameLobbyRequestWithoutParameters { (lobbies, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                self.showErrorMessage(message: "There is an error to fetching lobbies.")
            } else {
                self.lobbies = lobbies
            }
        }
        
    }
    
}

extension LobbyListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredLobbies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyListCell") as! LobbyListCell
        cell.arrangeCell(lobby: self.filteredLobbies[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lobby = self.filteredLobbies[indexPath.row]
        if lobby.sender.id.elementsEqual(Rush.shared.currentUser.userId) {
            let lobbyDetailVC = LobbyDetailVC.createFromStoryboard()
            lobbyDetailVC.currentLobby = lobby
            self.navigationController?.pushVCMainThread(lobbyDetailVC)
        } else {
            let lobbyTheirs = LobbyDetailVCTheirs.createFromStoryboard()
            lobbyTheirs.currentLobby = lobby
            self.navigationController?.pushVCMainThread(lobbyTheirs)
        }
    }
}

