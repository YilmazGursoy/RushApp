//
//  AboutUsVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import AppRating

class AboutUsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reviewTapped(_ sender: Any) {
        AppRating.showRatingAlert()
    }
    @IBAction func supportTapped(_ sender: Any) {
        if let url = URL(string: "mailto:support@rushapp.me") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
