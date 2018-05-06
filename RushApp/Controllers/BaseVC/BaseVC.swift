//
//  BaseVC.swift
//  RushApp
//
//  Created by Most Wanted on 1.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AWSErrorManager.shared.delegate = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
