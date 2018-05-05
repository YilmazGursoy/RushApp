//
//  FeedVC.swift
//  RushApp
//
//  Created by Most Wanted on 4.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit


class FeedVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    //MARK: IBActions
    
    
    @IBAction func requestTapped(_ sender: UIButton) {
        DummyRequest().sendDummyRequest(completionBlock: { (result, error) in
            
            
            
        })
    }
    
}
