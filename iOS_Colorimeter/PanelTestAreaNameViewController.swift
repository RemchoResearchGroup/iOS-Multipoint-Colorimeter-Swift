//Code for saving test panel name.
import UIKit

class PanelTestAreaNameViewController: UIViewController {
    
    @IBOutlet weak var nameTestAreaLabel: UILabel!
    @IBOutlet weak var nameTestAreaTextField: UITextField!
    @IBOutlet weak var concentrationTextField: UITextField!
    
    
    @IBAction func toTypeOfTest(sender: AnyObject) {
        savedVariables.testAreaNameArray[savedVariables.numberOfTestAreas] = nameTestAreaLabel.text!
        savedVariables.concentrationArray[savedVariables.numberOfTestAreas] = nameTestAreaLabel.text!
    }
    
    
    @IBAction func saveAreaName(sender: AnyObject) {
        //Test area name blank.  Throw alert.
        if(nameTestAreaTextField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Please add a test name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }        //Concentation area name blank.  Throw alert.
        else if(concentrationTextField.text! == ""){
            let alert = UIAlertController(title: "Error", message: "Please add a concentration name.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        //No errors.  Save data. 
        else{
            savedVariables.testAreaNameArray[savedVariables.currentTestArea - 1] = nameTestAreaTextField.text!
            savedVariables.concentrationArray [savedVariables.currentTestArea - 1] = concentrationTextField.text!
            self.performSegueWithIdentifier("toTypeOfTestSegue", sender: nil)
        }
    }

    //Cancel test send back to main menu.
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }

    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Update label to corresponding test area.
        nameTestAreaLabel.text = "What is the name of test area \(savedVariables.currentTestArea)."
        //Check if this is first time hitting the TestAreaName VC. 
        if(savedVariables.firstTestAreaFlag == 1){
             //Fill test arrays with black data for the number of tests.
             for _ in 0...savedVariables.numberOfTestAreas {
                savedVariables.takeSlopeDataArray.append("")
                savedVariables.testAreaNameArray.append("")
                savedVariables.concentrationArray.append("")
                savedVariables.concentrationValueArray.append("")
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
