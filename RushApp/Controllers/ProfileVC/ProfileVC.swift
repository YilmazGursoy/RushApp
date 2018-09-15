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
    var isMyProfile:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        sendUserLobbyRequest()
        setupUI()
        registerCollectionViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func sendAchivementRequest(){
        //TODO:
    }
    
    private func setupUI(){
        self.titleLabel.text = Rush.shared.currentUser.username
        ImageDownloaderManager.downloadImage(imageName: ConstantUrls.profilePictureName) { (url) in
            DispatchQueue.main.async {
                self.profilePictureImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options:.cacheMemoryOnly , completed: nil)
            }
        }
    }
    
    private func sendUserLobbyRequest(){
        let userlobbyRequest = UserAllLobbiesRequest()
        userlobbyRequest.sendLobbyRequest(userId: nil, successCompletionHandler: { (lobbyList) in
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
            self.profilePictureImage.image = image
            var newImage = image
            newImage = newImage.resizeImage(targetSize: constantProfilePictureSize)
            
            ImageUploadManager.uploadImage(newImage: newImage, completionSuccess: {
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
        
        print("Called just after FusumaViewController is dismissed.")
    }
    
    // When camera roll is not authorized, this method is called.
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
    }
    
    // Return an image and the detailed information.
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
        
    }
}
