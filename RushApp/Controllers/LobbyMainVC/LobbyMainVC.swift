//
//  LobbyMainVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 9.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import CoreLocation

let kChangeLobbyTypeNotificationKey = "changeLobbyTypeNotificationKey"
let kChangeLocation = "changeLobbyLocationKey"
let kUpdateFilter = "updateFilterStatements"

class LobbyMainVC: BaseVC {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var filterNumberBackView: GradientView!
    @IBOutlet weak var filterNumberLabel: UILabel!
    
    var currentLocation:CLLocation?
    var currentLocationName:String?
    var locationManager = CLLocationManager()
    var locationManagerStatus:Bool! = false {
        didSet {
            if locationManagerStatus {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: NSNotification.Name(rawValue: kChangeLocation), object: nil)
        DispatchQueue.main.async {
            self.checkLocation()
        }
        setupUI()
    }
    
    private func setupUI(){
        var counter = 0
        if Rush.shared.filterGame != nil {
            counter += 1
        }
        
        if Rush.shared.filterPlatform != .empty {
            counter += 1
        }
        if counter != 0 {
            self.filterNumberBackView.isHidden = false
            self.filterNumberLabel.text = "\(counter)"
        } else {
            self.filterNumberBackView.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if let object = notification.object as? String {
            self.locationNameLabel.text = object
        }
    }
    
    @objc func locationChange(newLocationName:String) {
        print(newLocationName)        
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
        filterNav.navigationTitle = "Filtrele"
        filterNav.applyTapped = {
            self.setupUI()
            NotificationCenter.default.post(name: NSNotification.Name.init(kUpdateFilter), object: nil)
        }
        let navController = FilterNavigationController(rootViewController: filterNav)
        navController.modalPresentationStyle = .custom
        let halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: navController)
        navController.setNavigationBarHidden(true, animated: false)
        navController.transitioningDelegate = halfModalTransitioningDelegate
        self.present(navController, animated:true, completion: nil)
    }
    @IBAction func sortTapped(_ sender: Any) {
        let filterNav = SortVC.createFromStoryboard()
        
        filterNav.applyTapped = {
            self.setupUI()
            NotificationCenter.default.post(name: NSNotification.Name.init(kUpdateFilter), object: nil)
        }
        
        let navController = FilterNavigationController(rootViewController: filterNav)
        navController.modalPresentationStyle = .custom
        let halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: navController)
        navController.setNavigationBarHidden(true, animated: false)
        navController.transitioningDelegate = halfModalTransitioningDelegate
        self.present(navController, animated:true, completion: nil)
    }
}
