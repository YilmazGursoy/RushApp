//
//  ExtensionLocation+CreateLobby.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 12.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import CoreLocation

extension CreateLobbyVC {
    
    func checkLocation(){
        self.checkLocalization(completion: { (status) in
            if status == .notDetermined {
                let alert = RushAlertController.createFromStoryboard()
                alert.createAlert(title: "Lobby oluşturmak istiyor musun?", description: "Konumuna yakın bölgelerde istediğin gibi lobby kur", positiveTitle: "Konum Aç", negativeTitle: "Şimdi Değil", positiveButtonTapped: {
                    
                    self.locationManager.delegate = self
                    self.locationManager.requestWhenInUseAuthorization()
                    
                }) {
                    
                    self.pop()
                    
                }
                self.present(alert, animated: false, completion: nil)
            } else if status == .denied {
                let alert = RushAlertController.createFromStoryboard()
                alert.createAlert(title: "Hey!", description: "Maalesef ayarlardan konum servislerini açman gerek.", positiveTitle: "Tamam", negativeTitle: "Şimdi Değil", positiveButtonTapped: {
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
                    self.pop()
                }) {
                    self.pop()
                }
                self.present(alert, animated: false, completion: nil)
            } else if status == .authorizedWhenInUse {
                self.setupLocation()
            }
        })
    }
    
    
    func setupLocation(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        // Here you can check whether you have allowed the permission or not.
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorize.")
                let latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
                let longitude: CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
                let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
                self.currentLocation = location
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if error != nil {
                        return
                    }else if let _ = placemarks?.first?.country,
                        let city = placemarks?.first?.locality {
                        self.locationLabel.text = "\(city)"
                        self.currentLocationName = city
                    }
                    else {
                    }
                })
                break
                
            case .notDetermined:
                let alert = RushAlertController.createFromStoryboard()
                alert.createAlert(title: "Denem", description: "Deneme dneme", positiveTitle: "1", negativeTitle: "2", positiveButtonTapped: {
                    
                }) {
                    
                }
                self.present(alert, animated: false, completion: nil)
                break
                
            case .restricted:
                print("Restricted.")
                break
                
            case .denied:
                print("Denied.")
            }
        }
    }
}

extension CreateLobbyVC : CLLocationManagerDelegate {
    func checkLocalization(completion:@escaping (CLAuthorizationStatus)->Void) {
        switch(CLLocationManager.authorizationStatus())
        {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(.authorizedWhenInUse)
            
        case .notDetermined:
            completion(.notDetermined)
            
        case .restricted:
            completion(.restricted)
        default:
            completion(.denied)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            let alert = RushAlertController.createFromStoryboard()
            alert.createAlert(title: "Lobby oluşturmak istiyor musun?", description: "Konumuna yakın bölgelerde istediğin gibi lobby kur", positiveTitle: "Konum Aç", negativeTitle: "Şimdi Değil", positiveButtonTapped: {
                self.locationManager.requestWhenInUseAuthorization()
            }) {
                self.pop()
            }
            self.present(alert, animated: false, completion: nil)
        } else if status == .denied {
            let alert = RushAlertController.createFromStoryboard()
            alert.createAlert(title: "Hey!", description: "Maalesef ayarlardan konum servislerini açman gerek.", positiveTitle: "Tamam", negativeTitle: "Şimdi Değil", positiveButtonTapped: {
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
                self.pop()
            }) {
                self.pop()
            }
            self.present(alert, animated: false, completion: nil)
        } else if status == .authorizedWhenInUse {
            setupLocation()
        }
    }
    
}
