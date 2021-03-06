//
//  ViewController.swift
//  Ping
//
//  Created by Sagar Setru on 11/15/14.
//  Copyright (c) 2014 Cajolise. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate, ABPeoplePickerNavigationControllerDelegate {
    
    let locationManager = CLLocationManager()
    var records = [NSDictionary]()
    var table : MSTable?
    var client : MSClient?
    
    @IBOutlet var mapView: MKMapView?
    
    @IBOutlet var addButton: UIBarButtonItem?
    
    @IBOutlet var mapButton: UIBarButtonItem?
    
    @IBOutlet var GPSButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setTable("Users")
    }
    
    func setTable(tableName : String) {
        let client = MSClient(applicationURLString: "https://pingping.azure-mobile.net/", applicationKey: "ntpryhnZVXSegSmfSxJqbITsiNvEDh92")
        self.table = client.tableWithName(tableName)!
    }
    
    let personPicker: ABPeoplePickerNavigationController
    
    required init(coder aDecoder: NSCoder) {
        personPicker = ABPeoplePickerNavigationController()
        super.init(coder: aDecoder)
        personPicker.peoplePickerDelegate = self
    }
    
    // first method to implement, gets called when user cancels and closes the picker UI
    // mandatory to implement
    func peoplePickerNavigationControllerDidCancel(
        peoplePicker: ABPeoplePickerNavigationController!){
            /* Mandatory to implement */
    }
    
    func peoplePickerNavigationController(
        peoplePicker: ABPeoplePickerNavigationController!,
        didSelectPerson person: ABRecordRef!) {
            
            /* Do we know which picker this is? */
            if peoplePicker != personPicker{
                return
            }
            
            /* Get all the phone numbers this user has */
            
            let phones: ABMultiValueRef = ABRecordCopyValue(person,
                kABPersonPhoneProperty).takeRetainedValue()
            
            let countOfPhones = ABMultiValueGetCount(phones)
            
            for index in 0..<countOfPhones{
                let phone = ABMultiValueCopyValueAtIndex(phones,
                    index).takeRetainedValue() as String
                
                println(phone)
                
            }
    }
    
    // add button
    @IBAction func performPickPerson(sender : AnyObject) {
        self.presentViewController(personPicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewContact(sender: UIBarButtonItem){
        
        println("Added Person")
        self.saveItem("ad hoc")
        //This is where we would add a person!
    }
    
    @IBAction func displayMap(sender: UIBarButtonItem){
        println("Move to new screen")
        
    }
    
    @IBAction func findMyLocation(sender: UIButton) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
                
                self.setTable("Requests")
                self.saveLocationItem(pm)
                
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            println(locality)
            println(postalCode)
            println(administrativeArea)
            println(country)
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error while updating location " + error.localizedDescription)
        
    }
    
    func firstButtonPush()
    {
        println("First Button Pushed!")
        
    }
    
    func secondButtonPush()
    {
        println("Second Button Pushed!")
    }
    
    func saveItem(text: String)
    {
        if text.isEmpty {
            return
        }
        
        let itemToInsert = ["phonenumber": 5102932929, "name": text]
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.table!.insert(itemToInsert) {
            (item, error) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if error != nil {
                println("Error: " + error.description)
            } else {
                self.records.append(item)
            }
        }
    }
    
    func saveLocationItem(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let GPScoords = NSString(format: "%12.10f", containsPlacemark.location.coordinate.latitude) + ";" +
                NSString(format: "%12.10f", containsPlacemark.location.coordinate.longitude)
            
            let itemToInsert = ["phonenumber": 5102932929, "name": GPScoords]
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.table!.insert(itemToInsert) {
                (item, error) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if error != nil {
                    println("Error: " + error.description)
                } else {
                    self.records.append(item)
                }
            }
        }
    }
    
}

