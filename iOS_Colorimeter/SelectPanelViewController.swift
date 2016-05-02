
import UIKit
import AVFoundation
import CoreData


class SelectPanelViewController: UIViewController{
    
    @IBOutlet var modelTable: UITableView!
    @IBOutlet weak var modelSelected: UILabel!
    
    @IBOutlet var panelInfoScrollView: UIScrollView!
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //savedVariables.normalTest = true
        
        
        let appDel:AppDelegate!
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let freq = NSFetchRequest(entityName: "Model")
        do {
            myList  = try context.executeFetchRequest(freq)
            print(myList)
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        modelTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedVariables.performingTest = true
        /*Sets variable for perform test segueway */
        savedVariables.initalCalibrationTesting = false
        
        self.modelTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        savedVariables.panelName = ""
        savedVariables.totalTestTimeArray = []
        savedVariables.intervalTestTimeArray = []
        savedVariables.xCoordinateArray = []
        savedVariables.yCoordinateArray = []
        savedVariables.radiusArray = []
        savedVariables.unitsNameArray = []
        savedVariables.concentrationArray = []
        savedVariables.interceptArray = []
        savedVariables.slopeArray = []
        
        
        
        savedVariables.timingArray = []
        
        //Used to find the average of the colors for a test, hence starting at one.
        savedVariables.instanceCount = 0

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
        for _ in 0...NumColumns {
            savedVariables.markPhotosArray.append(Array(count:NumRows, repeatedValue:Double()))
            
            savedVariables.concentrationArray.append(Array(count:NumRows, repeatedValue:Double()))
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
        }
        
        //Hides back button
        //navigationItem.hidesBackButton = true
       
     
        
    }
    
    func numberOfSectionsinTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
    
    //Returns the number of items in modelTable
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //savedVariables.testCount = myList.count
        return myList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "cell"
        let cell: UITableViewCell = modelTable.dequeueReusableCellWithIdentifier(CellID as String)! as UITableViewCell
        // Change font on table view cells
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.1
        cell.textLabel?.font = UIFont.systemFontOfSize(20.0)
        if let ip = indexPath as NSIndexPath? {
            let data: NSManagedObject = myList[ip.row] as! NSManagedObject
            let modelName = data.valueForKeyPath("modelName") as! String
            cell.textLabel?.text =  modelName
        }
        return cell
    }
    
    func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        
        let appDel:AppDelegate!
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView {
                context.deleteObject(myList[indexPath!.row] as! NSManagedObject)
                myList.removeAtIndex(indexPath!.row)
                tv.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            var error: NSError? = nil
            /*if !context.save(&rror) {
                abort()
            }*/
            
        }
        
    }
    var currentRow = 0
    // Table View displays core data info and updates temp variables so next screen can use it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let ip = indexPath as NSIndexPath? {
            //let data: NSManagedObject = myList[ip.row] as! NSManagedObject
            //var modelName = data.valueForKeyPath("modelName") as! String
            //modelSelected.text =  modelName
            currentRow = ip.row
        }
        savedVariables.testSelected = indexPath.row
        modelStored.modelTest = indexPath.row
        //savedVariables.testCount = myList.count
        let appDel:AppDelegate!
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Model")
        do {
            myList  = try context.executeFetchRequest(fetchRequest)
            print(myList)
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        var fullArray = [String] ()
        for var i = 0; i < myList.count; i++ {
            //if modelStored.modelTest == i {
            if myList.count-1 == i {
                print("aaa: \(i)")
                savedVariables.panelName = ""
                savedVariables.testAreaNameArray = []
                savedVariables.totalTestTimeArray = []
                savedVariables.intervalTestTimeArray = []
                savedVariables.xCoordinateArray = []
                savedVariables.yCoordinateArray = []
                savedVariables.radiusArray = []
                savedVariables.unitsNameArray = []
                savedVariables.concentrationArray = []
                savedVariables.interceptArray = []
                savedVariables.slopeArray = []
                savedVariables.highestTotalTime = 0
                
                
                savedVariables.timingArray = []
                
                
                
                
                
                
                let data: NSManagedObject = myList[currentRow] as! NSManagedObject
                savedVariables.panelName = data.valueForKeyPath("modelName") as! String
                //savedVariables.testTime = data.valueForKeyPath("testTime") as! String
                //savedVariables.intervalTime = data.valueForKeyPath("intervalTime") as! String
                //savedVariables.units = data.valueForKeyPath("units") as! String
                //savedVariables.rgb = data.valueForKeyPath("rgb") as! Bool
                //savedVariables.kinetic  = data.valueForKeyPath("kinetic") as! Bool
                //savedVariables.flashOn = data.valueForKeyPath("flashOn") as! Bool
                savedVariables.numberOfTestAreas = data.valueForKeyPath("tracker") as! Int
                print(savedVariables.numberOfTestAreas)
                //savedVariables.hsv = data.valueForKeyPath("hsv") as Bool
                //savedVariables.endPoint = data.valueForKeyPath("endPoint") as Bool
                //savedVariables.flashOff = data.valueForKeyPath("flashOff") as Bool
                var testAreaInfo = ""
                testAreaInfo = data.valueForKeyPath("testAreaInfo") as! String
                // Parse testAreaInfo by spaces
                fullArray = testAreaInfo.componentsSeparatedByString(",")
                print(fullArray)
                savedVariables.xCoordinateArray = []
                savedVariables.yCoordinateArray = []
                savedVariables.radiusArray = []
                savedVariables.testAreaNameArray = []
                let totalTestArray = savedVariables.numberOfTestAreas * 11
                for var k = 0; k < totalTestArray; k++ {
                    if (k % 11 == 0) {
                        savedVariables.xCoordinateArray += [fullArray[k]]
                    }
                    if (k % 11 == 1) {
                        savedVariables.yCoordinateArray += [fullArray[k]]
                    }
                    if (k % 11 == 2) {
                        savedVariables.radiusArray += [fullArray[k]]
                    }
                    if (k % 11 == 3) {
                        savedVariables.totalTestTimeArray += [fullArray[k]]
                        setHighestTotalTestTime(fullArray[k])
                    }
                    if (k % 11 == 4) {
                        savedVariables.intervalTestTimeArray += [fullArray[k]]
                        print("Interval Time: \(fullArray[k])")
                        addToTimingArray(Int(fullArray[k])!)
                    }
                    if (k % 11 == 5) {
                        savedVariables.testAreaNameArray  += [fullArray[k]]
                        print("The test names are: \(fullArray[k])")
                    }
                    if (k % 11 == 6) {
                        savedVariables.unitsNameArray += [fullArray[k]]
                    }
                    if (k % 11 == 7) {
                        savedVariables.slopeArray += [fullArray[k]]
                    }
                    if (k % 11 == 8) {
                        savedVariables.interceptArray += [fullArray[k]]
                    }
                    if (k % 11 == 9) {
                        savedVariables.channelUsed += [fullArray[k]]
                    }
                    if (k % 11 == 10) {
                        savedVariables.takeSlopeDataArray += [fullArray[k]]
                    }
                }
                print("Highest Time:\(savedVariables.highestTotalTime)")
                print("The current row: \(currentRow)")
                let screenSize: CGRect = UIScreen.mainScreen().bounds
                var textPosition = 20 as CGFloat
                for x in 0...savedVariables.numberOfTestAreas-1 {
                    
                    let label = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
                    label.center = CGPointMake((screenSize.width * 0.5), textPosition)
                    label.textAlignment = NSTextAlignment.Center
                    label.text = "\(savedVariables.testAreaNameArray[x]): \(x + 1)"
                    label.textColor = UIColor.whiteColor()
                    self.panelInfoScrollView.addSubview(label)
                    textPosition += 20
                    
                    let conName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
                    conName.center = CGPointMake((screenSize.width * 0.5), textPosition)
                    conName.textAlignment = NSTextAlignment.Center
                    conName.text = "Units: \(savedVariables.unitsNameArray[x])"
                    conName.textColor = UIColor.whiteColor()
                    self.panelInfoScrollView.addSubview(conName)
                    textPosition += 20
                    
                    /*let typeOfTestName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
                    typeOfTestName.center = CGPointMake((screenSize.width * 0.5), textPosition)
                    typeOfTestName.textAlignment = NSTextAlignment.Center
                    typeOfTestName.text = "\(savedVariables.typeOfTestArray[x])"
                    typeOfTestName.textColor = UIColor.whiteColor()
                    self.panelInfoScrollView.addSubview(typeOfTestName)
                    textPosition += 20*/
                    
                    let totalTestTimeName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
                    totalTestTimeName.center = CGPointMake((screenSize.width * 0.5), textPosition)
                    totalTestTimeName.textAlignment = NSTextAlignment.Center
                    totalTestTimeName.text = "Total Time: \(savedVariables.totalTestTimeArray[x]) seconds"
                    totalTestTimeName.textColor = UIColor.whiteColor()
                    self.panelInfoScrollView.addSubview(totalTestTimeName)
                    textPosition += 20
                    
                    /*if(savedVariables.typeOfTestArray[x] as! String == "Kinetic"){
                        let intervalTestTimeName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
                        intervalTestTimeName.center = CGPointMake((screenSize.width * 0.5), textPosition)
                        intervalTestTimeName.textAlignment = NSTextAlignment.Center
                        intervalTestTimeName.text = "Interval Time: \(savedVariables.intervalTestTimeArray[x]) seconds"
                        intervalTestTimeName.textColor = UIColor.whiteColor()
                        self.panelInfoScrollView.addSubview(intervalTestTimeName)
                        textPosition += 20
                    }
                    
                    textPosition += 20*/
                    
                }
            }
        }
    }
}
func setHighestTotalTestTime(inputTime: String){
    //print("The current highest total time is : \(savedVariables.highestTotalTime)")
    
    let totalTestTimeToInt = Int(inputTime)
    if(savedVariables.highestTotalTime < totalTestTimeToInt!){
        savedVariables.highestTotalTime = totalTestTimeToInt!
        //print("Highest Total Time: \(totalTestTimeToInt)")
    }
}
