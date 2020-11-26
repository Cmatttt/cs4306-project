//
//  SecondView.swift
//  Risk Assesment
//
//  Created by cmatt on 11/22/20.
//  Copyright © 2020 Cmatt. All rights reserved.
//

import Foundation
import UIKit

class SecondView: UIViewController {
    
    var county: String = ""
    var place: String = ""
    var pulseLayer: CAShapeLayer!
    //@IBOutlet weak var lab: UILabel!

    //@IBOutlet var testText: UITextField!
    @IBOutlet var labelll: UILabel!
    @IBOutlet var SecondView: UIView!
    @IBOutlet var lla: UILabel!
    @IBOutlet var lol: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //lol.text = county
        //labelll.text = county
        
        let shapeLayer = CAShapeLayer()
        
        let center = view.center
        let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        //view.layer.addSublayer(shapeLayer)
        //shapeLayer.strokeEnd = 0
        
        pulseLayer = CAShapeLayer()
        pulseLayer.path = circlePath.cgPath
        pulseLayer.fillColor = UIColor.clear.cgColor
        pulseLayer.strokeColor = UIColor.blue.cgColor
        pulseLayer.lineWidth = 10
        //pulseLayer.position = view.center
        let makeAnimation = CABasicAnimation(keyPath: "transform.scale")
        makeAnimation.fromValue = 0.0
        makeAnimation.toValue = 1.5
        makeAnimation.duration = 5
//        animation.autoreverses = true
//        animation.repeatCount = Float.infinity
        
        //pulseLayer.add(animation, forKey: "pulsing")
        pulseLayer.add(makeAnimation, forKey: "pulsing")
        view.layer.addSublayer(pulseLayer)
    }
    
    private func pulsate(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 8.5
        animation.duration = 5
//        animation.autoreverses = true
//        animation.repeatCount = Float.infinity
        
        //pulseLayer.add(animation, forKey: "pulsing")
        
        pulseLayer.add(animation, forKey: "pulsing")
    }

}

