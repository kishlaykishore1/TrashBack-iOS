//
//  LocationPermissionVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 22/01/22.
//

import UIKit
import CoreLocation

class LocationPermissionVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var lblSubHeading: UILabel!
    
    // MARK: - Variables
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblSubHeading.text = "Nous avons besoin de la localisation pour\nsauvegarder ta position lorsque ta ajoute de\nnouveaux ramassages."
        DispatchQueue.main.async {
            self.btnLocation.layer.cornerRadius = self.btnLocation.frame.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        setBackButton(tintColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1), isImage: true, #imageLiteral(resourceName: "downArrow"))
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: false)
        setRightButton(isImage: false)
    }
    
    override func backBtnTapAction() {
        setVibration()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func rightBtnTapAction(sender: UIButton) {
        setVibration()
        if LocationManager.shared().isLocationEnabled() {
            moveToNext()
        } else {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @objc func moveToNext() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
               // (UIApplication.shared.delegate as? AppDelegate)?.isUserLogin(true)
            }
        }
    }
    
    @IBAction func action_AllowLocation(_ sender: UIButton) {
        setVibration()
        if LocationManager.shared().isLocationEnabled() {
            moveToNext()
        } else {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationPermissionVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined - hence ask for Permission")
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            LocationManager.shared().showLocationPermissionAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            moveToNext()
        @unknown default:
            LocationManager.shared().showLocationPermissionAlert()
        }
    }
}
