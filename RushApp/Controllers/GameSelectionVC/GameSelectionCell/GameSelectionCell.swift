//
//  GameSelectionCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 28.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

private let activeImage = #imageLiteral(resourceName: "selectingIcon")
private let passiveImage = #imageLiteral(resourceName: "plusIcon")


class GameSelectionCell: UITableViewCell {
    
    private var isActive:Bool!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var gradientBackView: GradientView!
    var changeActiveHandler:((Bool,Int)->Void)?
    var index:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func arrangeCell(imageName:String, title:String, index:Int, isActive:Bool) {
        self.isActive = isActive
        self.index = index
        self.gameNameLabel.text = title
        setupUI()
    }
    
    @IBAction func addGameTapped(_ sender: UIButton) {
        if isActive {
            isActive = false
            self.selectionImageView.image = passiveImage
            self.gradientBackView.backgroundColor = .clear
            self.gameNameLabel.textColor = .white
        } else {
            isActive = true
            self.selectionImageView.image = activeImage
            self.gradientBackView.backgroundColor = .white
            self.gameNameLabel.textColor = .black
        }
        self.changeActiveHandler!(isActive,self.index)
    }
    
    private func setupUI(){
        if isActive {
            self.selectionImageView.image = activeImage
            self.gradientBackView.backgroundColor = .white
            self.gameNameLabel.textColor = .black
        } else {
            self.selectionImageView.image = passiveImage
            self.gradientBackView.backgroundColor = .clear
            self.gameNameLabel.textColor = .white
        }
    }
    
}
