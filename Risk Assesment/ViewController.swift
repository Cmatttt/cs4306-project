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
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var btn1: UIButton!
    
    
    private var placesClient: GMSPlacesClient!

    // CLLocationManager var
    let locman = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
        
        btn1.layer.cornerRadius = 6
        
        //Get best accuracy
        locman.desiredAccuracy = kCLLocationAccuracyBest // Can drain battery??
        //Request location access
        locman.delegate = self
        locman.requestWhenInUseAuthorization()
        //Keep updating location
        locman.startUpdatingLocation()
    }
    
    //let county = locale.regionCode

    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        //let locale = Locale.current
        //let county = locale.regionCode
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
                return
              }
                

                let allPlaces = place.types
                
                let allp = place.types?.joined(separator: ",")
                
                print(allPlaces)
                
                
                var singlePlace = ""
                
                if let unwrapped = allPlaces {
                    let p = unwrapped.joined(separator: ",")
                    
                    let pArray = p.components(separatedBy: ",")
                    
                    //print(type(of: pArray))

                    if pArray.contains("university"){
                        singlePlace = "university"
                    } else if pArray.contains("gas_station"){
                        singlePlace = "gas station"
                    } else if pArray.contains("restaurant"){
                        singlePlace = "restaurant"
                    } else if pArray.contains("car_dealer"){
                        singlePlace = "dealership"
                    } else if pArray.contains("lodging"){
                        singlePlace = "hotel"
                    } else if pArray.contains("hospital"){
                        singlePlace = "hospital"
                    } else if pArray.contains("gym"){
                        singlePlace = "gym"
                    } else if pArray.contains("airport"){
                        singlePlace = "airport"
                    } else if pArray.contains("bank"){
                        singlePlace = "bank"
                    } else if pArray.contains("church"){
                        singlePlace = "church"
                    } else if pArray.contains("doctor"){
                        singlePlace = "doctor"
                    } else if pArray.contains("stadium"){
                        singlePlace = "stadium"
                    } else if pArray.contains("supermarket"){
                        singlePlace = "supermarket"
                    } else if pArray.contains("store"){
                        singlePlace = "store"
                    } else if pArray.contains("establishment"){
                        singlePlace = "establishment"
                    } else if pArray.contains("museum"){
                        singlePlace = "museum"
                    }

                    
                    
                } else {
                    print("Missing name.")
                }
                
                print(singlePlace)
                
                strongSelf.nameLabel.text = singlePlace
                strongSelf.types.text = allp
                
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
