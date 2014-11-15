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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

