import UIKit

class PanelTestOverviewViewController: UIViewController {

    @IBOutlet weak var panelNameLabel: UILabel!
    @IBOutlet weak var numberOfTestAreas: UILabel!
    @IBOutlet weak var testInfoScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panelNameLabel.text = "Panel Name: \(savedVariables.panelName)"
        numberOfTestAreas.text = "Number of Test Areas: \(savedVariables.numberOfTestAreas)"
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        //Hides back button
        navigationItem.hidesBackButton = true
        var textPosition = 20 as CGFloat
        for x in 0...savedVariables.numberOfTestAreas-1 {
            
            let label = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
            label.center = CGPointMake((screenSize.width * 0.5), textPosition)
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(savedVariables.testAreaNameArray[x]): \(x + 1)"
            label.textColor = UIColor.whiteColor()
            self.testInfoScrollView.addSubview(label)
            textPosition += 20
            
            let conName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
            conName.center = CGPointMake((screenSize.width * 0.5), textPosition)
            conName.textAlignment = NSTextAlignment.Center
            conName.text = "Units: \(savedVariables.concertationArray[x])"
            conName.textColor = UIColor.whiteColor()
            self.testInfoScrollView.addSubview(conName)
            textPosition += 20
            
            let typeOfTestName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
            typeOfTestName.center = CGPointMake((screenSize.width * 0.5), textPosition)
            typeOfTestName.textAlignment = NSTextAlignment.Center
            typeOfTestName.text = "\(savedVariables.typeOfTestArray[x])"
            typeOfTestName.textColor = UIColor.whiteColor()
            self.testInfoScrollView.addSubview(typeOfTestName)
            textPosition += 20
            
            let totalTestTimeName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
            totalTestTimeName.center = CGPointMake((screenSize.width * 0.5), textPosition)
            totalTestTimeName.textAlignment = NSTextAlignment.Center
            totalTestTimeName.text = "Total Time: \(savedVariables.totalTestTimeArray[x]) seconds"
            totalTestTimeName.textColor = UIColor.whiteColor()
            self.testInfoScrollView.addSubview(totalTestTimeName)
            textPosition += 20
            
            if(savedVariables.typeOfTestArray[x] as! String == "Kinetic"){
                let intervalTestTimeName = UILabel(frame: CGRectMake(screenSize.width, 0, 200, 21))
                intervalTestTimeName.center = CGPointMake((screenSize.width * 0.5), textPosition)
                intervalTestTimeName.textAlignment = NSTextAlignment.Center
                intervalTestTimeName.text = "Interval Time: \(savedVariables.intervalTestTimeArray[x]) seconds"
                intervalTestTimeName.textColor = UIColor.whiteColor()
                self.testInfoScrollView.addSubview(intervalTestTimeName)
                textPosition += 20
            }
            
            textPosition += 20
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

