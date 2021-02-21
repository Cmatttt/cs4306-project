//
//  AppDelegate.swift
//  Risk Assesment
//
//  Created by Christian Matthews on 11/8/20.
//  Copyright © 2020 Cmatt. All rights reserved.
//

import UIKit
import GooglePlaces
import UIKit
import Firebase

@UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var placesClient: GMSPlacesClient!

    //GMSPlacesClient.provideAPIKey("AIzaSyAHoGDSUMzWqXIIayfIbB6TGPafBQsqa-E")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //API KEY
        GMSPlacesClient.provideAPIKey("AIzaSyBiLf_c57BUZ-WXsI164zQFb3B7Qcm1-eo")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

