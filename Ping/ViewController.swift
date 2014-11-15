//
//  ViewController.swift
//  Ping
//
//  Created by Sagar Setru on 11/15/14.
//  Copyright (c) 2014 Cajolise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        var firstBarButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self,  action: "firstBarButton")
        var secondBarButton = UIBarButtonItem(title: "Me", style: .Plain, target: self, action: "secondButtonPush")
        self.toolbarItems = [flexibleSpace,firstBarButton, flexibleSpace, secondBarButton, flexibleSpace]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func firstButtonPush()
    {
    println("First Button Pushed!")
    
    }
    
    func secondButtonPush()
    {
        println("Second Button Pushed!")
    }
    
}

