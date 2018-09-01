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
        
        let homeVC = MapVC.createFromStoryboard()
        homeVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "homeIcon"), selectedImage: #imageLiteral(resourceName: "homeIconSelected"))
        homeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
        
//
//        let searchVC = UIViewController()
//        searchVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "searchIcon"), selectedImage: #imageLiteral(resourceName: "searchIcon"))
//        searchVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
        
        let playVC = UIViewController()
        playVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "playIcon"), selectedImage: #imageLiteral(resourceName: "playIconSelected"))
        playVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
        
//        let notificationVC = UIViewController()
//        notificationVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "notificationIcon"), selectedImage: #imageLiteral(resourceName: "notificationIconSelected"))
//        notificationVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
        
        let profileVC = ProfileVC.createFromStoryboard()
        profileVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "profileIcon"), selectedImage: #imageLiteral(resourceName: "profileIconSelected"))
        profileVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
        
        viewControllers = [homeVC, playVC, profileVC]
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
