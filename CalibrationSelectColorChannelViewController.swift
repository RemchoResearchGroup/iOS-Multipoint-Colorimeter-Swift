import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData

class CalibrationSelectColorChannelViewController: UIViewController {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("*********")
        print(savedVariables.concertationArray)
        print(savedVariables.concertationValueArray)
        print(savedVariables.testAreaNameArray)
        print(savedVariables.currentTestArea)
        print("************")
    
        savedVariables.timingArray.sortInPlace()
        print(savedVariables.timingArray)
        
        
        
    }
   
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}