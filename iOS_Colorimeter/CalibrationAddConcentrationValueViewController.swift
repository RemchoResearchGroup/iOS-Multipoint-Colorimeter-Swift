import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData
import Charts




class CalibrationAddConcentrationValueViewController: UIViewController {
    
    var redArray = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
    var greenArray = [5641.0,2234,8763,4453,4548,6236,7321,3458,2139,399,1311,5612]
    var blueArray = [6541.0,3456,7843,5678,5877,7323,7111,6456,5143,4562,6311,10412]
    
    @IBOutlet var lineChartView: LineChartView!
    
    var months: [Int] = []
    
    func setChartData(months : [Int]) {
        redArray = []
        greenArray = []
        blueArray = []
        for var yIndex = 0; yIndex < savedVariables.numberOfPhotos; yIndex++ {
            print("R \(savedVariables.redArray[savedVariables.currentTestArea-1][yIndex])")
            print("G \(savedVariables.greenArray[savedVariables.currentTestArea-1][yIndex])")
            print("B \(savedVariables.blueArray[savedVariables.currentTestArea-1][yIndex])")
            redArray += [savedVariables.redArray[savedVariables.currentTestArea-1][yIndex]]
            greenArray += [savedVariables.greenArray[savedVariables.currentTestArea-1][yIndex]]
            blueArray += [savedVariables.blueArray[savedVariables.currentTestArea-1][yIndex]]
        }
        
        let red = savedVariables.calibrationRedArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        let green = savedVariables.calibrationGreenArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        let blue = savedVariables.calibrationBlueArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        
        
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for var i = 0; i < redArray.count; i++ {
            yVals1.append(ChartDataEntry(value: redArray[i], xIndex: i))
        }
        
        let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1, label: (String(format: "Avg. %.5f", red)))
        set1.axisDependency = .Left // Line will correlate with left axis values
        set1.setColor(UIColor.redColor().colorWithAlphaComponent(0.5))
        set1.setCircleColor(UIColor.redColor())
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.redColor()
        set1.highlightColor = UIColor.whiteColor()
        set1.drawCircleHoleEnabled = true
        
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        for var i = 0; i < greenArray.count; i++ {
            yVals2.append(ChartDataEntry(value: greenArray[i], xIndex: i))
        }
        
        let set2: LineChartDataSet = LineChartDataSet(yVals: yVals2, label: (String(format: "Avg. %.5f", green)))
        set2.axisDependency = .Left // Line will correlate with left axis values
        set2.setColor(UIColor.greenColor().colorWithAlphaComponent(0.5))
        set2.setCircleColor(UIColor.greenColor())
        set2.lineWidth = 2.0
        set2.circleRadius = 6.0
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = UIColor.greenColor()
        set2.highlightColor = UIColor.whiteColor()
        set2.drawCircleHoleEnabled = true
        
        var yVals3 : [ChartDataEntry] = [ChartDataEntry]()
        for var i = 0; i < blueArray.count; i++ {
            yVals3.append(ChartDataEntry(value: blueArray[i], xIndex: i))
        }
        
        let set3: LineChartDataSet = LineChartDataSet(yVals: yVals3, label: (String(format: "Avg. %.5f", blue)))
        set3.axisDependency = .Left // Line will correlate with left axis values
        set3.setColor(UIColor.blueColor().colorWithAlphaComponent(0.5))
        set3.setCircleColor(UIColor.blueColor())
        set3.lineWidth = 2.0
        set3.circleRadius = 6.0
        set3.fillAlpha = 65 / 255.0
        set3.fillColor = UIColor.blueColor()
        set3.highlightColor = UIColor.whiteColor()
        set3.drawCircleHoleEnabled = true
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        dataSets.append(set3)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
        data.setValueTextColor(UIColor.blackColor())
        
        //5 - finally set our data
        self.lineChartView.descriptionText = ""
        self.lineChartView.data = data
        
    }

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
                
                
                savedVariables.concentrationMultipleArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1] = Double(concentrationTextBox.text!)!
                
                savedVariables.conRedArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationRedArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
                
                savedVariables.conGreenArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationGreenArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
                
                savedVariables.conBlueArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationBlueArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
            

                
                print("*****")
                print(savedVariables.currentTestArea-1)
                print(savedVariables.countTracker-1)
                print("*****")
                
                print(savedVariables.concentrationMultipleArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1])
                print(savedVariables.instanceCount)
                savedVariables.instanceCount += 1
                self.performSegueWithIdentifier("SegueLayoutDisplay", sender: nil)
            }
            else{
                savedVariables.concentrationMultipleArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1] = Double(concentrationTextBox.text!)!
                
                
                savedVariables.conRedArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationRedArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
                 savedVariables.conGreenArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationGreenArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
                
                 savedVariables.conBlueArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationBlueArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
                
                
                
                print("*****")
                print(savedVariables.currentTestArea-1)
                print(savedVariables.countTracker-1)
                print("*****")
                
                
                print(savedVariables.concentrationMultipleArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1])
                savedVariables.currentTestArea += 1
                if((savedVariables.numberOfTestAreas == savedVariables.currentTestArea && savedVariables.instanceCount != 0) || (savedVariables.instanceCount != 0 && savedVariables.numberOfTestAreas != 1)){
                    selectColorChannelButton.hidden = false
                }
           
                
                
                months = []
                if(String(savedVariables.typeOfTestArray[savedVariables.currentTestArea-1])  == "End-Point"){
                    //months += [Int(savedVariables.totalTestTimeArray[savedVariables.currentTestArea-1] as! NSNumber)]
                    
                    let totalTime:Int = Int(savedVariables.totalTestTimeArray[savedVariables.currentTestArea-1] as! String)!
                    for var i = 0; i < totalTime; i++ {
                        if(i == (totalTime - 1)){
                            months += [i]
                        }
                    }
                }
                else{
                    let totalTime:Int = Int(savedVariables.totalTestTimeArray[savedVariables.currentTestArea-1] as! String)!
                    let intervalTime:Int = Int(savedVariables.intervalTestTimeArray[savedVariables.currentTestArea-1] as! String)!
                    
                    for var i = 0; i < totalTime; i++ {
                        if((i % intervalTime == 0) && (String(savedVariables.typeOfTestArray[savedVariables.currentTestArea-1]) == "Kinetic")){
                            months += [i]
                            print(months)
                        }
                    }
                }
                setChartData(months)
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
            
            savedVariables.concentrationMultipleArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1] = Double(concentrationTextBox.text!)!
            
            
            savedVariables.conRedArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationRedArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
            savedVariables.conGreenArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationGreenArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
            
            savedVariables.conBlueArray[savedVariables.currentTestArea-1][Int(concentrationTextBox.text!)!-1] = savedVariables.calibrationBlueArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
            
            
            print("*****")
            print(savedVariables.currentTestArea-1)
            print(savedVariables.countTracker-1)
            print("*****")
            
            print(savedVariables.concentrationMultipleArray[savedVariables.currentTestArea-1][savedVariables.countTracker-1])
            
            
            
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
        var red = savedVariables.calibrationRedArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        var green = savedVariables.calibrationGreenArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
        var blue = savedVariables.calibrationBlueArray[savedVariables.currentTestArea-1][savedVariables.instanceCount]
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
        print(savedVariables.redArray[savedVariables.countTracker-1])
        print(savedVariables.greenArray[savedVariables.countTracker-1])
        print(savedVariables.blueArray[savedVariables.countTracker-1])

        months = []
        if(String(savedVariables.typeOfTestArray[savedVariables.currentTestArea-1])  == "End-Point"){
            let totalTime:Int = Int(savedVariables.totalTestTimeArray[savedVariables.currentTestArea-1] as! String)!
            for var i = 0; i < totalTime; i++ {
                if(i == (totalTime - 1)){
                months += [i]
                }
            }
        }
        else{
            let totalTime:Int = Int(savedVariables.totalTestTimeArray[savedVariables.currentTestArea-1] as! String)!
            let intervalTime:Int = Int(savedVariables.intervalTestTimeArray[savedVariables.currentTestArea-1] as! String)!
        
            for var i = 0; i < totalTime; i++ {
                if((i % intervalTime == 0) && (String(savedVariables.typeOfTestArray[savedVariables.currentTestArea-1]) == "Kinetic")){
                    months += [i]
                    print(months)
                }
            }
        }
        setChartData(months)
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