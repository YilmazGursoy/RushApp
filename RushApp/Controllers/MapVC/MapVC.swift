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
    
    var lobbyCacher = NSCache<NSString, UICollectionViewCell>()
    
    var selectingIndex:Int!
    
    var lobbies:[Lobby]! {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
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
        self.lobbyCacher = NSCache<NSString, UICollectionViewCell>()
        self.checkLocalization { (status) in
            if status == CLAuthorizationStatus.authorizedWhenInUse {
                self.getLobbyRequest()
            }
        }
    }
    
    private func setupUI(){
        mapView.showsCompass = false
        mapView.delegate = self
        collectionView.register(UINib.init(nibName: "LobbyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "LobbyCollectionCell")
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

