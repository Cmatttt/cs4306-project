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
    @IBOutlet var labelll: UILabel!
    @IBOutlet var SecondView: UIView!
    @IBOutlet var lla: UILabel!
    @IBOutlet var lol: UILabel!
    @IBOutlet weak var riskkResult: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
//        let center = view.center
//        let circlePath2 = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//        pulseLayer = CAShapeLayer()
//        pulseLayer.path = circlePath2.cgPath
//        pulseLayer.fillColor = UIColor.clear.cgColor
//        pulseLayer.strokeColor = UIColor.blue.cgColor
//        pulseLayer.lineWidth = 10
//        pulseLayer.anchorPoint = view.center
//        pulsate()
//        view.layer.addSublayer(pulseLayer)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(county)
        
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
    }
    
    //function to create pulsating effect
    private func pulsate(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
//      animation.fromValue = 0.0
        animation.toValue = 0.4
        animation.duration = 0.8
        //animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulseLayer.add(animation, forKey: "pulsing")
    }
    
    //function to calculate risk
    private func calculateRisk(county: String, place: String, percentage: Double){
        print(county, place, percentage)
        //format text that will be displayed
        lol.textAlignment = .center
        lol.font = UIFont.boldSystemFont(ofSize: 35)
        lol.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        lol.center = view.center
        lol.numberOfLines = 2
        
        //format uidesign
        let shapeLayer = CAShapeLayer()
        let center = view.center
        let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        riskkResult.backgroundColor = UIColor.blue
        riskkResult.textAlignment = .center
        riskkResult.numberOfLines = 3
        
        
        //depending on what the county percentage is diplsay risk.
        if percentage <= 0.10 {
            //display low risk
            lol.text = "Low Risk"
            shapeLayer.strokeColor = UIColor.green.cgColor
            view.layer.addSublayer(shapeLayer)
            //display what type of place the user is in and tell precautions
            if place == "university"{
                
            } else if place == "gas station"{
                
            } else if place == "restaurant"{
                
            } else if place == "dealership"{
                
            } else if place == "hotel"{
                
            } else if place == "hospital"{
                
            } else if place == "gym"{
                riskkResult.text = "You are at a gym in a low risk area, Please still be sure to take normal covid precautions."
            } else if place == "airport"{
                
            } else if place == "bank"{
                
            } else if place == "church"{
                
            } else if place == "doctor"{
                
            } else if place == "stadium"{
                
            } else if place == "supermarket"{
                
            } else if place == "store"{
                
            } else if place == "establishment"{
                
            } else if place == "museum"{
                
            }
            
        } else if percentage > 0.1 && percentage < 0.40 {
            //display medium risk
            lol.font = UIFont.boldSystemFont(ofSize: 24)
            lol.text = "Medium Risk"
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            view.layer.addSublayer(shapeLayer)
            //display what type of place the user is in and tell precautions
            if place == "university"{
                
            } else if place == "gas station"{
                
            } else if place == "restaurant"{
                
            } else if place == "dealership"{
                
            } else if place == "hotel"{
                
            } else if place == "hospital"{
                
            } else if place == "gym"{
                
            } else if place == "airport"{
                
            } else if place == "bank"{
                
            } else if place == "church"{
                
            } else if place == "doctor"{
                
            } else if place == "stadium"{
                
            } else if place == "supermarket"{
                
            } else if place == "store"{
                
            } else if place == "establishment"{
                
            } else if place == "museum"{
                
            }
            
        } else if percentage > 0.40 {
            //display high risk
            lol.text = "High Risk"
            shapeLayer.strokeColor = UIColor.red.cgColor
            view.layer.addSublayer(shapeLayer)
            //display what type of place the user is in and tell precautions
            if place == "university"{
                
            } else if place == "gas station"{
                
            } else if place == "restaurant"{
                
            } else if place == "dealership"{
                
            } else if place == "hotel"{
                
            } else if place == "hospital"{
                
            } else if place == "gym"{
                
            } else if place == "airport"{
                
            } else if place == "bank"{
                
            } else if place == "church"{
                
            } else if place == "doctor"{
                
            } else if place == "stadium"{
                
            } else if place == "supermarket"{
                
            } else if place == "store"{
                
            } else if place == "establishment"{
                
            } else if place == "museum"{
                
            }
        }
    }
}

