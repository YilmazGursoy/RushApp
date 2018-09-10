//
//  FilterCellType2.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class FilterCellType2: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
    }
    
    func arrangeCell(title:String, isSelected:Bool, selectedText:String?) {
        self.titleLabel.text = title
        if isSelected == true {
            self.selectedLabel.isHidden = false
        } else {
            self.selectedLabel.isHidden = true
        }
        
        if let purpleText = selectedText {
            self.selectedLabel.text = purpleText
        }
    }
    
}
