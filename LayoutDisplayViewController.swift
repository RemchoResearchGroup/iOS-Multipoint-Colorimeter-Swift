import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData

var assetCollection: PHAssetCollection!
var albumFound : Bool = false
var photosAsset: PHFetchResult!
var assetThumbnailSize:CGSize!
var collection: PHAssetCollection!
var assetCollectionPlaceholder: PHObjectPlaceholder!
/*Variable used for flag, sovles issue that causes perform test to loop.
Needs to be reset in perform test*/
var onlyStartOneTestFlag = 1

var myList: Array<AnyObject> = []

class LayoutDisplayViewController: UIViewController {
    var buffer = UIImage()
    //Flag that is called in both displayImage & analzye
    var ifFlag = false
    var backgroundRecordId: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    //Labels
    @IBOutlet weak var loadModelName: UILabel!
    @IBOutlet weak var loadTestTime: UILabel!
    @IBOutlet weak var loadIntervalTime: UILabel!
    @IBOutlet weak var loadFlash: UILabel!
    @IBOutlet weak var snapButton: UIBarButtonItem!
    //Image View
   // @IBOutlet weak var previewView: PreviewView!
    @IBOutlet var testNumberLabel: UILabel!
    
    @IBOutlet weak var previewView: AVCamPreviewView!
    var assetCollection: PHAssetCollection!
    var albumFound : Bool = false
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!
    var image = UIImage()
    
    var testImagine = UIImage()

    var sessionQueue : dispatch_queue_t?
    var session : AVCaptureSession?
    var videoDeviceInput : AVCaptureDeviceInput?
    var videoDevice : AVCaptureDevice?
    var movieFileOutput : AVCaptureMovieFileOutput?
    var stillImageOutput : AVCaptureStillImageOutput?
    var backgroundRecordingId : UIBackgroundTaskIdentifier?
    var deviceAuthorized : Bool?
    
    var lockInterfaceRotation: Bool=false
    
    
    var sessionRunningAndDeviceAuthorized : Bool {
        get {
            return ((self.session?.running)! && (self.deviceAuthorized != nil))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //testNumberLabel.text = ""
        
        //Reset currentTestArea to 1
        savedVariables.currentTestArea = 1
        
        //Hides back button
        navigationItem.hidesBackButton = true
        
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        
        //Needs to be fixed
        //print("\(myList.count)")
        if(savedVariables.performingTest == false){
            var fullArray = [String] ()
            fullArray = savedVariables.testAreaInfo.characters.split {$0 == ","}.map { String($0) }
            savedVariables.xCoordinateArray = []
            savedVariables.yCoordinateArray = []
            savedVariables.radiusArray = []
            savedVariables.slopeArray = []
            savedVariables.interceptArray = []
            //savedVariables.testAreaNameArray = []
            let totalTestArray = savedVariables.numberOfTestAreas * 5
            print("The totalTestArray is \(savedVariables.numberOfTestAreas)")
            for var k = 0; k < totalTestArray; k++ {
                print("numberOfTestAreas = \(savedVariables.numberOfTestAreas)")
                print("k = \(k)")
                if (k % 5 == 0) {
                    savedVariables.xCoordinateArray += [fullArray[k]]
                    print(savedVariables.xCoordinateArray)
                }
                if (k % 5 == 1) {
                    savedVariables.yCoordinateArray += [fullArray[k]]
                }
                if (k % 5 == 2) {
                    savedVariables.radiusArray += [fullArray[k]]
                }
                /*if (k % 5 == 3) {
                    savedVariables.testAreaNameArray  += [fullArray[k]]
                }*/
                /*if (k % 5 == 4) {
                    savedVariables.unitsNameArray += [fullArray[k]]
                }*/
            }
        }
        /*else{
            var data: NSManagedObject = myList[myList.count-1] as! NSManagedObject
            let appDel:AppDelegate!
            appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            let fetchRequest = NSFetchRequest(entityName: "Model")
            myList = try! context.executeFetchRequest(fetchRequest)
            var fullArray = [String] ()
            print("\(myList.count)")
            for var i = 0; i < myList.count; i++ {
                //if modelStored.modelTest == i {
                if myList.count-1 == i {
                    let data: NSManagedObject = myList[i] as! NSManagedObject
                    savedVariables.modelName = data.valueForKeyPath("modelName") as! String
                    savedVariables.testTime = data.valueForKeyPath("testTime") as! String
                    savedVariables.intervalTime = data.valueForKeyPath("intervalTime") as! String
                    savedVariables.units = data.valueForKeyPath("units") as! String
                    savedVariables.rgb = data.valueForKeyPath("rgb") as! Bool
                    savedVariables.kinetic  = data.valueForKeyPath("kinetic") as! Bool
                    savedVariables.flashOn = data.valueForKeyPath("flashOn") as! Bool
                    savedVariables.slope = data.valueForKey("slope") as! String
                    savedVariables.intercept = data.valueForKey("intercept") as! String
                    
                    savedVariables.numberOfTestAreas = data.valueForKeyPath("tracker") as! Int
                    //savedVariables.hsv = data.valueForKeyPath("hsv") as Bool
                    //savedVariables.endPoint = data.valueForKeyPath("endPoint") as Bool
                    //savedVariables.flashOff = data.valueForKeyPath("flashOff") as Bool
                    let testAreaInfo = data.valueForKeyPath("testAreaInfo") as! String
                    // Parse testAreaInfo by spaces
                    fullArray = testAreaInfo.characters.split {$0 == ","}.map { String($0) }
                    savedVariables.xCoordinateArray = []
                    savedVariables.yCoordinateArray = []
                    savedVariables.radiusArray = []
                    savedVariables.testAreaNameArray = []
                    let totalTestArray = savedVariables.numberOfTestAreas * 7
                    for var k = 0; k < totalTestArray; k++ {
                        if (k % 7 == 0) {
                            print(fullArray[k])
                            savedVariables.xCoordinateArray += [fullArray[k]]
                        }
                        if (k % 7 == 1) {
                            savedVariables.yCoordinateArray += [fullArray[k]]
                        }
                        if (k % 7 == 2) {
                            savedVariables.radiusArray += [fullArray[k]]
                        }
                        if (k % 7 == 3) {
                            savedVariables.testAreaNameArray  += [fullArray[k]]
                        }
                        if (k % 7 == 4) {
                            savedVariables.unitsNameArray += [fullArray[k]]
                        }
                        if (k % 7 == 5) {
                            savedVariables.interceptArray += [fullArray[k]]
                        }
                        if (k % 7 == 6) {
                            savedVariables.slopeArray += [fullArray[k]]
                        }
                        
                        
                    }
                }
            }
        }*/
        // Loads information needed displayLayout
        loadStuff()
        //        Create the AV Session!
        let session : AVCaptureSession = AVCaptureSession()
        self.session = session
        
        self.previewView.session = session
        
        self.checkForAuthorizationStatus()
        
        //        It's not safe to mutate an AVCaptureSession from multiple threads at the same time. Here, we're creating a sessionQueue so that the main thread is not blocked when AVCaptureSetting.startRunning is called.
        let queue : dispatch_queue_t = dispatch_queue_create("sesion queue", DISPATCH_QUEUE_SERIAL);
        self.sessionQueue = queue
        dispatch_async(queue, {
            self.backgroundRecordId = UIBackgroundTaskInvalid
            
            let videoDevice: AVCaptureDevice! = CameraTwo.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)
            //var error: NSError = nil
            
            var videoDeviceInput: AVCaptureDeviceInput?
            do {
                videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            } catch let error1 as NSError {
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
            
            
            var audioDevice: AVCaptureDevice = AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio).first as! AVCaptureDevice
            let stillImageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
            if session.canAddOutput(stillImageOutput){
                stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                session.addOutput(stillImageOutput)
                
                self.stillImageOutput = stillImageOutput
            }
            
            
        })
    }
    
    func createAlbum() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", "camcam")
        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let first_obj: AnyObject = collection.firstObject {
            self.albumFound = true
            assetCollection = collection.firstObject as! PHAssetCollection
        } else {
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("camcam")
                self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
                }, completionHandler: { success, error in
                    self.albumFound = (success ? true: false)
                    
                    if (success) {
                        let collectionFetchResult = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([self.assetCollectionPlaceholder.localIdentifier], options: nil)
                        print(collectionFetchResult, terminator: "")
                        self.assetCollection = collectionFetchResult.firstObject as! PHAssetCollection
                    }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(self.sessionQueue!, { () -> Void in
            // self.addNotificationObservers()
            self.session!.startRunning()
        })
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        dispatch_async(self.sessionQueue!, { () -> Void in
            self.session!.stopRunning()
            // self.removeNotificationObservers()
        })
        super.viewDidDisappear(animated)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //    MARK : Utilities
    class func deviceWithMediaTypeAndPosition(mediaType: NSString, position: AVCaptureDevicePosition) -> AVCaptureDevice {
        let devices : NSArray = AVCaptureDevice.devicesWithMediaType(mediaType as String)
        var captureDevice : AVCaptureDevice = devices.firstObject as! AVCaptureDevice
        
        for device in devices {
            let device = device as! AVCaptureDevice
            if device.position == position {
                captureDevice = device
                break
            }
        }
        return captureDevice
    }
    
    func checkForAuthorizationStatus() {
        let mediaType : NSString = AVMediaTypeVideo;
        AVCaptureDevice .requestAccessForMediaType(mediaType as String, completionHandler: { (granted) -> Void in
            if (granted) {
                self.deviceAuthorized = true
            } else {
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    UIAlertView(title: "SwiftCamera", message: "SwiftCamera doesn't have permission to use the camera!", delegate: self, cancelButtonTitle: "OK").show()
                    self.deviceAuthorized = false
                })
            }
        })
    }
    
    //flash on
    func toggleTorch() {
        let avDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        // check if the device has torch
        if  avDevice.hasTorch {
            do {
                // lock your device for configuration
                try avDevice.lockForConfiguration()
            } catch _ {
            }
            // check if your torchMode is on or off. If on turns it off otherwise turns it on
            avDevice.torchMode = avDevice.torchActive ? AVCaptureTorchMode.Off : AVCaptureTorchMode.On
            do {
                // sets the torch intensity to 100%
                try avDevice.setTorchModeOnWithLevel(1.0)
            } catch _ {
            }
            // unlock your device
            avDevice.unlockForConfiguration()
        }
    }
    
    func takeStillImage() {
        //completionHandler: (() -> Void)!
        dispatch_async(self.sessionQueue!, { () -> Void in
            let layer : AVCaptureVideoPreviewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
            print("Before 443")
            self.stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo).videoOrientation = layer.connection.videoOrientation
            print("After 444")
            self.stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo).videoOrientation = layer.connection.videoOrientation
            // flash On
            //            if (savedVariables.flashOn == true) {
            //                self.toggleTorch()
            //            }
            
            
            //            For still images, let's set flash to auto
            //CameraViewController.setFlashMode(AVCaptureFlashMode.Auto, device: self.videoDevice!)
            
            //            Capture the image
            self.createAlbum()
            self.stillImageOutput?.captureStillImageAsynchronouslyFromConnection(self.stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo), completionHandler: { (imageDataSampleBuffer, error) -> Void in
                if ((imageDataSampleBuffer) != nil) {
                    var imageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    var image : UIImage = UIImage(data: imageData)!
                    //ALAssetsLibrary().writeImageToSavedPhotosAlbum(image.CGImage, orientation: ALAssetOrientation(rawValue: image.imageOrientation.rawValue)!, completionBlock: nil)
                    
                    var assetPlaceholder:PHObjectPlaceholder!
                    PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                        if #available(iOS 9.0, *) {
                            let options = PHAssetResourceCreationOptions()
                            options.originalFilename = "test"
                            let newcreation:PHAssetCreationRequest = PHAssetCreationRequest.creationRequestForAsset()
                            newcreation.addResourceWithType(PHAssetResourceType.Photo, data:UIImageJPEGRepresentation(image, 1)!, options: options)
                            assetPlaceholder = newcreation.placeholderForCreatedAsset
                        } else { // < ios 9
                            // Fallback on earlier versions
                            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                            assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
                        }
                        let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                        albumChangeRequest!.addAssets([assetPlaceholder])
                        }, completionHandler: {(success:Bool, error:NSError?) in
                            
                            print("added image to album")})
                    /*PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                    let assetPlaceholder = assetRequest.placeholderForCreatedAsset
                    let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photosAsset)
                    albumChangeRequest!.addAssets([assetPlaceholder])
                    }, completionHandler: { success, error in
                    print("added image to album")
                    //println(error)
                    
                    
                    
                    //self.showImages()
                    
                    })*/
                    
                    
                }
            })
            
        })
    }
    
    
    // Variables for timer
    var timer = NSTimer()
    //var numberOfLoops = (savedVariables.testTime as NSString).integerValue / (savedVariables.intervalTime as NSString).integerValue
    var numberOfLoops = 3
    var loopCount = 0
    
    /*Take Pics under the timer condition*/
    //Get Time Conditions
    //Function below snaps multiple images
    @IBAction func startTest(sender: AnyObject) {
        if(onlyStartOneTestFlag == 1){
            print("Starting Test")
            onlyStartOneTestFlag = 0
            loopCount = 0
            //var intTime = NSTimeInterval()
            //intTime = (savedVariables.intervalTime as NSString).doubleValue
            var intTime = NSTimeInterval()
            intTime = 1.0
            savedVariables.numberOfPhotos = numberOfLoops
            print("# of photos: \(savedVariables.numberOfPhotos)")
            timer = NSTimer.scheduledTimerWithTimeInterval(intTime, target: self, selector: "timerSetup", userInfo: nil, repeats: true)
        }
    }

    func timerSetup() {
        loopCount++
        //testNumberLabel.text = "Currently Taking Photo \(loopCount) of \(numberOfLoops)"
        if (loopCount >= numberOfLoops) {
            timer.invalidate()
            let alert = UIAlertController(title: "Alert", message: "Images Saved", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.performSegueWithIdentifier("SegueToPerformTest", sender: nil)
        }
            
        else {
            takeStillImage()
        }
    }

    func setup(index: Int){
        self.performSegueWithIdentifier("SegueToPerformTest", sender: nil)
    }
    
    
    
    // Loads the necessary information for displayLayout
    func loadStuff() {
        
        let image = UIImage(named: "circle.png")
        let calImage = UIImage(named: "calmark")
        
        let numberOneImage   = UIImage(named: "1.png")
        let numberTwoImage   = UIImage(named: "2.png")
        let numberThreeImage = UIImage(named: "3.png")
        let numberFourImage  = UIImage(named: "4.png")
        let numberFiveImage  = UIImage(named: "5.png")
        let numberSixImage   = UIImage(named: "6.png")
        let numberSevenImage = UIImage(named: "7.png")
        let numberEightImage = UIImage(named: "8.png")
        let numberNineImage  = UIImage(named: "9.png")
    
        //Load test areas
        for var i = 0; i < savedVariables.numberOfTestAreas; i++ {
            let imageView = UIImageView(image: image!)
            let calImageView = UIImageView(image: calImage!)
            
            let x = savedVariables.xCoordinateArray[i]
            let xLoc = (x as NSString).integerValue
            
            let y = savedVariables.yCoordinateArray[i]
            let yLoc = (y as NSString).integerValue
            
            let radius = savedVariables.radiusArray[i]
            let rad = (radius as NSString).integerValue
            imageView.frame = CGRect(x: xLoc - (rad/2), y: yLoc - (rad/2), width: rad, height: rad)
            let tempX = xLoc - (rad/2)
            let tempY = yLoc - (rad/2)
            print("TEST \(i): x = \(tempX) y = \(tempY)")
            view.addSubview(imageView)
            
            
            // Can shorten this code for sure, need to rewatch a stanford lecture video about closures...
            switch i {
            case 0:
                let imageViewZero = UIImageView(image: numberOneImage!)
                imageViewZero.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                //Update Calbration Color
                //imageViewZero.backgroundColor = UIColor(red: 0, green: 0, blue: 11, alpha: 1)
                view.addSubview(imageViewZero)
            case 1:
                let imageViewOne = UIImageView(image: numberTwoImage!)
                imageViewOne.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewOne)
            case 2:
                let imageViewTwo = UIImageView(image: numberThreeImage!)
                imageViewTwo.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewTwo)
            case 3:
                let imageViewThree = UIImageView(image: numberFourImage!)
                imageViewThree.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewThree)
            case 4:
                let imageViewFour = UIImageView(image: numberFiveImage!)
                imageViewFour.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewFour)
            case 5:
                let imageViewFive = UIImageView(image: numberSixImage!)
                imageViewFive.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewFive)
            case 6:
                let imageViewSix = UIImageView(image: numberSevenImage!)
                imageViewSix.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewSix)
            case 7:
                let imageViewSeven = UIImageView(image: numberEightImage!)
                imageViewSeven.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewSeven)
            case 8:
                let imageViewEight = UIImageView(image: numberNineImage!)
                imageViewEight.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewEight)
            /*case 9:
                let imageViewNine = UIImageView(image: numberNineImage!)
                imageViewNine.frame = CGRect(x: xLoc - (rad/6), y: yLoc - (rad/6), width: rad/3, height: rad/3)
                view.addSubview(imageViewNine)*/
            default:
                break
            }
        }
    }
    
    func deleteLastPhoto(asset: PHAsset) {
        let fetchOptions: PHFetchOptions = PHFetchOptions()
        PHPhotoLibrary.sharedPhotoLibrary().performChanges( {
            let assetToDelete = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
            PHAssetChangeRequest.deleteAssets(assetToDelete)
            },
            completionHandler: { success, error in
                NSLog("Finished deleting asset. %@", (success ? "Success" : error!))
        })
    }
}