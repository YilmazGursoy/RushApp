//
//  FilterCellType1.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FilterCellType1: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBackView: GradientView!
    @IBOutlet weak var iconLittleCheck: UIImageView!
    var currentIndex:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func arrangeCell(title:String, index:Int) {
        self.currentIndex = index
        if Rush.shared.ages[index] == true {
            checkSelected()
        } else {
            unselected()
        }
    }
    
    @IBAction func checkTapped(_ sender: UIButton) {
        if Rush.shared.ages[currentIndex] == true {
            Rush.shared.ages[currentIndex] = false
            unselected()
        } else {
            Rush.shared.ages[currentIndex] = true
            checkSelected()
        }
    }
    
    private func checkSelected(){
        self.iconLittleCheck.isHidden = false
        self.checkBackView.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.8352941176, blue: 0.3882352941, alpha: 1)
        self.checkBackView.borderWidth = 0.0
    }
    
    private func unselected(){
        self.iconLittleCheck.isHidden = true
        self.checkBackView.backgroundColor = .white
        self.checkBackView.borderWidth = 0.5
    }
    
}
