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
    
    let database = Database.database().reference()
    var percentage: Double = 0.0
    var county: String = ""
    var place: String = ""
    var pulseLayer: CAShapeLayer!
    //@IBOutlet weak var lab: UILabel!

    //@IBOutlet var testText: UITextField!
    @IBOutlet var labelll: UILabel!
    @IBOutlet var SecondView: UIView!
    @IBOutlet var lla: UILabel!
    @IBOutlet var lol: UILabel!
    @IBOutlet weak var riskkResult: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        let center = view.center
        let circlePath2 = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
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
        //lol.text = county
        //labelll.text = county
        print(county)
        database.child("\(county)").observeSingleEvent(of: .value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            let perc = value!["percentage"] as! Double
            self.percentage = perc
            //print(self.percentage)
            
            self.calculateRisk(county: self.county, place: self.place, percentage: self.percentage)
        })
    }
    private func pulsate(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.fromValue = 0.0
        animation.toValue = 0.4
        animation.duration = 0.8
        //animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulseLayer.add(animation, forKey: "pulsing")
    }
    
    private func printe(i: Double){
        print(i)
    }
    
    private func calculateRisk(county: String, place: String, percentage: Double){
        print(county, place, percentage)
        lol.textAlignment = .center
        lol.font = UIFont.boldSystemFont(ofSize: 35)
        lol.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        lol.center = view.center
        lol.numberOfLines = 2
        
        let shapeLayer = CAShapeLayer()
        let center = view.center
        let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        riskkResult.backgroundColor = UIColor.blue
        riskkResult.textAlignment = .center
        riskkResult.numberOfLines = 3
        
        if percentage <= 0.10 {
            lol.text = "Low Risk"
            shapeLayer.strokeColor = UIColor.green.cgColor
            view.layer.addSublayer(shapeLayer)
            
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
            lol.font = UIFont.boldSystemFont(ofSize: 24)
            lol.text = "Medium Risk"
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            view.layer.addSublayer(shapeLayer)
            
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
            lol.text = "High Risk"
            shapeLayer.strokeColor = UIColor.red.cgColor
            view.layer.addSublayer(shapeLayer)
            
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

