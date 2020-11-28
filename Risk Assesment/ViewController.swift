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
    
    //Initialize map and label and button
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var btn1: UIButton!
    
    
    private var placesClient: GMSPlacesClient!

    //Global variables
    let locman = CLLocationManager()
    var loo = CLLocationManager()
    var c: CLPlacemark?
    let call = SecondView()
    let idd = ""
    var globalid = ""
    var countyFinal = ""
    var countty = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize GMSPlacesClient
        placesClient = GMSPlacesClient.shared()
        //Set button radius to have rounded corners
        btn1.layer.cornerRadius = 40
        btn1.backgroundColor = UIColor.gray
        btn1.setTitleColor(UIColor.black, for: .normal)
        //Get best accuracy
        locman.desiredAccuracy = kCLLocationAccuracyBest // Can drain battery??
        //Request location access
        locman.delegate = self
        locman.requestWhenInUseAuthorization()
        //Keep updating location
        locman.startUpdatingLocation()
    }
    
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        //var for place feilds
        let placeFields: GMSPlaceField = .all
        //google function to find current place
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
          guard let strongSelf = self else {
            return
          }
            
          guard error == nil else {
            print("Current place error: \(error?.localizedDescription ?? "")")
            return
          }
        

          guard let place = placeLikelihoods?.first?.place else {
            return
          }
            //var to get placeID
            let placeeId = place.placeID!
            //var with link to the api
            let apiUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeeId)&fields=address_components&key=AIzaSyBiLf_c57BUZ-WXsI164zQFb3B7Qcm1-eo"
            //var to get place types
            let allPlaces = place.types
            // var to sperate each type with a ","
            let allp = place.types?.joined(separator: ",")
            print(apiUrl)
            //empty var for sinngle place
            var singlePlace = ""
            
            //unwrap optional of all places
            if let unwrapped = allPlaces {
                
                //var to seperatae by ,
                let p = unwrapped.joined(separator: ",")
                //var to create an array of places
                let pArray = p.components(separatedBy: ",")
                
                //find out what type of place is in array and set to singleplace
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
                } else if pArray.contains("health"){
                    singlePlace = "hospital"
                }else if pArray.contains("establishment"){
                    singlePlace = "establishment"
                } else if pArray.contains("museum"){
                    singlePlace = "museum"
                }
            } else {
                print("Missing name.")
            }

            //var to get adress componets
            let f: GMSPlaceField = .addressComponents
            
            //function to get adress components
            self?.placesClient.fetchPlace(fromPlaceID: placeeId, placeFields: f, sessionToken: nil, callback: {
                (place: GMSPlace?, error: Error?) in
                
                if let error = error {
                    print("An error occurred: \(error.localizedDescription)")
                    return
                  }
                
                  if let place = place {
                    //empty var for county
                    var county: String
                    //create array of adress components
                    let listArray = place.addressComponents!
                    //get size of array
                    let apiListCount = listArray.count
                    //create counter to go from 0 to size of array - 1
                    let counter = 0...apiListCount - 1
                    
                    // loop through array
                    for count in counter{
                        //whichever element in array contains county
                        if listArray[count].name.contains("County"){
                            //then set county to variable
                            county = listArray[count].name
                            //create storyboard for second view
                            let vc = self?.storyboard?.instantiateViewController(identifier: "SecondView") as! SecondView
                            vc.modalPresentationStyle = .popover
                            
                            //vars for fixing county to onl yhave county name
                            var fixedCounty = county
                            var removeWord = " County"
                            
                            //remove the work county from string *needed to be formatted like this for later*
                            if let range = county.range(of: removeWord) {
                                fixedCounty.removeSubrange(range)
                            }
                            
                            //set vars of second view
                            vc.county = fixedCounty
                            vc.place = singlePlace
                            //display second view
                            self?.present(vc, animated: true)
                        }
                    }
                  }
            })
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

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

