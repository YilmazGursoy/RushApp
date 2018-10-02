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
        let rushAlert = RushAlertController.createFromStoryboard()
        rushAlert.createOneButtonAlert(title: title, description: description, buttonTitle: "Tamam") {
            doneButtonTapped()
        }
        
        if self.tabBarController != nil {
            DispatchQueue.main.async {
                self.tabBarController?.present(rushAlert, animated: false, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                self.present(rushAlert, animated: false, completion: nil)
            }
        }
    }
    
    func showError(title:String, description:String, doneButtonTapped:@escaping()->Void) {
        
        let rushAlert = RushAlertController.createFromStoryboard()
        rushAlert.createOneButtonAlert(title: title, description: description, buttonTitle: "Tamam") {
            doneButtonTapped()
        }
        if self.tabBarController != nil {
            DispatchQueue.main.async {
                self.tabBarController?.present(rushAlert, animated: false, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                self.present(rushAlert, animated: false, completion: nil)
            }
        }
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
        self.showError(title: "Hata!", description: message) {}
    }
}

extension BaseVC: AWSPopupManagerProtocol {
    func showSuccess(message: String) {
        DispatchQueue.main.async {
            self.showSuccess(title: "Başarılı!", description: message) {
                
            }
        }
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            self.showError(title: "Hata!", description: message) {
                
            }
        }
    }
}
