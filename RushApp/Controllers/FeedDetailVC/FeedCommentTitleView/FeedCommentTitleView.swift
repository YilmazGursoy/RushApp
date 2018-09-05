
//
//  FeedCommentTitleView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 5.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

enum HideCommentButtonType {
    case hidden
    case show
}

extension HideCommentButtonType {
    func getCurrentTypeTitle() -> String{
        if self == .hidden {
            return "Show Comments"
        } else {
            return "Hide Comments"
        }
    }
    
    func getCurrentTypeImage() -> UIImage {
        if self == .show {
            return #imageLiteral(resourceName: "iconUp")
        } else {
            return #imageLiteral(resourceName: "iconDown")
        }
    }
}

class FeedCommentTitleView: UIView {
    @IBOutlet private weak var commentsChangeLabel: UILabel!
    @IBOutlet private weak var commentChangeIcon: UIImageView!
    
    private var buttonType:HideCommentButtonType!
    private var tappedCompletion:((HideCommentButtonType)->Void)!
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func createTitleView(currentType:HideCommentButtonType,completion:@escaping ((HideCommentButtonType)->Void)) {
        buttonType = currentType
        self.commentsChangeLabel.text = buttonType.getCurrentTypeTitle()
        self.commentChangeIcon.image = buttonType.getCurrentTypeImage()
        tappedCompletion = completion
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        if buttonType == .hidden {
            buttonType = .show
            tappedCompletion(buttonType)
        } else {
            buttonType = .hidden
            tappedCompletion(buttonType)
        }
        self.commentsChangeLabel.text = buttonType.getCurrentTypeTitle()
        self.commentChangeIcon.image = buttonType.getCurrentTypeImage()
    }
    

}
