//
//  TermsVC.swift
//  Rush
//
//  Created by Yilmaz Gursoy on 17.10.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import WebKit

class TermsVC: BaseVC {
    
    var readAndAcceptTapped:(()->Void)?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "terms", withExtension: "html")
        
        self.webView.load(URLRequest.init(url: url!))
    }
    @IBAction func readAndAcceptTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.readAndAcceptTapped?()
        }
    }
    
}
