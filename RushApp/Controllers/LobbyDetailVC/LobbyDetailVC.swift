//
//  LobbyDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 7.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class LobbyDetailVC: BaseVC {
    
    @IBOutlet weak var lobbyPreviewTitle: UILabel!
    @IBOutlet weak var isPreviewBackgroundView: UIView!
    @IBOutlet weak var lobbyTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentLobby:Lobby!
    var isPreview:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "LobbyDetailTitleCell", bundle: .main), forCellReuseIdentifier: "LobbyDetailTitleCell")
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.lobbyTitle.text = currentLobby.name + " Lobby"
        lobbyPreviewTitle.text = currentLobby.name + " Lobby"
        self.isPreviewBackgroundView.isHidden = !isPreview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension LobbyDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyDetailTitleCell") as! LobbyDetailTitleCell
        cell.arrangeCell(lobby: currentLobby) { (userId) in
            ProfileVC.push(in: self.navigationController!, userId: userId)
        }
        return cell
    }
    
}
