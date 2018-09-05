//
//  FeedDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedDetailVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var animationBlackView: UIView!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageBackView: UIView!
    
    @IBOutlet weak var feedDetailImage: UIImageView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    
    var feed:Feed!
    private var commentButtonType:HideCommentButtonType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        if self.tableView.contentSize.height < self.view.frame.height {
            self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: ((self.view.frame.height+50.0) - self.tableView.contentSize.height), right: 0)
        } else {
            self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
        }
    }
    
    private func setupUI(){
        self.tableView.register(UINib.init(nibName: "FeedTitleCell", bundle: .main), forCellReuseIdentifier: "FeedTitleCell")
        self.tableView.register(UINib.init(nibName: "FeedDetailCell", bundle: .main), forCellReuseIdentifier: "FeedDetailCell")
        self.tableView.register(UINib.init(nibName: "FeedCommentCell", bundle: .main), forCellReuseIdentifier: "FeedCommentCell")
        commentButtonType = .hidden
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadUI(){
        self.navigationTitleLabel.text = "Detay"
        self.feedDetailImage.sd_setImage(with: feed.picture, placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .cacheMemoryOnly, completed: nil)
    }
    
  
}

//MARK: UIScrollViewDelegate
extension FeedDetailVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationBarAnimation(contentOffset: scrollView.contentOffset)
    }
}

//MARK: Helper methods
extension FeedDetailVC {
    func navigationBarAnimation(contentOffset:CGPoint){
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        
        let minToScroll = 136.0 - (topPadding ?? 0)
        print(contentOffset.y)
        if contentOffset.y > 0 && contentOffset.y < minToScroll {
            imageTopConstraint.constant = -contentOffset.y
            animationBlackView.alpha = contentOffset.y / 100
        } else if contentOffset.y > 0 {
            imageTopConstraint.constant = -minToScroll
            animationBlackView.alpha = 1.0
        } else if contentOffset.y < 0 {
            imageTopConstraint.constant = 0.0
            animationBlackView.alpha = 0.0
        }
        self.view.setNeedsLayout()
    }
}

extension FeedDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            if commentButtonType == .hidden {
                return 0
            } else {
                return 10
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTitleCell") as! FeedTitleCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedDetailCell") as! FeedDetailCell
            cell.arrangeCell(feed: feed)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentCell") as! FeedCommentCell
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 50.0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let titleView = FeedCommentTitleView.fromNib() as FeedCommentTitleView
            titleView.createTitleView(currentType: self.commentButtonType) { (type) in
                DispatchQueue.main.async {
                    self.commentButtonType = type
                    tableView.reloadData()
                }
            }
            return titleView
        } else {
            return nil
        }
    }
    
}
