//
//  ViewController.swift
//  CS
//
//  Created by Christian Matthews on 10/7/20.
//  Copyright © 2020 Cmatt. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       //**API Key for Google Maps IOS***
              GMSServices.provideAPIKey("AIzaSyAHoGDSUMzWqXIIayfIbB6TGPafBQsqa-E")
              
              // Move camera to fixed location
              let camera = GMSCameraPosition.camera(withLatitude: 31.440194, longitude: -100.461086, zoom: 17.0)
              let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
              self.view.addSubview(mapView)

              // Creates a marker tp fixed location.
              let marker = GMSMarker()
              marker.position = CLLocationCoordinate2D(latitude: 31.440194, longitude: -100.461086)
              marker.title = "MCS"
              marker.snippet = "Angelo State University"
              marker.map = mapView
    }


}

