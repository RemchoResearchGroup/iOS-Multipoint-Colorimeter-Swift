//
//  ViewController.swift
//  iOS_Colorimeter
//
//  Created by David Coles  on 11/5/15.
//  Copyright © 2015 Remcho Research. All rights reserved.
//

import UIKit

class CreatePanelViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var panelNameTextField: UITextField!
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedVariables.performingCal = true
        //Set the first time test area flag to 1
        savedVariables.firstTestAreaFlag = 1
        //Reset number of test Areas to 0
        savedVariables.numberOfTestAreas = 0
        //Reset the current test area count.
        savedVariables.currentTestArea = 1
        
        //Hides back button
        navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }
    
    @IBAction func savePanelName(sender: AnyObject) {
        print(panelNameTextField)
        if(panelNameTextField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Please add a panel name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            savedVariables.panelName = panelNameTextField.text!
            self.performSegueWithIdentifier("toNumberofTestAreasSegue", sender: nil)
        }
    }
}

