import UIKit

class PanelNumberOfTestAreasViewController: UIViewController {
    
    
    //Max number of test areas is 10.
    var pickerNumbers = ["1","2","3","4","5","6","7","8","9","10"]

    @IBOutlet weak var testNumberPicker: UIPickerView!
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hides back button
        navigationItem.hidesBackButton = true
        
        //panelName.text = savedVariables.panelName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerNumbers.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        savedVariables.numberOfTestAreas = Int(pickerNumbers[row])!
        print(savedVariables.numberOfTestAreas)
        return pickerNumbers[row]
    }
    
}

