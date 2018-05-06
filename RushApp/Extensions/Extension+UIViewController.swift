//
//  Extension+UIViewController.swift
//  RushApp
//
//  Created by Most Wanted on 6.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showInfoAlert(withTitle title:String, andMessage message:String) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { (action) in
                
            }))
            
            self.present(alertController, animated: true) {
                
            }
        }
        
    }
    
}
