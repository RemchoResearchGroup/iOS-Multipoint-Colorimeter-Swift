//
//  ViewController.swift
//  iOS_Colorimeter
//
//  Created by David Coles  on 11/5/15.
//  Copyright © 2015 Remcho Research. All rights reserved.
//

import UIKit

class PanelNameContainer: UIViewController {
    
    
    
    @IBOutlet weak var panelNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePanelName(sender: AnyObject) {
        print(panelNameTextField)
        if(panelNameTextField.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please add a panel name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        }
        else{
            self.performSegueWithIdentifier("backToCreatePanel", sender: nil)
        }
    
    
    }
    
}

