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
}


