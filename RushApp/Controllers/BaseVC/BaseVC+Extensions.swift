//
//  BaseVC+Extensions.swift
//  RushApp
//
//  Created by Most Wanted on 1.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

//MARK: Create from storyboard
extension BaseVC {
    class var storyboardName:String {
        return String(describing: self)
    }
    
    static func createFromStoryboard() -> Self{
        return createFromStoryboard(storyboardName: storyboardName)
    }
    
    static func createFromStoryboard<T: BaseVC>(storyboardName:String) -> T {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main).instantiateInitialViewController() as! T
    }
}

extension BaseVC : AWSErrorManagerProtocol {
    
    func pushViewController(pushViewController: UIViewController?) {
        if pushViewController != nil {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(pushViewController!, animated: true)
            }
        }
    }
    
    func forceOpenViewController(forceViwController: UIViewController?) {
        if forceViwController != nil {
            DispatchQueue.main.async {
                let navigationController = BaseNavigationController.createFromStoryboard()
                navigationController.viewControllers = [forceViwController!]
                UIApplication.shared.keyWindow?.rootViewController = navigationController
            }
        }
    }
}
