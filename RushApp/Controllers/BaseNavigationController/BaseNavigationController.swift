//
//  BaseNavigationController.swift
//  RushApp
//
//  Created by Most Wanted on 7.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseNavigationController {
    class var storyboardName:String {
        return String(describing: self)
    }
    
    static func createFromStoryboard() -> Self{
        return createFromStoryboard(storyboardName: storyboardName)
    }
    
    static func createFromStoryboard<T: BaseNavigationController>(storyboardName:String) -> T {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateInitialViewController() as! T
    }
}
