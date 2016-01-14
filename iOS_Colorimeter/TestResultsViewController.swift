import UIKit
import AVFoundation
import CoreData

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
        var red = savedVariables.calibrationRedArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        var green = savedVariables.calibrationGreenArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        var blue = savedVariables.calibrationBlueArray[savedVariables.currentTestArea][savedVariables.instanceCount]
        
        
        
        redLabel.text = (String(format: "Red:  %.5f", red))
        greenLabel.text = (String(format: "Green:  %.5f", green))
        blueLabel.text = (String(format: "Blue:  %.5f", blue))
        if(savedVariables.currentTestArea == (savedVariables.numberOfPhotos+1)){
            self.performSegueWithIdentifier("SegueBackToMainMenu", sender: nil)
        }
        else{
        testAreaLabel.text = "\(savedVariables.currentTestArea + 1): \(savedVariables.testAreaNameArray[savedVariables.currentTestArea])"
        var averageColor = 0.0
        var channel = savedVariables.channelUsed[savedVariables.currentTestArea]
        print(channel)
        if(channel == "0"){
            averageColor =  savedVariables.calibrationRedArray[savedVariables.currentTestArea][savedVariables.instanceCount] as! Double
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