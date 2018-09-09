//
//  FeedDetailFlexView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 9.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class FeedDetailFlexView: GSKStretchyHeaderView {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing:  "FeedDetailFlexView"), owner: nil, options: nil)![0] as! T
    }
    

    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        visualEffectView.alpha = 1.0 - stretchFactor
        print(stretchFactor)
    }

}
