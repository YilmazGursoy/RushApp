//
//  ProfileVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 1.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendAchivementRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func sendAchivementRequest(){
        for _ in 0...10 {
            let view = AchivementView.fromNib() as AchivementView
            view.width(constant: 155)
            view.height(constant: 120)
            stackView.addArrangedSubview(view)
        }
    }
}
