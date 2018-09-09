//
//  FeedVC.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class FeedVC: BaseVC {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var credentialIdLabel: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    private var feedItems:[Feed]! {
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
        self.tableView.register(UINib.init(nibName: "FeedCell", bundle: .main), forCellReuseIdentifier: "FeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 333
        self.sendFeedRequest()
        self.tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.sendFeedRequest()
    }
    
    private func sendFeedRequest(){
        let feedRequest = FeedsRequest()
        SVProgressHUD.show()
        feedRequest.sendFeedRequest { (feeds, error) in
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            })
            if feeds != nil {
                SVProgressHUD.dismiss()
                self.feedItems = feeds
            } else {
                SVProgressHUD.dismiss()
                self.showErrorMessage(message: "There is an error to showing Timeline.")
            }
        }
    }
}

extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        cell.arrangeCell(feed: self.feedItems[indexPath.row], indexPath: indexPath) { (view, index) in
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = FeedDetailVC.createFromStoryboard()
        detail.feed = self.feedItems[indexPath.row]
        self.navigationController?.pushVCMainThread(detail)
    }
    
}

//
//@IBAction func logoutButtonTapped(_ sender: UIButton) {
//    AWSCredentialManager.shared.logout()
//    self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
//}

