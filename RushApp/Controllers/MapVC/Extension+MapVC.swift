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
                
                let lobby = self.lobbies[indexPath.row]
                if lobby.sender.id.elementsEqual(Rush.shared.currentUser.userId) {
                    let lobbyDetailVC = LobbyDetailVC.createFromStoryboard()
                    lobbyDetailVC.currentLobby = lobby
                    self.navigationController?.pushVCMainThread(lobbyDetailVC)
                } else {
                    let lobbyTheirs = LobbyDetailVCTheirs.createFromStoryboard()
                    lobbyTheirs.currentLobby = lobby
                    self.navigationController?.pushVCMainThread(lobbyTheirs)
                }
                
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
                NotificationCenter.default.post(name: NSNotification.Name.init(kChangeLocation), object: "")
                return
            }else if let area = placemarks?.first?.administrativeArea {
                UIView.animate(withDuration: 0.1, animations: {
                    self.centerBackView.alpha = 1.0
                })
                
                NotificationCenter.default.post(name: NSNotification.Name.init(kChangeLocation), object: area)
                
            } else {
                UIView.animate(withDuration: 0.1, animations: {
                    self.centerBackView.alpha = 1.0
                })
                NotificationCenter.default.post(name: NSNotification.Name.init(kChangeLocation), object: "")
            }
        })
    }
}


