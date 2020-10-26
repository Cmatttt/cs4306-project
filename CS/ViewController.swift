//
//  ViewController.swift
//  CS
//
//  Created by Christian Matthews on 10/3/20.
//  Copyright © 2020 Cmatt. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var mapView:  MKMapView!
    
     var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        //**API Key for Google Maps IOS***
        GMSServices.provideAPIKey("AIzaSyAHoGDSUMzWqXIIayfIbB6TGPafBQsqa-E")
        
        // request access to location
        manager.requestWhenInUseAuthorization()
        
        var currentLoc: CLLocation!
        
        // If access was granted
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            // create location var
            currentLoc = manager.location

            // set lat and long of location var
            let cords = CLLocationCoordinate2D(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)

            // set span var
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

            // set region var
            let reg = MKCoordinateRegion(center: cords, span: span)

            // focus on users location
            mapView.setRegion(reg, animated: true)
        }
        
        

//        //Move camera to fixed location
//        let camera = GMSCameraPosition.camera(this.myLat, longitude: 77.4977, zoom: 17.0)
//        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//        self.view.addSubview(mapView)
//
//        //Creates a marker tp fixed location.
//
//        let marker = GMSMarker()
//
//        marker.position = CLLocationCoordinate2D(latitude: 27.2046, longitude: 77.4977)
//
//        marker.title = "MCS"
//
//        marker.snippet = "Angelo State University"
//        marker.map = mapView
              
    }


}

