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
import SwiftyJSON
import Alamofire


class ViewController: UIViewController {
    
    //Initialize map and label
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var nl: UILabel!
    
    
    private var placesClient: GMSPlacesClient!

    // CLLocationManager var
    let locman = CLLocationManager()
    
    var loo = CLLocationManager()
    
    var c: CLPlacemark?
    
    let call = SecondView()
    
    let idd = ""
    
    var globalid = ""
    //var yes: String
    var countyFinal = ""
    
    var countty = ""
    
    
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
        
        //let sv = storyboard?.instantiateViewController(identifier: "second") as! second

        let placeFields: GMSPlaceField = .all
        var theId: String
        
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
        
           // let comp = place.addressComponents?.count

            let placeeId = place.placeID!
            //heId.self = place.placeID!

            let apiUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeeId)&fields=address_components&key=AIzaSyBiLf_c57BUZ-WXsI164zQFb3B7Qcm1-eo"

            //print(apiUrl)

            //let urlObj = URL(string: apiUrl)

                                    
            let allPlaces = place.types
            
            //print("PLACEID = ", place.placeID)
            
            let allp = place.types?.joined(separator: ",")
            
            var singlePlace = ""
            
            //print(placeeId)


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


            strongSelf.nameLabel.text = singlePlace
            strongSelf.types.text = allp
            
            
            let f: GMSPlaceField = .addressComponents
            
            self?.placesClient.fetchPlace(fromPlaceID: placeeId, placeFields: f, sessionToken: nil, callback: {
                (place: GMSPlace?, error: Error?) in
                
                if let error = error {
                    print("An error occurred: \(error.localizedDescription)")
                    return
                  }
                
                  if let place = place {
                    
                    var county: String
                    
                    let listArray = place.addressComponents!
                    
                    let apiListCount = listArray.count
                    
                    let counter = 0...apiListCount - 1
                                
                    for count in counter{
                        if listArray[count].name.contains("County"){
                            county = listArray[count].name
                            //self?.performSegue(withIdentifier: "SecondView", sender: self)
                            //self?.present(sv, animated: true)
                            let vc = self?.storyboard?.instantiateViewController(identifier: "SecondView") as! SecondView
                            vc.modalPresentationStyle = .fullScreen
                            
                            var fixedCounty = county
                            var removeWord = " County"

                            if let range = county.range(of: removeWord) {
                                fixedCounty.removeSubrange(range)
                            }

                            vc.county = fixedCounty
                            vc.place = singlePlace
                            self?.present(vc, animated: true)

                        }
                    }
                  }
            })
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
