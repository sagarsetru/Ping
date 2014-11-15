//
//  AppDelegate.swift
//  Ping
//
//  Created by Sagar Setru on 11/15/14.
//  Copyright (c) 2014 Cajolise. All rights reserved.
//

import UIKit
//import WindowsAzureMobileServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var client: MSClient?
    
    var deviceToken: NSString?

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
        
//        self.client = MSClient(clientWithApplicationURLString:"https://pingping.azure-mobile.net/", applicationKey:"ntpryhnZVXSegSmfSxJqbITsiNvEDh92")
        self.client = MSClient(applicationURLString: "https://pingping.azure-mobile.net/", applicationKey: "ntpryhnZVXSegSmfSxJqbITsiNvEDh92")
//        
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        
//        let rootVC = ViewController()
//        var navController = UINavigationController(rootViewController:rootVC)
//        navController.setToolbarHidden(false, animated: false)
//        window!.rootViewController = navController // force unwrap the UIWindow optional here because we know there's an actual value stored here (as oppose to nil)
//        window!.makeKeyAndVisible() // make window visible and the 'key' window (being the key window means that this window will gather all interaction data)
//        
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        println( deviceTokenString )
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Failed to Register ", error)
        self.deviceToken = "";
    }
}

