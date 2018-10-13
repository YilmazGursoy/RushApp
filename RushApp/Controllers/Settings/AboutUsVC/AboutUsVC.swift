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
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textView.setContentOffset(.zero, animated: false)
    }
    
    @IBAction func reviewTapped(_ sender: Any) {
        AppRating.showRatingAlert()
    }
}
