//
//  FeedView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 3.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
