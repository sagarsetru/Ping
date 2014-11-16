//
//  AppDelegate.swift
//  Ping
//
//  Created by Sagar Setru on 11/15/14.
//  Copyright (c) 2014 Cajolise. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var client: MSClient?
    
    var deviceToken: NSData?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        self.client = MSClient(applicationURLString: "https://pingping.azure-mobile.net/", applicationKey: "ntpryhnZVXSegSmfSxJqbITsiNvEDh92")
        
        let notificationTypes:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let notificationSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            println("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
        case .Denied:
            println("You are denied access to address book")
            
        case .NotDetermined:
            createAddressBook()
            if let theBook: ABAddressBookRef = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                    {(granted: Bool, error: CFError!) in
                        
                        if granted{
                            println("Access is granted")
                        } else {
                            println("Access is not granted")
                        }
                        
                })
            }
            
        case .Restricted:
            println("Access is restricted")
            
        default:
            println("Unhandled")
        }
        
        return true
        
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        
        
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        var deviceTokenString: String = ( deviceToken.description as NSString )
                    .stringByTrimmingCharactersInSet( characterSet )
                    .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        println( deviceTokenString )
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println(error.localizedDescription)
        NSLog("Failed to Register ", error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    
    }
    
    //  PHONE BOOK ACCESS REQUESTING HANDLING
    //requesting access to address book, from the iOS 8 Swift Programming Cookbook
    var addressBook: ABAddressBookRef?
    
    func createAddressBook(){
        var error: Unmanaged<CFError>?
        
        addressBook = ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue()
        
        /* You can use the address book here */
        
    }
}

