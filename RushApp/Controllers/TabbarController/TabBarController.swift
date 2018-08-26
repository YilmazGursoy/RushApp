//
//  TabBarController.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 24.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let homeVC = UIViewController()
        homeVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "homeIcon"), selectedImage: #imageLiteral(resourceName: "homeIcon"))
        
        
        let searchVC = UIViewController()
        searchVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "searchIcon"), selectedImage: #imageLiteral(resourceName: "searchIcon"))
        
        let playVC = UIViewController()
        playVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "playIcon"), selectedImage: #imageLiteral(resourceName: "playIcon"))
        
        let notificationVC = UIViewController()
        notificationVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "notificationIcon"), selectedImage: #imageLiteral(resourceName: "notificationIcon"))
        
        let profileVC = UIViewController()
        profileVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "profileIcon"), selectedImage: #imageLiteral(resourceName: "profileIcon"))
        
        
        
        viewControllers = [homeVC, searchVC, playVC, notificationVC, profileVC]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension TabBarController : UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
