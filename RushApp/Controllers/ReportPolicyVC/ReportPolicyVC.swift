//
//  ReportPolicyVC.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 13.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class ReportPolicyVC: BaseVC {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textView.setContentOffset(.zero, animated: false)
    }
    
    @IBAction func supportTapped(_ sender: Any) {
        if let url = URL(string: "mailto:support@rushapp.me") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

}
