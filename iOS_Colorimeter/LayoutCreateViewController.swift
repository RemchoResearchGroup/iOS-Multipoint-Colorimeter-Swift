import UIKit
import AVFoundation
import AssetsLibrary
import CoreData


var SessionRunningAndDeviceAuthorizedContext = "SessionRunningAndDeviceAuthorizedContext"
var CapturingStillImageContext = "CapturingStillImageContext"
var RecordingContext = "RecordingContext"


class LayoutCreateViewController: UIViewController {
    
    var sessionQueue: dispatch_queue_t?
    var session: AVCaptureSession?
    var videoDeviceInput: AVCaptureDeviceInput?
    var movieFileOutput: AVCaptureMovieFileOutput?
    var stillImageOutput: AVCaptureStillImageOutput?
    
    @IBOutlet var addCircleButton: UIButton!
    
    var deviceAuthorized: Bool  = false
    var backgroundRecordId: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var sessionRunningAndDeviceAuthorized: Bool {
        get {
            return (self.session?.running != nil && self.deviceAuthorized )
        }
    }
    
    var runtimeErrorHandlingObserver: AnyObject?
    var lockInterfaceRotation: Bool = false
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }

    
    @IBOutlet weak var previewView: AVCamPreviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCircleButton.setTitle(savedVariables.testAreaNameArray[circleCount] as! String, forState:.Normal)
        
        
        //savedVariables.performingCal = true
        //savedVariables.initalCalibrationTesting = true
        
        
        //Hides back button
        navigationItem.hidesBackButton = true
        
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        let session: AVCaptureSession = AVCaptureSession()
        self.session = session
        
        self.previewView.session = session
        
        self.checkDeviceAuthorizationStatus()
        
        let sessionQueue: dispatch_queue_t = dispatch_queue_create("session queue",DISPATCH_QUEUE_SERIAL)
        
        self.sessionQueue = sessionQueue
        dispatch_async(sessionQueue, {
            self.backgroundRecordId = UIBackgroundTaskInvalid
            
            let videoDevice: AVCaptureDevice! = CameraTwo.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)
            //var error: NSError = nil
            
            var videoDeviceInput: AVCaptureDeviceInput?
            do {
                videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            } catch _ as NSError {
                //error = error1
                videoDeviceInput = nil
            } catch {
                fatalError()
            }
            if session.canAddInput(videoDeviceInput){
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                dispatch_async(dispatch_get_main_queue(), {
                    let orientation: AVCaptureVideoOrientation =  AVCaptureVideoOrientation(rawValue: self.interfaceOrientation.rawValue)!
                    (self.previewView.layer as! AVCaptureVideoPreviewLayer).connection.videoOrientation = orientation
                    
                })
            }
            let stillImageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
            if session.canAddOutput(stillImageOutput){
                stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                session.addOutput(stillImageOutput)
                
                self.stillImageOutput = stillImageOutput
            }
            
            
        })
        
        
    }
    override func viewWillAppear(animated: Bool) {
        dispatch_async(self.sessionQueue!, {
            self.addObserver(self, forKeyPath: "sessionRunningAndDeviceAuthorized", options: [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New], context: &SessionRunningAndDeviceAuthorizedContext)
            self.addObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", options: [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New], context: &CapturingStillImageContext)
            self.addObserver(self, forKeyPath: "movieFileOutput.recording", options: [NSKeyValueObservingOptions.Old, NSKeyValueObservingOptions.New], context: &RecordingContext)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "subjectAreaDidChange:", name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput?.device)
            
            
            weak var weakSelf = self
            
            self.runtimeErrorHandlingObserver = NSNotificationCenter.defaultCenter().addObserverForName(AVCaptureSessionRuntimeErrorNotification, object: self.session, queue: nil, usingBlock: {
                (note: NSNotification) in
                let strongSelf: LayoutCreateViewController = weakSelf!
                dispatch_async(strongSelf.sessionQueue!, {
                    if let sess = strongSelf.session{
                        sess.startRunning()
                    }
                })
                
            })
            
            self.session?.startRunning()
            
        })
    }
    
    func checkDeviceAuthorizationStatus(){
        let mediaType:String = AVMediaTypeVideo;
        
        AVCaptureDevice.requestAccessForMediaType(mediaType, completionHandler: { (granted: Bool) in
            if granted{
                self.deviceAuthorized = true;
            }else{
                
                dispatch_async(dispatch_get_main_queue(), {
                    let alert: UIAlertController = UIAlertController(
                        title: "AVCam",
                        message: "AVCam does not have permission to access camera",
                        preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let action: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                        (action2: UIAlertAction) in
                        exit(0);
                    } );
                    
                    alert.addAction(action);
                    
                    self.presentViewController(alert, animated: true, completion: nil);
                })
                
                self.deviceAuthorized = false;
            }
        })
        
        
        
        
    }
    
    // All of the create layout stuff not related to the camera
    var image = UIImage(named: "circle.png")
    
    var imageView = UIImageView()
    
    var calImage = UIImage(named: "calmark.png")
    var calImageView = UIImageView()
    
    
    let defaultHeight = 50
    let defaultWidth = 50
    
    var adjustableHeight = 50
    var adjustableWidth = 50
    
    var atLeastOneTestHasBeenCreated = false
    var atLeastOneCalbrationLocationHasBeenCreated = true
    
    var testAreaTracker = 0
    var numberOfTestAreas = 0
    var xcoordinateList = [String] ()
    var ycoordinateList = [String] ()
    var radiusList = [Int] ()
    /*For Test Area Name*/
    var testAreaNameList = [String] ()
    var unitsNameList = [String] ()
    var slopeList = [String] ()
    var interceptList = [String] ()
    
    
    var testAreaRadius = 50
    
    
    
    var location = CGPoint(x: 0, y: 0)
    var calLocation = CGPoint(x: 0, y: 0)
    
    var xString      = ""
    var yString      = ""
    var xCalString   = ""
    var yCalString   = ""
    var testAreaName = ""
    
    var counter = 0
    var areYouModifyingCalbrationMark = false
    
    var circleCount = 0
    
    
    @IBOutlet weak var addCircleOrToLayoutDisplayButton: UIButton!
    
    var occurredOnce = false
    
    @IBAction func addNewCircle(sender:UIButton!){
        circleCount += 1
        if(circleCount == savedVariables.numberOfTestAreas || circleCount < savedVariables.numberOfTestAreas){
            addCircleButton.setTitle(savedVariables.testAreaNameArray[circleCount] as! String, forState:.Normal)
            if(occurredOnce == true){
                xString = "\(location.x)"
                yString = "\(location.y)"
                xcoordinateList += [xString]
                ycoordinateList += [yString]
                radiusList += [testAreaRadius]
                //xString = "\(location.x)"
                //yString = "\(location.y)"
                //print(location)
            
                //testAreaNameList += ["aaa"]
                //unitsNameList += ["aaa"]
            }
            
            testAreaNameList += ["aaa"]
            unitsNameList += ["aaa"]
            slopeList += ["aaa"]
            interceptList += ["aaa"]
            
            if(circleCount == (savedVariables.numberOfTestAreas)){
                addCircleOrToLayoutDisplayButton.setTitle("Save Layout", forState: .Normal
                )
            }
            if(atLeastOneCalbrationLocationHasBeenCreated == true){
                atLeastOneTestHasBeenCreated = true
            }
            else{
                atLeastOneCalbrationLocationHasBeenCreated = true
            }
            
            //print("New Circle Tapped")
            adjustableHeight = 50
            adjustableWidth = 50
            testAreaRadius = 50
            
            //increment number of test areas
            testAreaTracker++
            numberOfTestAreas++
            occurredOnce = true
            //Not great code, changes the label for the calbration button
            if(atLeastOneTestHasBeenCreated == true && areYouModifyingCalbrationMark == true){
                //addCalbrationLocation.setTitle("Calbration Area Confirmed", forState: UIControlState.Normal)
            }

            else{
        
                adjustableHeight = 50
                adjustableWidth  = 50
                testAreaRadius   = 50
                imageView = UIImageView(image: image!)
                let screenSize: CGRect = UIScreen.mainScreen().bounds
                let screenWidth = Int(screenSize.width * 0.5)
                let screenHeight = Int(screenSize.height * 0.7)
                imageView.frame = CGRect(x: screenWidth, y: screenHeight, width: adjustableWidth, height: adjustableHeight
                )
                previewView.addSubview(imageView)
            }

        }
      
        else if(circleCount == savedVariables.numberOfTestAreas + 1){
            if(atLeastOneCalbrationLocationHasBeenCreated == true && atLeastOneTestHasBeenCreated == true){
                
                xString = "\(location.x)"
                yString = "\(location.y)"
                xcoordinateList += [xString]
                ycoordinateList += [yString]
              
                radiusList += [testAreaRadius]

                // savedVariables.testAreaNames += [""]
                
                savedVariables.numberOfTestAreas = numberOfTestAreas
                //Clear testAreaInfo
                savedVariables.testAreaInfo = ""
                //print(savedVariables.numberOfTestAreas)
                
                //print(xcoordinateList)
                //print(ycoordinateList)
            
                print(xcoordinateList)
                print(ycoordinateList)
            
                
                
                
                for var i = 0; i < numberOfTestAreas; i++ {
                    print("***********")
                    print("i: \(i)")
                    print("numberOfTestAreas: \(numberOfTestAreas)")
                    
                    savedVariables.testAreaInfo += "\(xcoordinateList[i]),\(ycoordinateList[i]),\(radiusList[i]),\(testAreaNameList[i]),\(unitsNameList[i]), , , , ,"
                    
                    print("***********")
                }
                print("Info: \(savedVariables.testAreaInfo)")
            }

            self.performSegueWithIdentifier("toLayoutDisplaySegue", sender: nil)
            
        }
        
    }
    
    @IBAction func makeTestingAreaLarger(sender: UIButton!){
        if(atLeastOneTestHasBeenCreated == true){
            if(areYouModifyingCalbrationMark == false){
                //println("Modify Cal Mark?")
                adjustableHeight =  adjustableHeight + 10
                adjustableWidth = adjustableWidth + 10
                let a = CGFloat(adjustableHeight)
                imageView.frame = CGRect(x: location.x-(a/2), y: location.y-(a/2), width: a, height: a)
                previewView.addSubview(imageView)
                //saved to model
                testAreaRadius = testAreaRadius + 10
                print("\(testAreaRadius) px")
            }
        }
        if(areYouModifyingCalbrationMark == true){
            //println("Modify Cal Mark?")
            adjustableHeight =  adjustableHeight + 5
            adjustableWidth = adjustableWidth + 5
            let a = CGFloat(adjustableHeight)
            calImageView.frame = CGRect(x: calLocation.x-(a/2), y: calLocation.y - (a/2), width: a, height: a)
            previewView.addSubview(calImageView)
        }
    }
    
    @IBAction func makeTestingAreaSmaller(sender: UIButton!){
        if(atLeastOneTestHasBeenCreated == true){
            if(areYouModifyingCalbrationMark == false){
                adjustableHeight =  adjustableHeight - 10
                adjustableWidth = adjustableWidth - 10
                let a = CGFloat(adjustableHeight)
                imageView.frame = CGRect(x: location.x-(a/2), y: location.y-(a/2), width: a, height: a)
                
                previewView.addSubview(imageView)
                //saved to model
                testAreaRadius = testAreaRadius - 10
                print("\(testAreaRadius) px")
            }
            
        }
        if(areYouModifyingCalbrationMark == true){
            adjustableHeight =  adjustableHeight - 5
            adjustableWidth = adjustableWidth - 5
            let a = CGFloat(adjustableHeight)
            calImageView.frame = CGRect(x: calLocation.x - (a/2), y: calLocation.y - (a/2), width: a, height: a)
            previewView.addSubview(calImageView)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch : UITouch! = touches.first as? UITouch!
        if(areYouModifyingCalbrationMark == false){
            location = touch.locationInView(self.view)
            imageView.center = location
            print(location)
        }
        if(areYouModifyingCalbrationMark == true){
            calLocation = touch.locationInView(self.view)
            calImageView.center = calLocation
        }
    }
}
