//
//  FilterDetailListVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 11.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

enum FilterDetailListType {
    case game
    case platform
}

class FilterDetailListVC: BaseVC {
    
    //MARK: Publics
    var navigationTitle:String!
    var cellTitle:String!
    var type:FilterDetailListType!
    var gameList:[Game]! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Privates
    @IBOutlet private weak var navigationTitleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitleLabel.text = navigationTitle
        sendGameList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    private func sendGameList(){
        let request = GameListRequest()
        request.sendGameListRequest { (games, error) in
            if games != nil {
                self.gameList = games!
            }
        }
    }
    
}

extension FilterDetailListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .game {
            return gameList.count
        } else {
            return AppConstants.constantPlatforms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlatformCell")
        if type == .game {
            (cell?.viewWithTag(12) as! UILabel).text = gameList[indexPath.row].name
        } else {
            (cell?.viewWithTag(12) as! UILabel).text = AppConstants.constantPlatforms[indexPath.row]
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 43))
        headerView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        let label = UILabel(frame: CGRect.init(x: 15, y: 0, width: tableView.frame.size.width, height: 43))
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.51)
        if section == 0 {
            label.text = cellTitle
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .game {
            Rush.shared.filterGame = self.gameList[indexPath.row]
        } else {
            Rush.shared.filterPlatform = Platform.getPlatformFromString(type: AppConstants.constantPlatforms[indexPath.row])
        }
        self.pop()
    }
}
