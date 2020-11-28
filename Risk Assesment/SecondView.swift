//
//  SecondView.swift
//  Risk Assesment
//
//  Created by cmatt on 11/22/20.
//  Copyright © 2020 Cmatt. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SecondView: UIViewController {
    
    //Firebase var
    let database = Database.database().reference()
    //vars used
    var percentage: Double = 0.0
    var county: String = ""
    var place: String = ""
    var pulseLayer: CAShapeLayer!

    //initializing labels and buttons
    @IBOutlet var SecondView: UIView!
    @IBOutlet var lol: UILabel!
    @IBOutlet weak var riskkResult: UILabel!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemBackground
        super.viewDidLoad()
        //contact firebasedatabase to read data in correct county
        database.child("\(county)").observeSingleEvent(of: .value, with: { snapshot in
            
            //get all the data
            let value = snapshot.value as? NSDictionary
            //get opnly the calulated percentage
            let perc = value!["percentage"] as! Double
            //set to percentage var
            self.percentage = perc
            //once percentage is retreived then start calulate risk function passing in correct county, place and COVID percentage
            self.calculateRisk(county: self.county, place: self.place, percentage: self.percentage)
        })
        
        //self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
    }
    
    //function to create pulsating effect
    private func pulsate(){
        let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
        //layerAnimation.fromValue = 0.0
        layerAnimation.toValue = 10
        layerAnimation.autoreverses = true
        layerAnimation.isAdditive = false
        layerAnimation.duration = 0.8
        //layerAnimation.fillMode = CAMediaTimingFillMode.forwards
        layerAnimation.isRemovedOnCompletion = false
        layerAnimation.repeatCount = .infinity
        pulseLayer.add(layerAnimation, forKey: "glowingAnimation")
    }
    
    //function to calculate risk
    private func calculateRisk(county: String, place: String, percentage: Double){
        print(county, place, percentage)
        //format text that will be displayed
        lol.textAlignment = .center
        lol.font = UIFont.boldSystemFont(ofSize: 35)
        lol.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        lol.frame.origin.x = view.center.x - 50
        lol.frame.origin.y = view.center.y - 200
        lol.numberOfLines = 8
        
        //format uidesign
        let shapeLayer = CAShapeLayer()
        let center = view.center.x + 20
        print(center)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: view.center.y - 150), radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        riskkResult.backgroundColor = UIColor.clear
        riskkResult.textAlignment = .center
        riskkResult.numberOfLines = 5
        
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: view.center.y - 150), radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        pulseLayer = CAShapeLayer()
        pulseLayer.path = circlePath2.cgPath
        pulseLayer.fillColor = UIColor.clear.cgColor
        pulseLayer.lineWidth = 10
        pulseLayer.shadowOpacity = 5
        
        
        //depending on what the county percentage is diplsay risk.
        if percentage <= 0.10 {
            //display low risk
            lol.text = "Low Risk"
            shapeLayer.strokeColor = UIColor.green.cgColor
            pulseLayer.strokeColor = UIColor.green.cgColor
            pulseLayer.shadowColor = UIColor.green.cgColor
            pulsate()
            view.layer.addSublayer(pulseLayer)
            view.layer.addSublayer(shapeLayer)
            //display what type of place the user is in and tell precautions
            if place == "university"{
                riskkResult.text = "You're at a university in a low risk area, please be sure to follow campus COVID-19 guidlines."
            } else if place == "gas station"{
                riskkResult.text = "You're at a gas station in a low risk area, please still be cautious and sanitize your hands after touching pumps or purchasing items from inside."
            } else if place == "restaurant"{
                riskkResult.text = "You're at a restaurant in a low risk area, please keep socially distanced from others and wear a mask when speaking to employees and others."
            } else if place == "dealership"{
                riskkResult.text = "You're at a dealership in a low risk area, please wear a mask at all times and santitize hands often."
            } else if place == "hotel"{
                riskkResult.text = "You're at a hotel in a low risk area, please wear a mask when you are not in your and sanitize often."
            } else if place == "hospital"{
                riskkResult.text = "You're at a hospital in a low risk area, please be cautious and follow hospital COVID--19 guidlines as this are may still be high risk."
            } else if place == "gym"{
                riskkResult.text = "You're at a gym in a low risk area, please still be sure to take normal covid precautions."
            } else if place == "airport"{
                riskkResult.text = "You're at a airport in a low risk area, please be cautious and follow airport COVID-19 guidlines as this are may still be high risk."
            } else if place == "bank"{
                riskkResult.text = "You're at a bank in a low risk area, please keep socially distanced from others and wear a mask when speaking to employees and others."
            } else if place == "church"{
                riskkResult.text = "You're at a church in a low risk area, please wear a mask at all times and socially distace from others while keeping hands sanitized."
            } else if place == "doctor"{
                riskkResult.text = "You're at a doctor in a low risk area, please be cautious and follow companies COVID--19 guidlines as this are may still be high risk."
            } else if place == "stadium"{
                riskkResult.text = "You're at a stadium in a low risk area, please keep socially ditanced and santitized often."
            } else if place == "supermarket"{
                riskkResult.text = "You're at a supermarket in a low risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            } else if place == "store"{
                riskkResult.text = "You're at a store in a low risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            } else if place == "establishment"{
                riskkResult.text = "You're in an establishment in a low risk area, please keep socially distanced and keep hands sanitized."
            } else if place == "museum"{
                riskkResult.text = "You're at a museum in a low risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            }
        } else if percentage > 0.1 && percentage < 0.40 {
            //display medium risk
            lol.font = UIFont.boldSystemFont(ofSize: 24)
            lol.text = "Medium Risk"
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            pulseLayer.strokeColor = UIColor.yellow.cgColor
            pulseLayer.shadowColor = UIColor.yellow.cgColor
            pulsate()
            view.layer.addSublayer(pulseLayer)
            view.layer.addSublayer(shapeLayer)
            //display what type of place the user is in and tell precautions
            if place == "university"{
                riskkResult.text = "You're at a university in a medium risk area, please be sure to follow campus COVID-19 guidlines."
            } else if place == "gas station"{
                riskkResult.text = "You're at a gas station in a medium risk area, please still be cautious and sanitize your hands after touching pumps or purchasing items from inside."
            } else if place == "restaurant"{
                riskkResult.text = "You're at a restaurant in a medium risk area, please keep socially distanced from others and wear a mask when speaking to employees and others."
            } else if place == "dealership"{
                riskkResult.text = "You're at a dealership in a medium risk area, please wear a mask at all times and santitize hands often."
            } else if place == "hotel"{
                riskkResult.text = "You're at a hotel in a medium risk area, please wear a mask when you are not in your and sanitize often."
            } else if place == "hospital"{
                riskkResult.text = "You're at a hospital in a medium risk area, please be cautious and follow hospital COVID--19 guidlines as this are may still be high risk."
            } else if place == "gym"{
                riskkResult.text = "You're at a gym in a medium risk area, please still be sure to take normal covid precautions."
            } else if place == "airport"{
                riskkResult.text = "You're at a airport in a medium risk area, please be cautious and follow airport COVID-19 guidlines as this are may still be high risk."
            } else if place == "bank"{
                riskkResult.text = "You're at a bank in a medium risk area, please keep socially distanced from others and wear a mask when speaking to employees and others."
            } else if place == "church"{
                riskkResult.text = "You're at a church in a medium risk area, please wear a mask at all times and socially distace from others while keeping hands sanitized."
            } else if place == "doctor"{
                riskkResult.text = "You're at a doctor in a medium risk area, please be cautious and follow companies COVID--19 guidlines as this are may still be high risk."
            } else if place == "stadium"{
                riskkResult.text = "You're at a stadium in a medium risk area, please keep socially ditanced and santitized often."
            } else if place == "supermarket"{
                riskkResult.text = "You're at a supermarket in a medium risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            } else if place == "store"{
                riskkResult.text = "You're at a store in a medium risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            } else if place == "establishment"{
                riskkResult.text = "You're in an establishment in a medium risk area, please keep socially distanced and keep hands sanitized."
            } else if place == "museum"{
                riskkResult.text = "You're at a museum in a medium risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            }
        } else if percentage > 0.40 {
            //display high risk
            lol.text = "High Risk"
            shapeLayer.strokeColor = UIColor.red.cgColor
            pulseLayer.strokeColor = UIColor.red.cgColor
            pulseLayer.shadowColor = UIColor.red.cgColor
            pulsate()
            view.layer.addSublayer(pulseLayer)
            view.layer.addSublayer(shapeLayer)
            //display what type of place the user is in and tell precautions
            if place == "university"{
                riskkResult.text = "You're at a university in a high risk area, please be sure to follow campus COVID-19 guidlines."
            } else if place == "gas station"{
                riskkResult.text = "You're at a gas station in a high risk area, please still be cautious and sanitize your hands after touching pumps or purchasing items from inside."
            } else if place == "restaurant"{
                riskkResult.text = "You're at a restaurant in a high risk area, please keep socially distanced from others and wear a mask when speaking to employees and others."
            } else if place == "dealership"{
                riskkResult.text = "You're at a dealership in a high risk area, please wear a mask at all times and santitize hands often."
            } else if place == "hotel"{
                riskkResult.text = "You're at a hotel in a high risk area, please wear a mask when you are not in your and sanitize often."
            } else if place == "hospital"{
                riskkResult.text = "You're at a hospital in a high risk area, please be cautious and follow hospital COVID--19 guidlines as this area is very high risk."
            } else if place == "gym"{
                riskkResult.text = "You're at a gym in a high risk area, please still be sure to take normal covid precautions."
            } else if place == "airport"{
                riskkResult.text = "You're at a airport in a high risk area, please be cautious and follow airport COVID-19 guidlines as this area is very high risk."
            } else if place == "bank"{
                riskkResult.text = "You're at a bank in a high risk area, please keep socially distanced from others and wear a mask when speaking to employees and others."
            } else if place == "church"{
                riskkResult.text = "You're at a church in a high risk area, please wear a mask at all times and socially distace from others while keeping hands sanitized."
            } else if place == "doctor"{
                riskkResult.text = "You're at a doctor in a high risk area, please be cautious and follow companies COVID--19 guidlines as this area is very high risk."
            } else if place == "stadium"{
                riskkResult.text = "You're at a stadium in a high risk area, please keep socially ditanced and santitized often."
            } else if place == "supermarket"{
                riskkResult.text = "You're at a supermarket in a high risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            } else if place == "store"{
                riskkResult.text = "You're at a store in a high risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            } else if place == "establishment"{
                riskkResult.text = "You're in an establishment in a high risk area, please keep socially distanced and keep hands sanitized."
            } else if place == "museum"{
                riskkResult.text = "You're at a museum in a high risk area, please wear mask at all times and keep socially distanced while keeping hands sanitized."
            }
        }
    }
}

