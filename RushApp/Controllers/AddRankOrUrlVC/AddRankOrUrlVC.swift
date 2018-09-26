//
//  AddRankOrUrlVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddRankOrUrlVC: BaseVC {
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var updatedSuccess:()->Void = {}
    
    var currentPlatform:Platform?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Actions
    @IBAction func saveTapped(_ sender: UIButton) {
        if !urlTextField.text!.isEmpty && currentPlatform != nil {
            SVProgressHUD.show()
            let addUrlRequest = AddRankOrUrlRequest()
            addUrlRequest.sendUrlRequest(platform: currentPlatform!.rawValue, url: urlTextField.text!, successCompletion: {
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.updatedSuccess()
                    self.pop()
                }
            }) {
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.showErrorMessage(message: "URL eklenirken bir sorun oluştu.")
                }
            }
        }
    }
    @IBAction func platformTapped(_ sender: UIButton) {
        let platformSelectionVC = PlatformSelectionVC.createFromStoryboard()
        platformSelectionVC.selectedPlatform = {platform in
            self.currentPlatform = platform
            self.platformTextField.text = platform.getPlatformName()
        }
        self.navigationController?.pushVCMainThread(platformSelectionVC)
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    private func saveButtonPassive(){
        UIButton.animate(withDuration: 0.2) {
            self.saveButtonOutlet.isUserInteractionEnabled = false
            self.saveButtonOutlet.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
        }
    }
    
    private func saveButtonActive(){
        UIButton.animate(withDuration: 0.2) {
            self.saveButtonOutlet.isUserInteractionEnabled = true
            self.saveButtonOutlet.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.3529411765, blue: 1, alpha: 1), for: .normal)
        }
    }
    
}

extension AddRankOrUrlVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        if newString != nil {
            if self.verifyUrl(urlString: newString!) {
                self.saveButtonActive()
            } else {
                self.saveButtonPassive()
            }
        } else {
            self.saveButtonPassive()
        }
        return true
    }
    
}
