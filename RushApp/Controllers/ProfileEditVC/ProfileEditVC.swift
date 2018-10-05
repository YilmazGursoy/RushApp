//
//  ProfileEditVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 3.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import Fusuma
import SVProgressHUD

class ProfileEditVC: BaseVC {

    @IBOutlet private weak var profileImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var sexTextField: UITextField!
    
    @IBOutlet private weak var bioTextView: UITextView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    
    
    private var currentImage:UIImage?
    var updateProfile:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    
    fileprivate func setupUI(){
        self.profileImageView.sd_setImage(with: User.getProfilePictureFrom(userId: Rush.shared.currentUser.userId), completed: nil)
        self.nameLabel.text = Rush.shared.currentUser.fullName ?? "-"
        self.usernameLabel.text = Rush.shared.currentUser.username
        self.sexTextField.text = Rush.shared.currentUser.gender ?? "-"
        self.bioTextView.text = Rush.shared.currentUser.bio ?? "Selamlar!!"
        self.emailTextField.text = Rush.shared.currentUser.email ?? "-"
        self.phoneTextField.text = Rush.shared.currentUser.phoneNumber ?? "-"
        
        if Rush.shared.currentUser.age != nil {
            self.ageTextField.text = "\(Rush.shared.currentUser.age!)"
        } else {
            self.ageTextField.text = "-"
        }
    }
    
    
    @IBAction func changeProfilePictureImage(_ sender: Any) {
        let alertVC = RushAlertController.createFromStoryboard()
        alertVC.createAlert(title: "Hey!", description: "Profil resmini değiştirmek istediğine emin misin ?", positiveTitle: "Evet!", negativeTitle: "İptal", positiveButtonTapped: {
            let fusuma = FusumaViewController()
            fusuma.delegate = self
            fusuma.cropHeightRatio = 1.0
            fusuma.allowMultipleSelection = false
            fusumaSavesImage = true
            self.present(fusuma, animated: true, completion: nil)
        }) {
            
        }
        self.navigationController?.present(alertVC, animated: false, completion: nil)
    }
    @IBAction func ageTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        
        let actionSheet = UIAlertController(title: "Lütfen yaşınızı seçiniz.", message: nil, preferredStyle: .actionSheet)
        
        for value in 5..<80 {
            actionSheet.addAction(UIAlertAction.init(title: "\(value)", style: .default, handler: { (action) in
                self.ageTextField.text = "\(value)"
            }))
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func sexTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        let actionSheet = UIAlertController(title: "Lütfen cinsiyetinizi seçiniz.", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: "Erkek", style: .default, handler: { (action) in
            self.sexTextField.text = "Erkek"
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Kadın", style: .default, handler: { (action) in
            self.sexTextField.text = "Kadın"
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        SVProgressHUD.show()
        let request = UpdateUserProfileRequest()
        request.sendUpdateRequest(name: self.nameLabel.text, bio: self.bioTextView.text, email: self.emailTextField.text, phoneNumber: self.phoneTextField.text, gender: self.sexTextField.text, age: (self.ageTextField.text! as NSString).integerValue, successCompletion: { (user) in
            Rush.shared.currentUser = user
            self.updateUserProfilePicture {
                SVProgressHUD.dismiss()
                self.showSuccess(title: "Başarılı!", description: "Profiliniz başarı ile güncellenmiştir.", doneButtonTapped: {
                    self.updateProfile?()
                    self.dismiss()
                })
            }
        }) {
            SVProgressHUD.dismiss()
            self.showErrorMessage(message: "Profiliz güncellenirken bir hata oluştu!")
        }
    }
    
    private func updateUserProfilePicture(completion:@escaping ()->Void){
        if self.currentImage != nil {
            var newImage = self.currentImage!
            newImage = newImage.resizeImage(targetSize: constantProfilePictureSize)
            ImageUploadManager.uploadImage(newImage: newImage, completionSuccess: {
                completion()
            }, completionFailed: {
                self.showErrorMessage(message: "Profiliz güncellenirken bir hata oluştu!")
            })
        } else {
            completion()
        }
    }
    
}


extension ProfileEditVC : FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        DispatchQueue.main.async {
            self.currentImage = image
            self.profileImageView.image = self.currentImage
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

extension ProfileEditVC : UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
