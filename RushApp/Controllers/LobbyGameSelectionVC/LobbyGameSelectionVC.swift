//
//  LobbyGameSelectionVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class LobbyGameSelectionVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedGame:(Game)->Void = {_ in}
    
    var gameList:[Game]!{
        didSet{
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendGameListRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func sendGameListRequest(){
        let gameListRequest = GameListRequest()
        SVProgressHUD.show()
        gameListRequest.sendGameListRequest { (gameList, error) in
            SVProgressHUD.dismiss()
            if let newGameList = gameList {
                self.gameList = newGameList
            } else {
                self.pop()
            }
        }
    }
    
}


extension LobbyGameSelectionVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell")
        (cell?.viewWithTag(12) as! UILabel).text = gameList[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame(gameList[indexPath.row])
        self.pop()
    }
    
}
