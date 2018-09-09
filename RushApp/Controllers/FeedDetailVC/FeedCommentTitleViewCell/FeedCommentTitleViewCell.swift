//
//  FeedCommentTitleViewCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 9.09.2018.
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


class FeedCommentTitleViewCell: UITableViewCell {

    @IBOutlet private weak var commentsChangeLabel: UILabel!
    @IBOutlet private weak var commentChangeIcon: UIImageView!
    
    private var buttonType:HideCommentButtonType!
    private var tappedCompletion:((HideCommentButtonType)->Void)!
    
    func arrangeCell(currentType:HideCommentButtonType,completion:@escaping ((HideCommentButtonType)->Void)) {
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
