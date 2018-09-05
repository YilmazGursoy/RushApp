//
//  FeedVC.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Hero
import SVProgressHUD

class FeedVC: BaseVC {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var credentialIdLabel: UILabel!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    private func sendFeedRequest(){
        let feedRequest = FeedsRequest()
        SVProgressHUD.show()
        feedRequest.sendFeedRequest { (feeds, error) in
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
            self.setupAnimatingTransition(transitionView: view, feed: self.feedItems[index], index: index)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: Did Select Animating Transition Configure
extension FeedVC {
    func setupAnimatingTransition(transitionView:UIView, feed:Feed, index:Int) {
        let cardHeroId = "card\(index)"
        transitionView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        transitionView.hero.id = cardHeroId
        
        let vc = FeedDetailVC.createFromStoryboard()
        
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .none
        
        ******code is returning here
//
//        vc.cardView.hero.id = cardHeroId
//        vc.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
//        vc.cardView.imageView.image = UIImage(named: "Unsplash\(data)")
//
//        vc.contentCard.hero.modifiers = [.source(heroID: cardHeroId), .spring(stiffness: 250, damping: 25)]
//
//        vc.contentView.hero.modifiers = [.useNoSnapshot, .forceAnimate, .spring(stiffness: 250, damping: 25)]
//
//        vc.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
//
//        present(vc, animated: true, completion: nil)
        
    }
}


//
//@IBAction func logoutButtonTapped(_ sender: UIButton) {
//    AWSCredentialManager.shared.logout()
//    self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
//}

