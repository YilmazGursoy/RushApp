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
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkLocalization { (status) in
            if status == CLAuthorizationStatus.authorizedWhenInUse {
                self.getLobbyRequest()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "LobbyListCell", bundle: .main), forCellReuseIdentifier: "LobbyListCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func getLobbyRequest(){
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
        return self.lobbies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LobbyListCell") as! LobbyListCell
        cell.arrangeCell(lobby: self.lobbies[indexPath.row], index: indexPath.row)
        return cell
    }    
}

