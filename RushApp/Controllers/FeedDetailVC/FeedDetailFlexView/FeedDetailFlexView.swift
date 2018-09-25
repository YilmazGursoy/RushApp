//
//  FeedDetailFlexView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 9.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import SDWebImage
import GSKStretchyHeaderView

class FeedDetailFlexView: GSKStretchyHeaderView {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing:  "FeedDetailFlexView"), owner: nil, options: nil)![0] as! T
    }

    override func layoutSubviews() {
        
    }
    
    override func draw(_ rect: CGRect) {
        
    }

    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        visualEffectView.alpha = 1.0 - stretchFactor
    }
    
    func arrangeDetailFlexTitle(url:URL?) {
        self.feedImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholderImage"), options: .continueInBackground, completed: nil)
    }

}
