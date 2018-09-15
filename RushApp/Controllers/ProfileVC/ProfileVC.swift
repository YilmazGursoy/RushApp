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
    
    @IBOutlet weak var lobbiesBackView: UIView!
    @IBOutlet weak var lobbiesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var urlCollectionView: UICollectionView!
    var profileLobbyList:[Lobby]! {
        didSet{
            DispatchQueue.main.async {
                self.lobbiesCollectionView.delegate = self
                self.lobbiesCollectionView.dataSource = self
                self.lobbiesCollectionView.reloadData()
            }
        }
    }
    var currentUserId:String!
    var currentUser:User!
    var isMyProfile:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViews()
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
    
    private func sendAchivementRequest(){
        //TODO:
    }
    
    private func setupUI(isCacheRefresh:Bool){
        DispatchQueue.main.async {
            self.sendUserLobbyRequest(userId:self.currentUser.userId)
            self.titleLabel.text = self.currentUser.username
            
            ImageDownloaderManager.downloadProfileImage(userId: self.currentUser.userId, completionBlock: { (url) in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.profilePictureImage.sd_setImage(with: url, completed: { (image, error, cacheType, url) in
                        
                    })
                }
            }, failedBlock: {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.profilePictureImage.image = #imageLiteral(resourceName: "profilePlaceholder")
                }
            })
        }
    }
    
    private func sendCurrentUserRequest(){
        let currentUserRequest = CheckUserRequest()
        currentUserRequest.sendCheckUserRequest(userId: (isMyProfile ? nil : currentUserId)) { (user, error) in
            if self.isMyProfile {
                if user != nil {
                    Rush.shared.currentUser = user
                }
            }
            self.currentUser = user
            self.setupUI(isCacheRefresh: false)
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
