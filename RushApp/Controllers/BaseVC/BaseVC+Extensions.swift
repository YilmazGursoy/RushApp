//
//  BaseVC+Extensions.swift
//  RushApp
//
//  Created by Most Wanted on 1.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import PMAlertController

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
    
    func showSuccess(title:String, description:String, doneButtonTapped:@escaping()->Void) {
        let alertVC = PMAlertController(title: title, description: description, image: UIImage(named: "success"), style: .alert)
        alertVC.gravityDismissAnimation = false
        alertVC.addAction(PMAlertAction(title: "Okay", style: .default, action: { () in
            doneButtonTapped()
        }))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showError(title:String, description:String, doneButtonTapped:@escaping()->Void) {
        let alertVC = PMAlertController(title: title, description: description, image: UIImage(named: "error"), style: .alert)
        alertVC.gravityDismissAnimation = false
        alertVC.addAction(PMAlertAction(title: "Okay", style: .default, action: { () in
            doneButtonTapped()
        }))
        
        self.present(alertVC, animated: true, completion: nil)
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
    
    func errorMessage(message: String) {
        self.showError(title: "", description: message) {}
    }
}

extension BaseVC: AWSPopupManagerProtocol {
    func showSuccess(message: String) {
        DispatchQueue.main.async {
            self.showSuccess(title: "Success", description: message) {
                
            }
        }
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            self.showError(title: "Failed", description: message) {
                
            }
        }
    }
}
