import UIKit

class PanelTestAreaNameViewController: UIViewController {
    
    
    @IBOutlet weak var nameTestAreaLabel: UILabel!
    @IBOutlet weak var nameTestAreaTextField: UITextField!
    @IBOutlet weak var concertationTextField: UITextField!
    
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }

    
    @IBAction func toTypeOfTest(sender: AnyObject) {
        savedVariables.testAreaNameArray[savedVariables.numberOfTestAreas] = nameTestAreaLabel.text!
        savedVariables.concertationArray[savedVariables.numberOfTestAreas] = nameTestAreaLabel.text!
    }
    
    @IBAction func saveAreaName(sender: AnyObject) {
        /*if(nameTestAreaTextField.text! == "" && concertationTextField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Please add a test name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }*/
        if(nameTestAreaTextField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Please add a test name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if(concertationTextField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Please add a concertation name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            savedVariables.testAreaNameArray[savedVariables.currentTestArea - 1] = nameTestAreaTextField.text!
            savedVariables.concertationArray [savedVariables.currentTestArea - 1] = concertationTextField.text!
            
            
            //savedVariables.panelName = panelNameTextField.text!
            self.performSegueWithIdentifier("toTypeOfTestSegue", sender: nil)
        }
    }

    
    
    

    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Update label to corresponding test area.
        nameTestAreaLabel.text = "What is the name of test area \(savedVariables.currentTestArea)."
        //Check if this is first time hitting the TestAreaName VC. 
        if(savedVariables.firstTestAreaFlag == 1){
             //Fill test area name and concertation array.
             for _ in 0...savedVariables.numberOfTestAreas {
                savedVariables.testAreaNameArray.append("")
                savedVariables.concertationArray.append("")
                savedVariables.typeOfTestArray.append("")
                savedVariables.totalTestTimeArray.append("")
                savedVariables.intervalTestTimeArray.append("")
            }
            savedVariables.firstTestAreaFlag = 0
        }
        
        
        
        
        
        
        
        
        //Hides back button
        navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
