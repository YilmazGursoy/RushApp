//
//  MessageCell.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 8.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageTextField: UITextField!
    var sendTappedButton: ((String)->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func arrange(sendTapped:@escaping (String)->Void){
        self.sendTappedButton = sendTapped
    }
    
    
    @IBAction func sendTapped(_ sender: Any) {
        let trimmedString = messageTextField.text!.trimmingCharacters(in: .whitespaces)
        if !trimmedString.isEmpty {
            self.sendTappedButton(messageTextField.text!)
            messageTextField.text = ""
        }
    }
}
