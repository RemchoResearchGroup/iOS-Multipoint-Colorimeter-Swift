import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData

class CalibrationAddConcentrationValueViewController: UIViewController {
    
    
    @IBOutlet var colorPreviewView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
  
    @IBOutlet var blueLabel: UILabel!
    
    
    @IBOutlet var concentrationTextBox: UITextField!
    
    @IBOutlet var selectColorChannelButton: UIButton!
    @IBOutlet var testAreaNameLabel: UILabel!
    @IBOutlet var testAreaNumberLabel: UILabel!
    @IBOutlet var unitsLabel: UILabel!
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }

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
                print(savedVariables.instanceCount)
                savedVariables.instanceCount += 1
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
                if(savedVariables.numberOfTestAreas == savedVariables.currentTestArea && savedVariables.instanceCount != 0 || savedVariables.numberOfTestAreas != 1){
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
        
        //clear textfield 
        concentrationTextBox.text = ""
        var red = savedVariables.calibrationRedArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        var green = savedVariables.calibrationGreenArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        var blue = savedVariables.calibrationBlueArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        
        
        
        redLabel.text = (String(format: "Red:  %.5f", red))
        greenLabel.text = (String(format: "Green:  %.5f", green))
        blueLabel.text = (String(format: "Blue:  %.5f", blue))
        //colorPreviewView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 0.5)
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        savedVariables.countTracker += 1
      
        print(savedVariables.countTracker)
        if(savedVariables.numberOfTestAreas == 1 && savedVariables.instanceCount != 0){
            print("Only one test area")
        }
        else{
            selectColorChannelButton.hidden = true
        }
        updateLabels()
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