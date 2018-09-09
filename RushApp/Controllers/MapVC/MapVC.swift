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
        getLobbyRequest()
    }
    
    private func setupUI(){
        mapView.showsCompass = false
        mapView.delegate = self
        collectionView.register(UINib.init(nibName: "LobbyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "LobbyCollectionCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getLobbyRequest(){
        let request = LobbyRequest()
        SVProgressHUD.show()
        request.sendGameLobbyRequestWithoutParameters { (lobbies, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                self.showErrorMessage(message: "There is an error to fetching lobbies.")
            } else {
                var locations:[CLLocation] = []

                lobbies?.forEach({ (lobby) in
                    locations.append(CLLocation(latitude: lobby.latitude, longitude: lobby.longitude))
                })
                self.lobbies = lobbies
                DispatchQueue.main.async {
                    self.addAnnotations(coords: locations)
                }
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

//MARK: CollectionViewDelegate
extension MapVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lobbies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LobbyCollectionCell", for: indexPath) as! LobbyCollectionCell
        cell.arrangeCell(lobby: self.lobbies[indexPath.row]) { () in
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.selectingIndex = indexPath.row
            self.mapView.selectAnnotation(self.mapView.annotations[indexPath.row], animated: true)
        }
    }
}

//MARK: Helper Methods
extension MapVC : MKMapViewDelegate{
    private func addAnnotations(coords: [CLLocation]){
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
                                                      longitude: coord.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            mapView.addAnnotation(anno);
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "")
        view.image = #imageLiteral(resourceName: "annotationImageOff")
        view.isUserInteractionEnabled = false
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.centerMapOnLocation(CLLocation(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude), mapView: self.mapView)
        view.image = #imageLiteral(resourceName: "annotationImageOn")
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = #imageLiteral(resourceName: "annotationImageOff")
    }
}

