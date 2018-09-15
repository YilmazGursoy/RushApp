//
//  AddRankOrUrlVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 15.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class AddRankOrUrlVC: BaseVC {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformTextField: UITextField!
    
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
    }
    @IBAction func platformTapped(_ sender: UIButton) {
        let platformSelectionVC = PlatformSelectionVC.createFromStoryboard()
        platformSelectionVC.selectedPlatform = {platform in
            self.platformTextField.text = platform.getPlatformName()
        }
        self.navigationController?.pushVCMainThread(platformSelectionVC)
    }
}
