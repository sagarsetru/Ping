//
//  UsersViewController.swift
//  Ping
//
//  Created by Sagar Setru on 11/15/14.
//  Copyright (c) 2014 Cajolise. All rights reserved.
//


//THE BULK OF THIS FILE WAS TAKEN FROM AZURE STARTER CODE
//started by replacing 'todo' with 'users'


// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import UIKit

protocol UsersDelegate {
    func didSaveItem(text : String)
}

class UsersViewController: UIViewController, UINavigationBarDelegate,  UIBarPositioningDelegate, UITextFieldDelegate {
    
    @IBOutlet var firstBarButton : UIBarButtonItem!
    @IBOutlet var text : UITextField!
    
    var delegate : UsersDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.firstBarButton.delegate = self
        self.text.delegate = self
        self.text.becomeFirstResponder()
    }
    
    @IBAction func cancelPressed(sender : UIBarButtonItem) {
        self.text.resignFirstResponder()
    }
    
    @IBAction func savePressed(sender : UIBarButtonItem) {
        saveItem()
        self.text.resignFirstResponder()
    }
    
    func positionForBar(bar: UIBarPositioning!) -> UIBarPosition
    {
        return UIBarPosition.TopAttached
    }
    
    // Textfield
    
    func textFieldDidEndEditing(textField: UITextField!)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool
    {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        saveItem()
        
        textField.resignFirstResponder()
        return true
    }
    
    // Delegate
    
    func saveItem()
    {
        let text = self.text.text
        self.delegate?.didSaveItem(text)
    }
}