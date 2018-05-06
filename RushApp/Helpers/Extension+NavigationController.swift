//
//  Extension+NavigationController.swift
//  RushApp
//
//  Created by Most Wanted on 6.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func presentWithMainThread(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.present(viewControllerToPresent, animated: flag, completion: completion)
            
        }
    }
    
    func pushViewControllerWithMainThread(_ viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.pushViewController(viewController, animated: animated)
        }
    }
    
    func pushVCMainThread(_ viewController:UIViewController) {
        DispatchQueue.main.async {
            self.pushViewController(viewController, animated: true)
        }
    }
    
    func presentVCMainThread(_ viewController:UIViewController) {
        DispatchQueue.main.async {
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
