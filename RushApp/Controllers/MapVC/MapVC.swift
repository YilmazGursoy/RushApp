//
//  MapVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class MapVC: BaseVC {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var centerLocationLabel: UILabel!
    @IBOutlet weak var collectionViewBackView: UIView!
    @IBOutlet weak var centerBackView: GradientView!
    
    var lobbyCacher = NSCache<NSString, UICollectionViewCell>()
    
    var selectingIndex:Int!
    
    var lobbies:[Lobby]! {
        didSet {
            var filterLobbies = [Lobby]()
            if Rush.shared.filterGame != nil {
                filterLobbies = lobbies.filter{$0.game.id == Rush.shared.filterGame?.id}
            } else {
                filterLobbies = lobbies
            }
            var lastLobbies = [Lobby]()
            if Rush.shared.filterPlatform != .empty {
                lastLobbies = filterLobbies.filter{$0.platform == Rush.shared.filterPlatform}
            } else {
                lastLobbies = filterLobbies
            }
            if Rush.shared.sortType != nil {
                if Rush.shared.sortType! == .date {
                    lastLobbies = lastLobbies.sorted{$0.date > $1.date}
                } else if Rush.shared.sortType == .popular {
                    lastLobbies = lastLobbies.sorted{$0.numberOfNeededUser < $1.numberOfNeededUser}
                }
            }
            
            filteredLobbies = lastLobbies
        }
    }
    
    var filteredLobbies:[Lobby]! {
        didSet{
            if filteredLobbies.count > 0 {
                DispatchQueue.main.async {
                    self.collectionViewBackView.isHidden = false
                    self.collectionView.delegate = self
                    self.collectionView.dataSource = self
                    self.collectionView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.collectionViewBackView.isHidden = true
                }
            }
        }
    }
    
    //MARK: AppLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNotifications()
        self.lobbyCacher = NSCache<NSString, UICollectionViewCell>()
        self.sendLocationLobbyRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateFilters(notification:)), name: NSNotification.Name(rawValue: kUpdateFilter), object: nil)
    }
    
    @objc private func updateFilters(notification:Notification) {
        self.sendLocationLobbyRequest()
    }
    
    
    private func setupUI(){
        mapView.showsCompass = false
        mapView.delegate = self
        collectionView.register(UINib.init(nibName: "LobbyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "LobbyCollectionCell")
    }
    
    func sendLocationLobbyRequest(){
        self.checkLocalization { (status) in
            if status == CLAuthorizationStatus.authorizedWhenInUse {
                self.getLobbyRequest()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func getLobbyRequest(){
        SVProgressHUD.show()
        let request = GetNearestLobbiesRequest()
        request.sendLobbyRequest(longitude: mapView.centerCoordinate.longitude, latitude: mapView.centerCoordinate.latitude, radius: mapView.currentRadius(), successCompletion: { (lobbies) in
            SVProgressHUD.dismiss()
            self.lobbyCacher = NSCache<NSString, UICollectionViewCell>()
            self.lobbies = lobbies
            DispatchQueue.main.async {
                self.collectionViewBackView.isUserInteractionEnabled = true
                self.collectionView.reloadData()
            }
        }) {
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.lobbyCacher = NSCache<NSString, UICollectionViewCell>()
                self.lobbies = []
                self.collectionViewBackView.isUserInteractionEnabled = false
                self.collectionView.reloadData()
                self.showErrorMessage(message: "Ne yazık ki yakınlarda bir Lobi yok :(")
            }
        }
    }
    
    @IBAction func searchHereButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.centerBackView.alpha = 0.0
            self.sendLocationLobbyRequest()
        }
    }
    //MARK: Actions
    @IBAction func filterButtonTapped(_ sender: UIButton) {
    }
    
    override func viewDidLayoutSubviews() {
        self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 100000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 1.4, regionRadius * 1.4)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.reloadInputViews()
    }
}

