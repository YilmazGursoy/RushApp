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
        refreshControl.tintColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sendFeedRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "FeedCell", bundle: .main), forCellReuseIdentifier: "FeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
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
    
    @IBAction func postCreateTapped(_ sender: UIButton) {
        let createLobbyVC = CreateLobbyVC.createFromStoryboard()
        let navigationController = BaseNavigationController(rootViewController: createLobbyVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        self.present(navigationController, animated: true, completion: nil)
    }
    @IBAction func dummy(_ sender: UIButton) {
        let alert = RushReviewAlertController.createFromStoryboard()
        alert.createReviewAlert(positiveButtonTapped: {
            
        }) {
            
        }
        self.tabBarController?.present(alert, animated: false, completion: nil)
    }
    
}

extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        
        cell.arrangeCell(feed: self.feedItems[indexPath.row], indexPath: indexPath, selectCompletion: { (view, index) in
            
        }) { (index, isLike) in
            if isLike {
                let likeRequest = SendLikeRequest()
                likeRequest.sendLikeFeedRequest(feedId: self.feedItems[index].id, feedDate: self.feedItems[index].date.timeIntervalSinceReferenceDate, successCompletion: { (user) in
                    Rush.shared.currentUser = user
                    self.feedItems[indexPath.row].numberOfLike += 1
                }, errorCompletion: {
                    self.showErrorMessage(message: "Bir Sorun Oluştu.")
                })
            } else {
                
                let dislikeRequest = SendDislikeRequest()
                dislikeRequest.sendDislikeFeedRequest(feedId: self.feedItems[index].id, feedDate: self.feedItems[index].date.timeIntervalSinceReferenceDate, successCompletion: { (user) in
                    Rush.shared.currentUser = user
                    self.feedItems[indexPath.row].numberOfLike -= 1
                }, errorCompletion: {
                    
                })
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = FeedDetailVC.createFromStoryboard()
        detail.feed = self.feedItems[indexPath.row]
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushVCMainThread(detail)
    }
    
}

//
//@IBAction func logoutButtonTapped(_ sender: UIButton) {
//    AWSCredentialManager.shared.logout()
//    self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
//}

