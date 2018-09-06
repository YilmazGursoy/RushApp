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
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        getLobbyRequest()
    }
    
    private func setupUI(){
        mapView.showsCompass = false
        mapView.camera.altitude *= 0.25
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
}

extension MapVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lobbies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LobbyCollectionCell", for: indexPath) as! LobbyCollectionCell
        cell.arrangeCell(lobby: self.lobbies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.selectingIndex = indexPath.row
            self.mapView.setCenter(CLLocationCoordinate2D.init(latitude: self.lobbies[indexPath.row].latitude, longitude: self.lobbies[indexPath.row].longitude), animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 25)
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
        
        if selectingIndex != nil {
            if annotation.isEqual(self.mapView.annotations[selectingIndex]) {
                view.image = #imageLiteral(resourceName: "annotationImageOn")
            } else {
                view.image = #imageLiteral(resourceName: "annotationImageOff")
            }
        } else {
            view.image = #imageLiteral(resourceName: "annotationImageOff")
        }
        return view
    }
}

