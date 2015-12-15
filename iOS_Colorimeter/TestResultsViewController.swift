import UIKit
import AVFoundation
import CoreData

class TestResultsViewController: UIViewController{
    
    @IBOutlet var testAreaLabel: UILabel!
    @IBOutlet var unitsLabel: UILabel!
    @IBOutlet var concertationLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        var averageColor = 1.1
        var channel = savedVariables.channelUsed[savedVariables.currentTestArea]
        print(channel)
        if(channel == "0"){
            averageColor = savedVariables.redArray[savedVariables.currentTestArea] as! Double
            print(averageColor)
        }
        if(channel == "1"){
            averageColor = savedVariables.greenArray[savedVariables.currentTestArea]as! Double
        }
        if(channel == "2"){
            averageColor = savedVariables.blueArray[savedVariables.currentTestArea] as! Double
        }

        let slope = (savedVariables.slopeArray[savedVariables.currentTestArea] as NSString).doubleValue
        let intercept = (savedVariables.interceptArray[savedVariables.currentTestArea] as NSString).doubleValue
        let concertationNumber =  intercept + slope * averageColor
        
        //+ (savedVariables.interceptArray[savedVariables.currentTestAreaSelected] * averageColor)
        //concertationLabel.text = "\(concertationNumber)"
        
        //unitsLabel.text = savedVariables.unitsNameArray[savedVariables.currentTestArea]
        
        
        //testAreaLabel.text = "\(savedVariables.testAreaNameArray[savedVariables.currentTestAreaSelected])"
        //formulaLabel.text = String(format: "y = %.5d + %.5d * x", savedVariables.slopeArray[savedVariables.currentTestAreaSelected], savedVariables.interceptArray[savedVariables.currentTestAreaSelected])
        // formulaLabel.text = String(format: "y = %.5\(slope) + %.5\(intercept) * x")
        //print("aaa")
        
        //slopeLabel.text = savedVariables.slopeArray[savedVariables.currentTestAreaSelected]
        //interceptLabel.text = savedVariables.interceptArray[savedVariables.currentTestAreaSelected]
        //print("\(savedVariables.currentTestAreaSelected)")
        
        
        
        
    }
}