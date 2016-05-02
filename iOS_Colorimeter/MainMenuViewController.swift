import UIKit
import CoreData




class MainMenuViewController: UIViewController {
    
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedVariables.timingArray = []
        
        //Used to find the average of the colors for a test, hence starting at one.
        savedVariables.instanceCount = 0
        savedVariables.performingTest = false
        savedVariables.performingCal = true
        //Set the first time test area flag to 1
        savedVariables.firstTestAreaFlag = 1
        //Reset number of test Areas to 0
        savedVariables.numberOfTestAreas = 0
        //Reset the current test area count.
        savedVariables.currentTestArea = 1
        
        savedVariables.countTracker = 0
        
        
        savedVariables.intervalTestTimeArray = []
        savedVariables.totalTestTimeArray = []
        
        savedVariables.concentrationMultipleArray.removeAll()
        savedVariables.calibrationRedArray.removeAll()
        savedVariables.calibrationGreenArray.removeAll()
        savedVariables.calibrationBlueArray.removeAll()
        savedVariables.calibrationHueArray.removeAll()
        savedVariables.calibrationSaturationArray.removeAll()
        savedVariables.calibrationValueArray.removeAll()
        savedVariables.calibrationSlopeRedArray.removeAll()
        savedVariables.calibrationSlopeBlueArray.removeAll()
        savedVariables.calibrationSlopeGreenArray.removeAll()
        
        savedVariables.redArray.removeAll()
        savedVariables.blueArray.removeAll()
        savedVariables.greenArray.removeAll()
        savedVariables.hueArray.removeAll()
        savedVariables.saturationArray.removeAll()
        savedVariables.valueArray.removeAll()
        
        savedVariables.conRedArray.removeAll()
        savedVariables.conBlueArray.removeAll()
        savedVariables.conGreenArray.removeAll()
        
        
        //Fill Array with up to 20 photos and 20 test areas
        let NumColumns = 100
        let NumRows = 100
        for _ in 0...NumColumns {
            savedVariables.markPhotosArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            savedVariables.concentrationMultipleArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationRedArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationGreenArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationBlueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationHueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationSaturationArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationValueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationSlopeRedArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationSlopeGreenArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.calibrationSlopeBlueArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            
            
            
            
            savedVariables.redArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.greenArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.blueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.hueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.saturationArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.valueArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            savedVariables.slopeRedArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slopeGreenArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slopeBlueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slopeHueArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slopeSaturationArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slopeValueArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            
            
            savedVariables.conRedArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.conGreenArray.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.conBlueArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            /*savedVariables.xCord.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.yCord.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.radius.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.slope.append(Array(count:NumRows, repeatedValue:Double()))
            savedVariables.intercept.append(Array(count:NumRows, repeatedValue:Double()))*/
        }
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        print(managedObjectContext)
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        /*let newModel = NSEntityDescription.insertNewObjectForEntityForName("Model", inManagedObjectContext: context) as! Model
        //text fields strings are saved
        print("MODEL HIT")
        newModel.modelName = "Model Namea"
        newModel.testTime = "10"
        newModel.intervalTime = "2"
        
        //boolean values and number of test areas are saved
        /*newModel.setValue(savedVariables.rgb, forKey: "rgb")
        newModel.setValue(savedVariables.hsv, forKey: "hsv")
        newModel.setValue(savedVariables.kinetic, forKey: "kinetic")
        newModel.setValue(savedVariables.endPoint, forKey: "endPoint")
        newModel.setValue(savedVariables.flashOff, forKey: "flashOff")
        newModel.setValue(savedVariables.flashOn, forKey: "flashOn")
        newModel.setValue(savedVariables.slope, forKey: "slope")
        newModel.setValue(savedVariables.intercept, forKey: "intercept")
        newModel.setValue(savedVariables.calCompleted, forKey: "calCompleted")*/
        
        newModel.setValue(3, forKey: "tracker")
        
        
        //savedVariables.testAreaNames += [""]
        
        
        //testAreaNameList += [""]
        //unitsNameList += [""]
        
        //slopeList += [""]
        //interceptList += [""]
        
        for var i = 0; i < 3; i++ {
            let testArea = NSEntityDescription.insertNewObjectForEntityForName("TestArea", inManagedObjectContext: context) as! TestArea
            //println("Test Area \(i): \(xcoordinateList[i + 1]), \(savedVariables.ycoordinateList[i + 1]), \(savedVariables.radiusList[i + 1]) px")
            testArea.xcoordinate = "342"
            testArea.ycoordinate = "342"
            testArea.radius = "342"
            testArea.name = "342"
            testArea.units = "342"
            print("Test Area Hit")
            newModel.addTestArea(testArea)
            //savedVariables.testAreaInfo += "\(xcoordinateList[i + 1]),\(ycoordinateList[i + 1]),\(radiusList[i + 1]),\(testAreaNameList[i + 1]),\(unitsNameList[i + 1]),"
        }

        do {
            try context.save()
        } catch _ {
        }*/
        let fetchRequest = NSFetchRequest(entityName: "Model")
        //print(fetchRequest)
        
        do {
            myList  = try context.executeFetchRequest(fetchRequest)
            print(myList)
        } catch let error as NSError {
                // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        
        
        print(myList)
        print(myList.count)
        for var i = 0; i < myList.count; i++ {
            let data: NSManagedObject = myList[0] as! NSManagedObject
            let modelName = data.valueForKeyPath("modelName") as! String
            print("Model Name: \(modelName)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

