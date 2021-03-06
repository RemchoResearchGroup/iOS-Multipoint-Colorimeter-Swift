import UIKit
import AVFoundation
import CoreData
import Charts

class TestResultsViewController: UIViewController{
    
    
    
    @IBOutlet var testAreaLabel: UILabel!
    @IBOutlet var unitsLabel: UILabel!
    @IBOutlet var concertationLabel: UILabel!
    
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var nextAreaButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func nextArea(sender: AnyObject) {
        savedVariables.currentTestArea += 1
        updateLabels()
    }
    
    
    func updateLabels(){
        /*if(savedVariables.currentTestArea == savedVariables.numberOfTestAreas-2){
            nextAreaButton.hidden = true
        }*/
        let red = savedVariables.calibrationRedArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        let green = savedVariables.calibrationGreenArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        let blue = savedVariables.calibrationBlueArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        if(savedVariables.numberOfTestAreas == 1){
            print("Need to set button")
        }
        
        
      
        print("Current Test Area: \(savedVariables.currentTestArea)")
        print("Number of Test Area: \(savedVariables.numberOfTestAreas)")
        if(savedVariables.currentTestArea == (savedVariables.numberOfTestAreas)){
            self.performSegueWithIdentifier("SegueBackToMainMenu", sender: nil)
        }
        else{
            if(savedVariables.takeSlopeDataArray[savedVariables.currentTestArea] as! String == "True"){
                redLabel.text = (String(format: "Red Slope:  %.5f", red))
                greenLabel.text = (String(format: "Green Slope:  %.5f", green))
                blueLabel.text = (String(format: "Blue Slope:  %.5f", blue))
            }
            else{
                redLabel.text = (String(format: "Red:  %.5f", red))
                greenLabel.text = (String(format: "Green:  %.5f", green))
                blueLabel.text = (String(format: "Blue:  %.5f", blue))
            }
            
        testAreaLabel.text = "\(savedVariables.currentTestArea + 1): \(savedVariables.testAreaNameArray[savedVariables.currentTestArea])"
        var averageColor = 0.0
        let channel = savedVariables.channelUsed[savedVariables.currentTestArea]
        print(channel)
        if(channel == "0"){
            averageColor =  savedVariables.calibrationRedArray[savedVariables.currentTestArea][savedVariables.instanceCount]
            print(averageColor)
        }
        if(channel == "1"){
            averageColor = savedVariables.calibrationGreenArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        }
        if(channel == "2"){
            averageColor = savedVariables.calibrationBlueArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        }
        
        let slope = (savedVariables.slopeArray[savedVariables.currentTestArea] as NSString).doubleValue
        print("The slope is : \(slope)")
        let intercept = (savedVariables.interceptArray[savedVariables.currentTestArea] as NSString).doubleValue
        print("The intercept is: \(intercept)")
        let concertationNumber =  intercept + slope * averageColor
        print(concertationNumber)
        concertationLabel.text = "\(concertationNumber)"
        //concertationLabel.text = "\(concertationNumber) \(savedVariables.unitsNameArray[savedVariables.currentTestArea+1])"
        
        }  
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedVariables.currentTestArea = 0
        updateLabels()
    }
}