//
//  FriendSelectionCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 8.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FriendSelectionCell: UITableViewCell {

    @IBOutlet weak var backHighlightView: UIView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAddImageView: UIImageView!
    @IBOutlet weak var userAddBackGradientView: GradientView!
    
    var currentIndex:Int!
    var tapped:((Int,Bool)->Void)!
    var isSendingButtonSelected:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //TODO: Make friends to object
    func arrangeCell(index:Int, friend:String, isSelected:Bool, sendingRequestTapped:@escaping (Int,Bool)->Void) {
        self.currentIndex = index
        self.isSendingButtonSelected = isSelected
        self.tapped = sendingRequestTapped
        if isSelected {
            self.selectedConfigure()
        } else {
            self.unselectedConfigure()
        }
    }
    
    
    @IBAction func addTapped(_ sender: UIButton) {
        self.isSendingButtonSelected = !self.isSendingButtonSelected
        if self.isSendingButtonSelected {
            selectedConfigure()
        } else {
            unselectedConfigure()
        }
        self.tapped(self.currentIndex, self.isSendingButtonSelected)
    }
    
    private func selectedConfigure(){
        UIView.animate(withDuration: 0.2) {
            self.userAddBackGradientView.borderWidth = 0
            self.userAddImageView.image = #imageLiteral(resourceName: "checkIconGreen")
            self.userAddBackGradientView.backgroundColor = #colorLiteral(red: 0, green: 0.8470588235, blue: 0.06274509804, alpha: 1)
        }
    }
    
    private func unselectedConfigure(){
        UIView.animate(withDuration: 0.2) {
            self.userAddBackGradientView.borderWidth = 1.0
            self.userAddBackGradientView.backgroundColor = .white
            self.userAddImageView.image = #imageLiteral(resourceName: "userAddIcon")
        }
    }
}
