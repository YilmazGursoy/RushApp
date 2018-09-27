//
//  ProfileVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 1.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Fusuma
import SDWebImage
import SVProgressHUD
import PMAlertController

private let followingText = "Takip Ediliyor"
private let notConnectText = "+ Takip Et"
private let editText = "Düzenle"



class ProfileVC: BaseVC {
    
    static func push(in navigationController:UINavigationController, userId:String?) {
        let vc = ProfileVC.createFromStoryboard()
        if userId != nil {
            if userId!.elementsEqual(Rush.shared.currentUser.userId) {
                vc.isMyProfile = true
                return
            } else {
                vc.currentUserId = userId!
                vc.isMyProfile = false
            }
        } else {
            vc.isMyProfile = true
            vc.currentUser = Rush.shared.currentUser
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var numberOfFollowesLabel: UILabel!
    @IBOutlet weak var numberOfFollowingLabel: UILabel!
    @IBOutlet weak var followEditButtonOutlet: UIButton!
    @IBOutlet weak var folowButtonBackView: GradientView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var lobbiesBackView: UIView!
    @IBOutlet weak var lobbiesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var urlCollectionView: UICollectionView!
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFollowEditButtonOutlet(){
        if isMyProfile {
            self.folowButtonBackView.topColor = #colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1)
            self.folowButtonBackView.bottomColor = #colorLiteral(red: 0.8117647059, green: 0.5529411765, blue: 1, alpha: 1)
            self.folowButtonBackView.borderWidth = 0
            self.followEditButtonOutlet.setTitle(editText, for: .normal)
            
        } else {
            
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
    
    func setupUI(isCacheRefresh:Bool){
        DispatchQueue.main.async {
            self.sendUserLobbyRequest(userId:self.currentUser.userId)
            self.titleLabel.text = self.currentUser.username
            self.setupFollowEditButtonOutlet()
            UILabel.animate(withDuration: 0.1, animations: {
                self.numberOfFollowesLabel.text = "\(self.currentUser.followers?.count ?? 0)"
                self.numberOfFollowingLabel.text = "\(self.currentUser.following?.count ?? 0)"
            })
            
            DispatchQueue.main.async {
                if isCacheRefresh {
                    self.profilePictureImage.sd_setImage(with: self.currentUser.getProfilePictureURL(), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .refreshCached, completed: nil)
                } else {
                    self.profilePictureImage.sd_setImage(with: self.currentUser.getProfilePictureURL(), completed: nil)
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
                self.setupUI(isCacheRefresh: false)
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
        AWSCredentialManager.shared.logout { (isCompleted) in
            self.navigationController?.openForceVCMainThread(LoginVC.createFromStoryboard())
        }
    }
    
    @IBAction func profilePictureChangeTapped(_ sender: UIButton) {
        if isMyProfile {
            let alertVC = RushAlertController.createFromStoryboard()
            alertVC.createAlert(title: "Hey!", description: "Do you want to change Profile Picture ?", positiveTitle: "Yes!", negativeTitle: "Cancel", positiveButtonTapped: {
                let fusuma = FusumaViewController()
                fusuma.delegate = self
                fusuma.cropHeightRatio = 1.0
                fusuma.allowMultipleSelection = false
                fusumaSavesImage = true
                self.present(fusuma, animated: true, completion: nil)
            }) {
                
            }
            self.tabBarController?.present(alertVC, animated: false, completion: nil)
        }
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
            
            
            
        }
    }
}

extension ProfileVC : FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        DispatchQueue.main.async {
            var newImage = image
            newImage = newImage.resizeImage(targetSize: constantProfilePictureSize)
            ImageUploadManager.uploadImage(newImage: newImage, completionSuccess: {
                self.setupUI(isCacheRefresh: true)
                SVProgressHUD.showSuccess(withStatus: "Profile picture change!")
            }, completionFailed: {
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "There is an error to changing profile picture!")
            })
        }
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    
    // Return the image but called after is dismissed.
    func fusumaDismissedWithImage(image: UIImage, source: FusumaMode) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        let alert = RushAlertController.createFromStoryboard()
        alert.createAlert(title: "Hey!", description: "Maalesef ayarlardan fotoğraf erişiminizi açmanız gerekmektedir.", positiveTitle: "Tamam", negativeTitle: "Şimdi Değil", positiveButtonTapped: {
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            self.pop()
        }) {
            
        }
        self.present(alert, animated: false, completion: nil)
    }
    
    // Return an image and the detailed information.
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
        
    }
}
