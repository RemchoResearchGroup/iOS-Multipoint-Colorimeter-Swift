import UIKit

class PanelTypeOfTestViewController: UIViewController {
    //For the current test; 0 == Kinetic && 1 == End-Point.
    var currentTypeOfTest = 0
    //let attrString = NSAttributedString(string: "What is the interval time?", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
    
    @IBOutlet weak var typeOfTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var totalTestTimeTextField: UITextField!
    @IBOutlet weak var intervalTimeTextField: UITextField!
    @IBOutlet weak var intervalTimeLabel: UILabel!
    @IBOutlet weak var nextAreaButton: UIButton!
    
    
    
    
    @IBOutlet weak var intervalTimeView: UIView!
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }

    
    
    
    @IBAction func switchTestType(sender: AnyObject) {
       switch typeOfTypeSegmentedControl.selectedSegmentIndex{
            //Kinetic selected.
            case 0:
                print("Kinetic Selected")
                currentTypeOfTest = 0
                self.intervalTimeView.hidden = false
                //intervalTimeLabel.text = "What is the interval time?"
                //textLabel.text = "First selected";
            
            //End-Point selected.
            case 1:
                print("End-Point Selected")
                currentTypeOfTest = 1
                self.intervalTimeView.hidden = true
                //intervalTimeLabel.attributedText = attrString
                //textLabel.text = "Second Segment selected";
            default: 
                break;
        }
    }
   
   
    @IBAction func goToNextAreaOrOverview(sender: AnyObject) {
        //print("The current: \(savedVariables.currentTestArea)")
        //print("The total test areas: \(savedVariables.numberOfTestAreas)")
        if(savedVariables.currentTestArea == savedVariables.numberOfTestAreas){
            //Check if Kinetic
            if(currentTypeOfTest == 0){
                if(totalTestTimeTextField.text! == ""){
                    let alert = UIAlertController(title: "Error", message: "Please add a panel name.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(intervalTimeTextField.text! == ""){
                    let alert = UIAlertController(title: "Error", message: "Please add a panel name.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    let totalTime = Float(totalTestTimeTextField.text!)
                    let intervalTime = Float(intervalTimeTextField.text!)
                    if(intervalTime > totalTime){
                        let alert = UIAlertController(title: "Error", message: "Interval time cannot exceed total time.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        savedVariables.typeOfTestArray[currentTypeOfTest] = "Kinetic"
                        savedVariables.totalTestTimeArray[currentTypeOfTest] = totalTestTimeTextField.text!
                        savedVariables.intervalTestTimeArray[currentTypeOfTest] = intervalTimeTextField.text!
                        savedVariables.currentTestArea += 1
                        setHighestTotalTestTime()
                        setTiming(intervalTimeTextField.text!)
                        self.performSegueWithIdentifier("toTestOverviewSegue", sender: nil)
                    }

                }
            }
           
            //Check if End-Point
            if(currentTypeOfTest == 1){
                if(totalTestTimeTextField.text! == ""){
                    let alert = UIAlertController(title: "Error", message: "Please add a panel name.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    savedVariables.typeOfTestArray[currentTypeOfTest] = "End-Point"
                    savedVariables.totalTestTimeArray[currentTypeOfTest] = totalTestTimeTextField.text!
                    savedVariables.intervalTestTimeArray[currentTypeOfTest] = "0"
                    setHighestTotalTestTime()
                    setTiming(intervalTimeTextField.text!)
                    self.performSegueWithIdentifier("toTestOverviewSegue", sender: nil)
                }
            }
        }
        else{
                //Check if Kinetic
                if(currentTypeOfTest == 0){
                
                    if(totalTestTimeTextField.text! == ""){
                        let alert = UIAlertController(title: "Error", message: "Please add a test time.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else if(intervalTimeTextField.text! == ""){
                        let alert = UIAlertController(title: "Error", message: "Please add a interval time.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        let totalTime = Float(totalTestTimeTextField.text!)
                        let intervalTime = Float(intervalTimeTextField.text!)
                        if(intervalTime > totalTime){
                            let alert = UIAlertController(title: "Error", message: "Interval time cannot exceed total time.", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                        else{
                            savedVariables.typeOfTestArray[currentTypeOfTest] = "Kinetic"
                            savedVariables.totalTestTimeArray[currentTypeOfTest] = totalTestTimeTextField.text!
                            savedVariables.intervalTestTimeArray[currentTypeOfTest] = intervalTimeTextField.text!
                            savedVariables.currentTestArea += 1
                            setHighestTotalTestTime()
                            setTiming(intervalTimeTextField.text!)
                            self.performSegueWithIdentifier("toPanelTestAreaNameSegue", sender: nil)
                        }

                    }
                }
                
                //Check if End-Point
                if(currentTypeOfTest == 1){
               
                    if(totalTestTimeTextField.text! == ""){
                        let alert = UIAlertController(title: "Error", message: "Please add a test time.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                else{
                        savedVariables.typeOfTestArray[currentTypeOfTest] = "End-Point"
                        savedVariables.totalTestTimeArray[currentTypeOfTest] = totalTestTimeTextField.text!
                        savedVariables.intervalTestTimeArray[currentTypeOfTest] = "0"
                        savedVariables.currentTestArea += 1
                        setHighestTotalTestTime()
                        setTiming(intervalTimeTextField.text!)
                        self.performSegueWithIdentifier("toPanelTestAreaNameSegue", sender: nil)
              
                }
            }
        }
    }

    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func setHighestTotalTestTime(){
        print("The current highest total time is : \(savedVariables.highestTotalTime)")
        
        let totalTestTimeToInt = Int(totalTestTimeTextField.text!)
        if(savedVariables.highestTotalTime < totalTestTimeToInt!){
            savedVariables.highestTotalTime = totalTestTimeToInt!
            print("Highest Total Time: \(totalTestTimeToInt)")
        }
    }
    
    func setTiming(intervalTime: String){
        let tempInt:Int = Int(intervalTime)!
        savedVariables.timingArray += [tempInt]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //Update label to corresponding test area.
        
        //Hides back button
        navigationItem.hidesBackButton = true
        
        
        if(savedVariables.currentTestArea == savedVariables.numberOfTestAreas){
            nextAreaButton.setTitle("Review test area information.", forState: .Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}