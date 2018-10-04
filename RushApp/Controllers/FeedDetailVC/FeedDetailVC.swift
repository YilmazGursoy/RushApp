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

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    @IBOutlet weak var sendButtonBackView: GradientView!
    
    @IBOutlet weak var titleImageView: UIView!
    @IBOutlet weak var flexibleHeaderViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    var watcher:AWSAppSyncSubscriptionWatcher<AddCommentSubscriptionSubscription>?
    
    var feed:Feed!
    var comments = [Comment]()
    
    var commentButtonType:HideCommentButtonType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        watcher?.cancel()
        sendButtonPassive()
        self.messageTextField.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configurateFeedComments()
        sendButtonPassive()
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
        self.tableView.register(UINib.init(nibName: "FeedDetailImageCell", bundle: .main), forCellReuseIdentifier: "FeedDetailImageCell")
        IQKeyboardManager.shared.enableAutoToolbar = false
        commentButtonType = .hidden
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationTitleLabel.text = self.feed.title
    }
    
    private func loadUI(){
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
        }
    }
  
    @IBAction func sendCommentButtonTapped(_ sender: UIButton) {
        let commentRequest = SendCommentRequet()
        commentRequest.sendFeedComment(baseId: self.feed.id, createdAt: "\(Date().timeIntervalSinceReferenceDate)", feedDate: "\(self.feed.date.timeIntervalSinceReferenceDate)", message: self.messageTextField.text!, commentSuccessBlock: { (comment) in
            RushLogger.functionParametersLog(message: comment)
            self.messageTextField.text = ""
            self.sendButtonPassive()
        }, failed: {
            self.showErrorMessage(message: "Yorum gönderilirken bir sorun oluştu.")
        })
    }
}

extension FeedDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 {
            return 1
        } else if section == 3 {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedDetailImageCell") as! FeedDetailImageCell
            cell.arrangeDetailFlexTitle(url: self.feed.picture)
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTitleCell") as! FeedTitleCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedDetailCell") as! FeedDetailCell
            cell.arrangeCell(feed: feed)
            return cell
        } else {
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
        }
    }
}

extension FeedDetailVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        if newString != nil {
            if newString!.count > 0 {
                self.sendButtonActive()
            } else {
                self.sendButtonPassive()
            }
        } else {
            self.sendButtonPassive()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: Helpers
extension FeedDetailVC {
    private func sendButtonActive(){
        GradientView.animate(withDuration: 10) {
            self.sendButtonOutlet.isEnabled = true
            self.sendButtonBackView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
            self.sendButtonBackView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
        }
    }
    
    private func sendButtonPassive(){
        GradientView.animate(withDuration: 10) {
            self.sendButtonOutlet.isEnabled = false
            self.sendButtonBackView.topColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 0.5)
            self.sendButtonBackView.bottomColor = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 0.5)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            
            let constatntHeight:CGFloat = 200
            if (constatntHeight - scrollView.contentOffset.y) > 200 {
                self.titleImageView.alpha = 0.0
                self.navigationTitleLabel.alpha = 0.0
                flexibleHeaderViewHeightConstraint.constant = 200
            } else if (constatntHeight - scrollView.contentOffset.y) < 44 + topPadding! {
                self.titleImageView.alpha = 1.0
                self.navigationTitleLabel.alpha = 1.0
                flexibleHeaderViewHeightConstraint.constant = 44 + topPadding!
            } else {
                self.titleImageView.alpha = 1 - (((200-(44 + topPadding!)) - scrollView.contentOffset.y) / (200-(44 + topPadding!)))
                self.navigationTitleLabel.alpha = 1 - (((200-(44 + topPadding!)) - scrollView.contentOffset.y) / (200-(44 + topPadding!)))
                flexibleHeaderViewHeightConstraint.constant = (constatntHeight - scrollView.contentOffset.y)
            }
        }
        
    }
}
