//
//  FeedDetailVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FeedDetailVC: BaseVC {

    @IBOutlet weak var animationBlackView: UIView!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topImageBackView: UIView!
    
    var feed:Feed!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

//MARK: UIScrollViewDelegate
extension FeedDetailVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationBarAnimation(contentOffset: scrollView.contentOffset)
    }
}

//MARK: Helper methods
extension FeedDetailVC {
    func navigationBarAnimation(contentOffset:CGPoint){
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        
        let minToScroll = 136.0 - (topPadding ?? 0)
        print(contentOffset.y)
        if contentOffset.y > 0 && contentOffset.y < minToScroll {
            imageTopConstraint.constant = -contentOffset.y
            animationBlackView.alpha = contentOffset.y / 100
        } else if contentOffset.y > 0 {
            imageTopConstraint.constant = -minToScroll
            animationBlackView.alpha = 1.0
        } else if contentOffset.y < 0 {
            imageTopConstraint.constant = 0.0
            animationBlackView.alpha = 0.0
        }
        self.view.setNeedsLayout()
    }
}
