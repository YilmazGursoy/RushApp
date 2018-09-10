//
//  LobbyMainVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 9.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

let kChangeLobbyTypeNotificationKey = "changeLobbyTypeNotificationKey"

class LobbyMainVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func changeLobbyViewTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            NotificationCenter.default.post(name: Notification.Name(kChangeLobbyTypeNotificationKey), object: 0)
        } else {
            sender.isSelected = true
            NotificationCenter.default.post(name: Notification.Name(kChangeLobbyTypeNotificationKey), object: 1)
        }
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        let filterNav = FilterVC.createFromStoryboard()
        filterNav.navigationTitle = "Filter"
        let navController = FilterNavigationController(rootViewController: filterNav)
        navController.modalPresentationStyle = .custom
        let halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: navController)
        navController.setNavigationBarHidden(true, animated: false)
        navController.transitioningDelegate = halfModalTransitioningDelegate
        
        self.present(navController, animated:true, completion: nil)
    }
    @IBAction func sortTapped(_ sender: Any) {
        let filterNav = FilterVC.createFromStoryboard()
        filterNav.navigationTitle = "Sort"
        let navController = FilterNavigationController(rootViewController: filterNav)
        navController.modalPresentationStyle = .custom
        let halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: navController)
        navController.setNavigationBarHidden(true, animated: false)
        navController.transitioningDelegate = halfModalTransitioningDelegate
        
        self.present(navController, animated:true, completion: nil)
    }
}
