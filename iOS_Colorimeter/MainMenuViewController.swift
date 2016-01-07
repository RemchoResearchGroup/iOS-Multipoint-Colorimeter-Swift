import UIKit
import CoreData




class MainMenuViewController: UIViewController {
    
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            var data: NSManagedObject = myList[0] as! NSManagedObject
            var modelName = data.valueForKeyPath("modelName") as! String
            print("Model Name: \(modelName)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

