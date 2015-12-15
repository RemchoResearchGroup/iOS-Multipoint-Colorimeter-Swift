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
        
        
        savedVariables.timingArray = []
        
        savedVariables.performingCal = true
        //Set the first time test area flag to 1
        savedVariables.firstTestAreaFlag = 1
        //Reset number of test Areas to 0
        savedVariables.numberOfTestAreas = 0
        //Reset the current test area count.
        savedVariables.currentTestArea = 1
        
        savedVariables.countTracker = 0
        
        //Fill Array with up to 20 photos and 20 test areas
        let NumColumns = 20
        let NumRows = 20
        for column in 0...NumColumns {
            savedVariables.concentrationArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationRedArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationGreenArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationBlueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationHueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationSaturationArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationValueArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            /*savedVariables.xCord.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.yCord.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.radius.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slope.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.intercept.append(Array(count:NumRows, repeatedValue:Double()))*/
        }
        
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

