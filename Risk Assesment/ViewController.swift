//
//  ViewController.swift
//  Risk Assesment
//
//  Created by Christian Matthews on 11/8/20.
//  Copyright © 2020 Cmatt. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GooglePlaces
import UIKit

class ViewController: UIViewController {

    //@IBOutlet weak var mapView: MKMapView!
    
    //Initialize map and label
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var placesClient: GMSPlacesClient!

    // CLLocationManager var
    let locman = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        
        //Get best accuracy
        locman.desiredAccuracy = kCLLocationAccuracyBest // Can drain battery??
        //Request location access
        locman.delegate = self
        locman.requestWhenInUseAuthorization()
        //Keep updating location
        locman.startUpdatingLocation()
    }
    
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        //set feild to type
        let placeFields: GMSPlaceField = .types
            placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
              guard let strongSelf = self else {
                return
              }

              guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
              }

              guard let place = placeLikelihoods?.first?.place else {
                strongSelf.nameLabel.text = "No current place"
                //strongSelf.adressLabel.text = ""
                return
              }
                
                // Display type
                strongSelf.nameLabel.text = place.types?.last
              //strongSelf.adressLabel.text = place.formattedAddress
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        // Create span
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        
        // Create region
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: span)

        // Display region onto map
        map.setRegion(region, animated: true)
        map.showsUserLocation = true

    }
}
