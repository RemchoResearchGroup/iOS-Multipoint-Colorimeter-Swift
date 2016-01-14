import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData



class CalibrationSelectColorChannelViewController: UIViewController{
    
    
    
    @IBOutlet var equationLabel: UILabel!
    
    
    @IBOutlet var testAreaNameAndNumberLabel: UILabel!
    @IBOutlet var unitsLabel: UILabel!
    
    @IBOutlet var nextOrSaveBarButton: UIButton!
    
    @IBOutlet var hsvSegmentedControl: UISegmentedControl!
   
    @IBOutlet var r2Label: UILabel!
    @IBOutlet var slopeLabel: UILabel!
    @IBOutlet var interceptLabel: UILabel!
    
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }
    
    func updateLabels(){
        testAreaNameAndNumberLabel.text = "\(savedVariables.currentTestArea+1): \(savedVariables.testAreaNameArray[savedVariables.currentTestArea])"
        print(savedVariables.testAreaNameArray)
    }

    
    
    
    func linearRegression (testArea: Int, testChannel: Int) -> (intercept: Double, slope: Double, rSquared: Double)
    {
        var intercept = 0.0
        var slope  = 0.0
        var correlation = 0.0
        var rSquared = 0.0
        var sumX   = 0.0
        var sumY   = 0.0
        var sumXY  = 0.0
        var sumX2  = 0.0
        var sumY2  = 0.0
        var xValue = 0.0
        var n = 0.0
        var yValue = 0.0
        
        
        let numberOfItems = Double(savedVariables.numberOfTestAreas)
        print("The number of Items is \(numberOfItems)")
        n = numberOfItems
        
        if savedVariables.numberOfTestAreas > 0 {
            print("**********************************")
            for var i = 0; i <= savedVariables.numberOfTestAreas; i++ {
                yValue = savedVariables.concentrationArray[testArea][i]
                switch testChannel {
                case 0:
                    xValue = savedVariables.calibrationRedArray[testArea][i]
                case 1:
                    xValue = savedVariables.calibrationGreenArray[testArea][i]
                case 2:
                    xValue = savedVariables.calibrationBlueArray[testArea][i]
                case 3:
                    xValue = savedVariables.calibrationHueArray[testArea][i]
                case 4:
                    xValue = savedVariables.calibrationSaturationArray[testArea][i]
                case 5:
                    xValue = savedVariables.calibrationValueArray[testArea][i]
                default:
                    break;
                }
                sumX += xValue
                sumY += yValue
                sumXY += (xValue * yValue)
                sumX2 += (xValue * xValue)
                sumY2 += (yValue * yValue)
            }
            print("**********************************")
            print("The sum of X \(sumX)")
            print("The sum of Y \(sumY)")
            print("The sum of XY \(sumXY)")
            print("The sum of X squared \(sumX2)")
            print("The sum of Y squared \(sumY2)")
            
            intercept = ((sumY*sumX2)-(sumX*sumXY))/(n*sumX2 - (sumX * sumX))
            slope = ((n * sumXY) - (sumX * sumY))/(n*(sumX2) - (sumX * sumX))
            correlation = ((Double(numberOfItems) * sumXY) - (sumX * sumY)) / (sqrt(Double(numberOfItems) * sumX2 - (sumX * sumX)) * sqrt(Double(numberOfItems) * sumY2 - (sumY * sumY)))
            rSquared = correlation * correlation
            //count = count + 1
            print("\(slope)")
            print("\(intercept)")
            print("**********************************")
        }
        return (intercept, slope, rSquared)
    }

    
    
    @IBAction func nextArea(sender: AnyObject) {
        if(savedVariables.numberOfTestAreas == savedVariables.currentTestArea+1){
            savedVariables.slopeArray += [""]
            savedVariables.interceptArray += [""]
            savedVariables.slopeArray[savedVariables.currentTestArea] = String(currentSlope)
            savedVariables.interceptArray[savedVariables.currentTestArea] = String(currentIntercept)
            savedVariables.channelUsed += [""]
            savedVariables.channelUsed[savedVariables.currentTestArea] = String(currentChannel)
            
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            let newModel = NSEntityDescription.insertNewObjectForEntityForName("Model", inManagedObjectContext: context) as! Model
            //text fields strings are saved
            print("MODEL HIT")
            newModel.modelName = savedVariables.panelName
            newModel.testTime = savedVariables.testTime
            newModel.intervalTime = savedVariables.intervalTime
            
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
                
            newModel.setValue(savedVariables.numberOfTestAreas, forKey: "tracker")
                
                
                //savedVariables.testAreaNames += [""]
                
                
                //testAreaNameList += [""]
                //unitsNameList += [""]
            
                //slopeList += [""]
                //interceptList += [""]
            savedVariables.testAreaInfo = ""
            for var i = 0; i < savedVariables.numberOfTestAreas; i++ {
                let testArea = NSEntityDescription.insertNewObjectForEntityForName("TestArea", inManagedObjectContext: context) as! TestArea
                //println("Test Area \(i): \(xcoordinateList[i + 1]), \(savedVariables.ycoordinateList[i + 1]), \(savedVariables.radiusList[i + 1]) px")
                testArea.totalTime = (savedVariables.totalTestTimeArray[i])  as! String
                testArea.intervalTime = (savedVariables.intervalTestTimeArray[i]) as! String
                testArea.xcoordinate = (savedVariables.xCoordinateArray[i])
                testArea.ycoordinate = (savedVariables.yCoordinateArray[i])
                testArea.radius = String(savedVariables.radiusArray[i])
                testArea.name = String(savedVariables.testAreaNameArray[i])
                testArea.units = String(savedVariables.concertationArray[i])
                //testArea.slope = String(slopeList[i])
                //testArea.intercept = String(interceptList[i])
                print("Test Area Hit")
                newModel.addTestArea(testArea)
                //savedVariables.testAreaInfo += "\(xcoordinateList[i + 1]),\(ycoordinateList[i + 1]),\(radiusList[i + 1]),\(testAreaNameList[i + 1]),\(unitsNameList[i + 1]),"
                
                savedVariables.testAreaInfo += "\(savedVariables.xCoordinateArray[i]),\(savedVariables.yCoordinateArray[i]),\(savedVariables.radiusArray[i]),\(savedVariables.totalTestTimeArray[i]),\(savedVariables.intervalTestTimeArray[i]),\(savedVariables.testAreaNameArray[i]),\(savedVariables.concertationArray[i]),\(savedVariables.slopeArray[i]),\(savedVariables.interceptArray[i]),\(savedVariables.channelUsed[i]),"
            }
           
            
                var numberOfTestAreas = 0
                numberOfTestAreas = savedVariables.numberOfTestAreas
                for var i = 0; i < numberOfTestAreas; i++ {
                        print(savedVariables.totalTestTimeArray[i])
                        print(savedVariables.intervalTestTimeArray[i])
                        print(savedVariables.xCoordinateArray[i])
                        print(savedVariables.yCoordinateArray[i])
                        print(savedVariables.radiusArray[i])
                        print(savedVariables.slopeArray[i])
                        print(savedVariables.interceptArray[i])
                    /*savedVariables.xCord[]
                    savedVariables.yCord[]
                    savedVariables.radius[]
                    savedVariables.slope[]
                    savedVariables.intercept[][]*/
                    
                    
                    
                        /*savedVariables.testAreaInfo += "\(savedVariables.xCoordinateArray[i]),\(savedVariables.yCoordinateArray[i]),\(savedVariables.radiusArray[i]),\(savedVariables.testAreaNameArray[i]),\(savedVariables.concertationArray[i]),\(savedVariables.slopeArray[i]),\(savedVariables.interceptArray[i]),"
                        //print("\(savedVariables.xCoordinateArray[i]),\(savedVariables.yCoordinateArray[i]),\(savedVariables.radiusArray[i]),\(savedVariables.testAreaNameArray[i]),\(savedVariables.concertationArray[i]),\(savedVariables.slopeArray[i]),\(savedVariables.interceptArray[i]),")*/
                    
                }
                newModel.setValue(savedVariables.testAreaInfo, forKey: "testAreaInfo")
                print("Before save.")
                do {
                    try context.save()
                    print("saved")
                } catch _ {
                    print("Failed to save.")
                }
                savedVariables.performingTest = true
                self.performSegueWithIdentifier("SegueBackToMainMenu", sender: nil)
            }
        else{
            savedVariables.slopeArray += [""]
            savedVariables.interceptArray += [""]
            savedVariables.channelUsed += [""]
            savedVariables.channelUsed[savedVariables.currentTestArea] = String(currentChannel)
            savedVariables.slopeArray[savedVariables.currentTestArea] = String(currentSlope)
            savedVariables.interceptArray[savedVariables.currentTestArea] = String(currentIntercept)
            if(savedVariables.numberOfPhotos-2 == savedVariables.currentTestArea){
                nextOrSaveBarButton.setTitle("Continue to Test", forState: .Normal)
            }
            //Reset labels for default to red 
            hsvSegmentedControl.selectedSegmentIndex = 0
            savedVariables.currentTestArea += 1
            currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 0).slope
            currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 0).intercept
            currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 0).rSquared
            slopeLabel.text = "Slope: \(currentSlope)"
            interceptLabel.text = "Intercept: \(currentIntercept)"
            r2Label.text = "R^2: \(currentR2)"
            updateLabels()
            
            
            
            
            
        
        }
    }

    

   @IBAction func indexChanged(sender:UISegmentedControl){
        switch  hsvSegmentedControl.selectedSegmentIndex{
            case 0:
                currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 0).slope
                currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 0).intercept
                currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 0).rSquared
                equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
                slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
                interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
                r2Label.text = (String(format: "R^2: %.5f", currentR2))
                currentChannel = 0
            case 1:
                currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 1).slope
                currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 1).intercept
                currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 1).rSquared
                equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
                slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
                interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
                r2Label.text = (String(format: "R^2: %.5f", currentR2))
                currentChannel = 1
            case 2:
                currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 2).slope
                currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 2).intercept
                currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 2).rSquared
                equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
                slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
                interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
                r2Label.text = (String(format: "R^2: %.5f", currentR2))
                currentChannel = 2
            case 3:
                currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 3).slope
                currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 3).intercept
                currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 3).rSquared
                equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
                slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
                interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
                r2Label.text = (String(format: "R^2: %.5f", currentR2))
                currentChannel = 3
            case 4:
                currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 5).slope
                currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 5).intercept
                currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 5).rSquared
                equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
                slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
                interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
                r2Label.text = (String(format: "R^2: %.5f", currentR2))
                currentChannel = 4
            case 5:
                currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 6).slope
                currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 6).intercept
                currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 6).rSquared
                equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
                slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
                interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
                r2Label.text = (String(format: "R^2: %.5f", currentR2))
                currentChannel = 5
            default:
                break;
        }
    }
    
    
    var currentSlope = 0.0
    var currentIntercept = 0.0
    var currentR2 = 0.0
    var slopeList = [String] ()
    var interceptList = [String] ()
    //var r2List = [String] ()
    var currentChannel = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedVariables.currentTestArea = 0
        updateLabels()
        savedVariables.instanceCount = 0
        currentSlope = linearRegression(savedVariables.currentTestArea, testChannel: 0).slope
        currentIntercept = linearRegression(savedVariables.currentTestArea, testChannel: 0).intercept
        currentR2 = linearRegression(savedVariables.currentTestArea, testChannel: 0).rSquared
        //equationLabel.text = "y = \(currentSlope)X + \(currentIntercept)"
        equationLabel.text = (String(format: "y = %.5fX + %.5f", currentSlope, currentIntercept))
        slopeLabel.text = (String(format: "Slope: %.5f", currentSlope))
        interceptLabel.text = (String(format: "Intercept: %.5f", currentIntercept))
        r2Label.text = (String(format: "R^2: %.5f", currentR2))
        
        //Hides back button
        navigationItem.hidesBackButton = true
        
        /*let slope = linearRegression(savedVariables.currentTestArea, testChannel: currentChannel).slope
        let intercept = linearRegression(savedVariables.currentTestArea, testChannel: currentChannel).intercept*/
        
        //interceptLabel.text = "\(intercept)"
        //slopeLabel.text = "\(slope)"
        //formula.text = String(format: "y = %.5f + %.5f * X", slope, intercept)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}