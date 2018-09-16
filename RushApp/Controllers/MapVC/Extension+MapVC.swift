//
//  Extension+MapVC.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 16.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension MapVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lobbies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cachedCell = lobbyCacher.object(forKey: NSString.init(string: "\(indexPath.row)")) {
//            print(indexPath.row)
//            return cachedCell
//        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LobbyCollectionCell", for: indexPath) as! LobbyCollectionCell
            cell.arrangeCell(lobby: self.lobbies[indexPath.row]) { () in
                let lobbyDetailVC = LobbyDetailVC.createFromStoryboard()
                lobbyDetailVC.currentLobby = self.lobbies[indexPath.row]
                self.navigationController?.pushVCMainThread(lobbyDetailVC)
            }
            lobbyCacher.setObject(cell, forKey: NSString.init(string: "\(indexPath.row)"))
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: Helper Methods
extension MapVC : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoordinate = mapView.centerCoordinate
        let location = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                self.centerLocationLabel.text = ""
                return
            }else if let _ = placemarks?.first?.country,
                let city = placemarks?.first?.locality {
                self.centerLocationLabel.text = city
            }
            else {
                self.centerLocationLabel.text = ""
            }
        })
    }
}


