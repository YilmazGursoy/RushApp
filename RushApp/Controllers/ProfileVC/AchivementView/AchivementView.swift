//
//  AchivementView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 1.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class AchivementView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    @IBAction func achivementTapped(_ sender: UIButton) {
        
    }
    
}

