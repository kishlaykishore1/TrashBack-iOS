//
//  MapVC.swift
//  TrashBack
//
//  Created by angrz singh on 30/01/22.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cellView: UIControl!
    
    // MARK: - Variables
    var strTitle = ""
    var lat = 43.7102
    var long = 7.2620
    var isfromFinal = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cellView.isHidden = true
        setupMap()
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = strTitle.localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    fileprivate func setupMap() {
      let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 12.0)
      self.mapView.camera = camera
      self.mapView.clear()
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
      marker.title = ""
      marker.icon = #imageLiteral(resourceName: "ic_MapMarker1")
      marker.map = mapView
    }
    
    // MARK: - Button Actions
    override func backBtnTapAction() {
        setVibration()
        if isfromFinal {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func viewTap_Action(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "FinalizePickupVC") as! FinalizePickupVC
        aboutVC.receivedString = "Validé"
        aboutVC.isFromMap = true
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
}

// MARK: - Google Map Delegates Function
extension MapVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if !isfromFinal {
            UIView.animate(withDuration: 0.1) {
                self.cellView.isHidden = false
            }
        }
        return true
    }
    
    
}
