//
//  ProfileVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 1.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Lottie
import SDWebImage
import SVProgressHUD
import PMAlertController

private let followingText = "Takip Ediliyor"
private let notConnectText = "+ Takip Et"
private let editText = "Düzenle"


class ProfileVC: BaseVC {
    @IBOutlet weak var followingTextLabel: UILabel!
    @IBOutlet weak var profileBadgeBackView: UIView!
    
    static func push(in navigationController:UINavigationController, userId:String?) {
        let vc = ProfileVC.createFromStoryboard()
        if userId != nil {
            if userId!.elementsEqual(Rush.shared.currentUser.userId) {
                vc.isMyProfile = true
                return
            } else {
                if let blackList = Rush.shared.currentUser.blackList {
                    if blackList.contains(where: {$0.id == userId}) {
                        return
                    }
                }
                
                vc.currentUserId = userId!
                vc.isMyProfile = false
            }
        } else {
            vc.isMyProfile = true
            vc.currentUser = Rush.shared.currentUser
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var numberOfFollowesLabel: UILabel!
    @IBOutlet weak var numberOfFollowingLabel: UILabel!
    @IBOutlet weak var followEditButtonOutlet: UIButton!
    @IBOutlet weak var folowButtonBackView: GradientView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var lobbiesBackView: UIView!
    @IBOutlet weak var profileBackView: UIImageView!
    @IBOutlet weak var lobbiesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var urlCollectionView: UICollectionView!
    @IBOutlet weak var settingsButtonOutlet: UIButton!
    
    
    var currentUserId:String!
    var isMyProfile:Bool = true
    
    var profileLobbyList:[Lobby]! {
        didSet{
            DispatchQueue.main.async {
                self.lobbiesCollectionView.delegate = self
                self.lobbiesCollectionView.dataSource = self
                self.lobbiesCollectionView.reloadData()
            }
        }
    }
    
    var currentUser:User! {
        didSet {
            DispatchQueue.main.async {
                self.urlCollectionView.delegate = self
                self.urlCollectionView.dataSource = self
                self.urlCollectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViews()
        self.backButtonOutlet.isHidden = isMyProfile ? true : false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.dismiss()
        sendCurrentUserRequest()
        self.settingsButtonOutlet.setImage(((isMyProfile == true) ? #imageLiteral(resourceName: "settings") : #imageLiteral(resourceName: "report")), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFollowEditButtonOutlet(){
        if isMyProfile {
            self.followingTextLabel.text = "Takip Ettiklerin"
            self.folowButtonBackView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
            self.folowButtonBackView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
            self.folowButtonBackView.borderWidth = 0
            self.followEditButtonOutlet.setTitle(editText, for: .normal)
        } else {
            self.followingTextLabel.text = "Takip Ettikleri"
            let followingList = Rush.shared.currentUser.following
            let value = followingList?.filter({ $0.id == self.currentUserId })
            if value != nil {
                if value!.count > 0 {
                    //Already in list
                    self.folowButtonBackView.backgroundColor = .clear
                    self.folowButtonBackView.topColor = .clear
                    self.folowButtonBackView.bottomColor = .clear
                    self.folowButtonBackView.borderWidth = 1
                    self.folowButtonBackView.borderColor = .white
                    self.followEditButtonOutlet.setTitle(followingText, for: .normal)
                } else {
                    self.folowButtonBackView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
                    self.folowButtonBackView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
                    self.folowButtonBackView.borderWidth = 0
                    self.followEditButtonOutlet.setTitle(notConnectText, for: .normal)
                }
            } else {
                self.folowButtonBackView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
                self.folowButtonBackView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
                self.folowButtonBackView.borderWidth = 0
                self.followEditButtonOutlet.setTitle(notConnectText, for: .normal)
            }
        }
    }
    
    private func sendAchivementRequest(){
        //TODO:
    }
    
    func setupUI(isCacheRefresh:Bool, isClearAllCache:Bool){
        DispatchQueue.main.async {
            
            if let hasBadge = self.currentUser.hasBadge {
                if hasBadge == true {
                    self.profileBadgeBackView.subviews.forEach({ (subView) in
                        subView.removeFromSuperview()
                    })
                    
                    let lottieView = LOTAnimationView(name: "check_animation")
                    lottieView.frame = self.profileBadgeBackView.bounds
                    self.profileBadgeBackView.addSubview(lottieView)
                    lottieView.play { (finish) in}
                }
            }
            
            if self.currentUser.gameList != nil {
                var newGameList = self.currentUser.gameList?.shuffled()
                if let game = newGameList?.first {
                    if game.lobbyImage != nil {
                        self.profileBackView.sd_setImage(with: game.getLobbyImageURL(), placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                    }
                }
            }
            
            self.bioLabel.text = self.currentUser.bio ?? "Selamlar!"
            self.sendUserLobbyRequest(userId:self.currentUser.userId)
            self.titleLabel.text = self.currentUser.username
            self.setupFollowEditButtonOutlet()
            
            if self.currentUser.followers != nil {
                self.currentUser.followers = User.getFilteredUsers(userList: self.currentUser.followers!)
            }
            
            if self.currentUser.following != nil {
                self.currentUser.following = User.getFilteredUsers(userList: self.currentUser.following!)
            }
            
            UILabel.animate(withDuration: 0.1, animations: {
                self.numberOfFollowesLabel.text = "\(self.currentUser.followers?.count ?? 0)"
                self.numberOfFollowingLabel.text = "\(self.currentUser.following?.count ?? 0)"
            })
            
            DispatchQueue.main.async {
                if isClearAllCache {
                    let cache = SDImageCache.shared()
                    cache.removeImage(forKey: User.getProfilePictureFrom(userId: self.currentUser.userId).absoluteString, withCompletion: {
                        self.profilePictureImage.sd_setImage(with: User.getProfilePictureFrom(userId: self.currentUser.userId), completed: nil)
                    })
                } else {
                    if isCacheRefresh {
                        self.profilePictureImage.sd_setImage(with: User.getProfilePictureFrom(userId: self.currentUser.userId), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
                    } else {
                        self.profilePictureImage.sd_setImage(with: User.getProfilePictureFrom(userId: self.currentUser.userId), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .cacheMemoryOnly, completed: nil)
                    }
                }
            }
        }
    }
    
    func sendCurrentUserRequest(){
        let currentUserRequest = CheckUserRequest()
        currentUserRequest.sendCheckUserRequest(userId: (isMyProfile ? nil : currentUserId)) { (user, error) in
            if self.isMyProfile {
                if user != nil {
                    Rush.shared.currentUser = user
                }
            }
            self.currentUser = user
            DispatchQueue.main.async {
                self.setupUI(isCacheRefresh: false, isClearAllCache: false)
            }
        }
    }
    
    private func sendUserLobbyRequest(userId:String?){
        let userlobbyRequest = UserAllLobbiesRequest()
        userlobbyRequest.sendLobbyRequest(userId: userId, successCompletionHandler: { (lobbyList) in
            if lobbyList.count > 0 {
                self.profileLobbyList = lobbyList
                self.lobbiesBackView.isHidden = false
            } else {
                self.lobbiesBackView.isHidden = true
            }
            SVProgressHUD.dismiss()
        }) {
            self.lobbiesBackView.isHidden = true
            SVProgressHUD.dismiss()
            self.showErrorMessage(message: "There is an error to fetching Lobbies!")
        }
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        if isMyProfile {
            let settingsVC = SettingsVC.createFromStoryboard()
            self.navigationController?.pushVCMainThread(settingsVC)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.init(openReportScreenNotificationKey), object: ("Profil Hakkında Sorun Bildir",ReportValue.user, self.currentUser))
        }
    }
    
    @IBAction func profilePictureChangeTapped(_ sender: UIButton) {
        
    }
    @IBAction func followesTapped(_ sender: UIButton) {
        if currentUser.followers != nil {
            if currentUser.followers!.count > 0 {
                let vc = UserListVC.createFromStoryboard()
                vc.list = currentUser.followers!
                vc.listType = .followes
                self.navigationController?.pushVCMainThread(vc)
            }
        }
    }
    
    @IBAction func followingTapped(_ sender: Any) {
        if currentUser.following != nil {
            if currentUser.following!.count > 0 {
                let vc = UserListVC.createFromStoryboard()
                vc.list = currentUser.following!
                vc.listType = .following
                self.navigationController?.pushVCMainThread(vc)
            }
        }
    }
    
    @IBAction func followEditTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == followingText {
            
            self.sendFollowingReuqest(isSendingFollowing: false)
            
        } else if sender.titleLabel?.text == notConnectText {
            
            self.sendFollowingReuqest(isSendingFollowing: true)
            
        } else if sender.titleLabel?.text == editText {
            let vc = ProfileEditVC.createFromStoryboard()
            vc.updateProfile = {
                self.currentUser = Rush.shared.currentUser
                self.setupUI(isCacheRefresh: true, isClearAllCache: true)
            }
            let navigationController = BaseNavigationController(rootViewController: vc)
            navigationController.setNavigationBarHidden(true, animated: false)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
