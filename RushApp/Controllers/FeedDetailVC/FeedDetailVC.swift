//
//  FeedDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import CRRefresh
import AWSAppSync
import IQKeyboardManagerSwift

class FeedDetailVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    var watcher:AWSAppSyncSubscriptionWatcher<AddCommentSubscriptionSubscription>?
    
    var feed:Feed!
    var comments = [Comment]()
    
    private var commentButtonType:HideCommentButtonType!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        watcher?.cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configurateFeedComments()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func keyboardWillHide(){
        self.tableView.contentOffset = CGPoint(x: 60, y: 300)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "FeedTitleCell", bundle: .main), forCellReuseIdentifier: "FeedTitleCell")
        self.tableView.register(UINib.init(nibName: "FeedDetailCell", bundle: .main), forCellReuseIdentifier: "FeedDetailCell")
        self.tableView.register(UINib.init(nibName: "FeedCommentCell", bundle: .main), forCellReuseIdentifier: "FeedCommentCell")
        self.tableView.register(UINib.init(nibName: "MessageCell", bundle: .main), forCellReuseIdentifier: "MessageCell")
        self.tableView.register(UINib.init(nibName: "FeedCommentTitleViewCell", bundle: .main), forCellReuseIdentifier: "FeedCommentTitleViewCell")
        commentButtonType = .hidden
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let flexView = FeedDetailFlexView.fromNib() as! FeedDetailFlexView
        flexView.arrangeDetailFlexTitle(url: feed.picture)
        flexView.minimumContentHeight = 64
        flexView.maximumContentHeight = 200
        flexView.contentExpands = false
        self.tableView.addSubview(flexView)
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    private func loadUI(){
        self.navigationTitleLabel.text = ""
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.refreshControl.endRefreshing()
        }
    }
  
}

extension FeedDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else if section == 2 {
            if commentButtonType == .hidden {
                return 1
            } else {
                return comments.count + 1
            }
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTitleCell") as! FeedTitleCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedDetailCell") as! FeedDetailCell
            cell.arrangeCell(feed: feed)
            return cell
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentTitleViewCell") as! FeedCommentTitleViewCell
                cell.arrangeCell(currentType: self.commentButtonType) { (newType) in
                    DispatchQueue.main.async {
                        self.commentButtonType = newType
                        self.tableView.reloadData()
                    }
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentCell") as! FeedCommentCell
                cell.arrange(comment: self.comments[indexPath.row-1])
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
            cell.arrange { (message) in
                let commentRequest = SendCommentRequet()
                commentRequest.sendFeedComment(baseId: self.feed.id, createdAt: "\(Date().timeIntervalSinceReferenceDate)", feedDate: "\(self.feed.date.timeIntervalSinceReferenceDate)", message: message, commentSuccessBlock: { (comment) in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }, failed: {
                    self.showErrorMessage(message: "Yorum gönderilirken bir sorun oluştu.")
                })
            }
            return cell
        }
    }
}
