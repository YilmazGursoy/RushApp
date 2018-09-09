//
//  LobbyMainPageController.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 10.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

enum LobbyPageType {
    case map
    case list
}

class LobbyMainPageController: UIPageViewController {
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [UIStoryboard(name: "MapVC", bundle: Bundle.main).instantiateViewController(withIdentifier:"MapVC"),
                UIStoryboard(name: "LobbyListVC", bundle: Bundle.main).instantiateViewController(withIdentifier:"LobbyListVC")]
    }()
    
    var currentIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = 0
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(kChangeLobbyTypeNotificationKey), object: nil)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(kChangeLobbyTypeNotificationKey), object: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        var direction:UIPageViewControllerNavigationDirection!
        
        if let object = notification.object as? Int {
            
            if object < currentIndex {
                direction = .reverse
            } else {
                direction = .forward
            }
            currentIndex = object
            
            if object == 0 {
                
                let currentViewController = orderedViewControllers[0]
                setViewControllers([currentViewController],
                                   direction: direction,
                                   animated: false,
                                   completion: nil)
            } else if object == 1 {
                let currentViewController = orderedViewControllers[1]
                setViewControllers([currentViewController],
                                   direction: direction,
                                   animated: false,
                                   completion: nil)
            }
        }
    }
    
}
