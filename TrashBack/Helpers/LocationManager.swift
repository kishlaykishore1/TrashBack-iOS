//
//  LocationPermissionVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 22/01/22.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func tracingLocation(currentLocation: CLLocation)
    func tracingHeading(currentHeading: CLHeading)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    //MARK:- Class Initializer
    var locationManager: CLLocationManager?
    var currentLocation = CLLocation(latitude: kCLLocationCoordinate2DInvalid.latitude, longitude: kCLLocationCoordinate2DInvalid.longitude)
    
    var currentLatitude = kCLLocationCoordinate2DInvalid.latitude
    var currentLongitude = kCLLocationCoordinate2DInvalid.longitude
    var currentAddress = ""
    var currentSubAddress = ""
    weak var delegate: LocationManagerDelegate?
    
    private static let sharedInstance: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    class func shared() -> LocationManager {
        return sharedInstance
    }
    
    private override init() {
        super.init()
        self.locationManager = CLLocationManager()
        locationManager?.delegate = self
        guard let locationManagers = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManagers.requestAlwaysAuthorization()
            locationManagers.requestWhenInUseAuthorization()
        }
        
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.distanceFilter = 1000
        locationManagers.allowsBackgroundLocationUpdates = false
        locationManagers.delegate = self
        locationManagers.startUpdatingLocation()
        locationManagers.startUpdatingHeading()
        
#if os(iOS)
        locationManagers.pausesLocationUpdatesAutomatically = true
        if #available(iOS 11.0, *) {
            locationManagers.showsBackgroundLocationIndicator = true
        }
#endif
    }
    
    //MARK:- Location Manager Methods
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.currentLocation = location
        self.currentLatitude = location.coordinate.latitude
        self.currentLongitude = location.coordinate.longitude
        if location.horizontalAccuracy > 0 {
            updateLocation(currentLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        updateHeading(currentHeading: newHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled() {
            switch status {
            case .notDetermined:
                locationManager?.requestAlwaysAuthorization()
                locationManager?.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse:
                locationManager?.allowsBackgroundLocationUpdates = false
                locationManager?.startUpdatingLocation()
                locationManager?.startUpdatingHeading()
                break
            case .authorizedAlways:
                locationManager?.allowsBackgroundLocationUpdates = false
                locationManager?.startUpdatingLocation()
                locationManager?.startUpdatingHeading()
                break
            case .restricted, .denied:
                showLocationPermissionAlert()
                break
            default:
                break
            }
        } else {
            showLocationPermissionAlert()
        }
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    private func updateHeading(currentHeading: CLHeading) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingHeading(currentHeading: currentHeading)
    }
    
    //MARK:- Delegate Methods
    func startUpdatingLocation() {
        checkLocationPermissionStatus()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
#if os(iOS)
        self.locationManager?.startMonitoringSignificantLocationChanges()
#endif
    }
    
    //MARK:- Helper Methods
    func isLocationEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            case .notDetermined:
                return false
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }
    
    private func checkLocationPermissionStatus() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                showLocationPermissionAlert()
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager?.allowsBackgroundLocationUpdates = false
                self.locationManager?.startUpdatingLocation()
                self.locationManager?.startUpdatingHeading()
            case .notDetermined:
                locationManager?.requestAlwaysAuthorization()
                locationManager?.requestWhenInUseAuthorization()
            @unknown default:
                showLocationPermissionAlert()
            }
        } else {
            showLocationPermissionAlert()
        }
    }
    
    func showLocationPermissionAlert() {
#if os(iOS)
        let alertTitle = Constants.kAppDisplayName
        let alertMessage = "📍 Nous avons besoin de connaitre votre position pour vérifier la localisation de vos ramassages et de vos signalements."
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (error) in
            let url = URL(string: UIApplication.openSettingsURLString)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: { (error) in
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: Messages.txtCancel, style: .cancel, handler: nil))
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        
        getNav.present( alert, animated: true, completion: nil)
        
#endif
    }
}
