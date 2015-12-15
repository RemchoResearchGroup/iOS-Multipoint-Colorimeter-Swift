import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData

class CalibrationAddConcentrationValueViewController: UIViewController {
    
    
    @IBOutlet var colorPreviewView: UIView!
    
  
    
    
    @IBOutlet var concentrationTextBox: UITextField!
    
    @IBOutlet var selectColorChannelButton: UIButton!
    @IBOutlet var testAreaNameLabel: UILabel!
    @IBOutlet var testAreaNumberLabel: UILabel!
    @IBOutlet var unitsLabel: UILabel!
    
    

    @IBAction func nextArea(sender: AnyObject) {
        if(concentrationTextBox.text != ""){
            if(savedVariables.numberOfTestAreas == savedVariables.currentTestArea){
                //savedVariables.concertationArray[savedVariables.currentTestArea-1][savedVariables.countTracker] = Int(concentrationTextBox.text!)!
                
                
                savedVariables.concentrationArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1] = Double(concentrationTextBox.text!)!
                print("*****")
                print(savedVariables.currentTestArea-1)
                print(savedVariables.countTracker-1)
                print("*****")
                
                print(savedVariables.concentrationArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1])
                self.performSegueWithIdentifier("SegueLayoutDisplay", sender: nil)
            }
            else{
                savedVariables.concentrationArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1] = Double(concentrationTextBox.text!)!
                print("*****")
                print(savedVariables.currentTestArea-1)
                print(savedVariables.countTracker-1)
                print("*****")
                
                
                print(savedVariables.concentrationArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1])
                savedVariables.currentTestArea += 1
                if(savedVariables.numberOfTestAreas == savedVariables.currentTestArea){
                    selectColorChannelButton.hidden = false
                }
                updateLabels()
            }
        }
        //Concentration text box is empty.
            
        
        else{
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Please enter a value for the concentration."
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
   
    
    @IBAction func retake(sender: AnyObject) {
        self.performSegueWithIdentifier("SegueLayoutDisplay", sender: nil)
    }
    
    @IBAction func goToSelectChannel(sender: AnyObject) {
        if(concentrationTextBox.text != ""){
            
            savedVariables.concentrationArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1] = Double(concentrationTextBox.text!)!
            print("*****")
            print(savedVariables.currentTestArea-1)
            print(savedVariables.countTracker-1)
            print("*****")
            
            print(savedVariables.concentrationArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1])
            
            
            
            self.performSegueWithIdentifier("SegueToColorChannel", sender: nil)
        }
        //Concentration text box is empty.
        else{
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Please enter a value for the concentration."
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    func updateLabels(){
        testAreaNameLabel.text = "\(savedVariables.currentTestArea): \(savedVariables.testAreaNameArray[savedVariables.currentTestArea-1])"
        print(savedVariables.testAreaNameArray)
        unitsLabel.text = "\(savedVariables.concertationArray[savedVariables.currentTestArea-1])"
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        savedVariables.countTracker += 1
      
        print(savedVariables.countTracker)
        updateLabels()
    
        selectColorChannelButton.hidden = true
        //colorPreviewView.backgroundColor = UIColor(red: 255, green: 165, blue: 0, alpha: 1)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}