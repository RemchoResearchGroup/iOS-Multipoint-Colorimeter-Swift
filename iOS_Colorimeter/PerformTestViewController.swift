import UIKit
import AVFoundation
import Photos
import AssetsLibrary

class PerformTestViewController: UIViewController {
    @IBOutlet weak var photoBeingTested: UILabel!
    @IBOutlet weak var testBeingTested: UILabel!
    
    /*func getLatestPhotos(completion completionBlock : ([UIImage] -> ()))   {
        let library = ALAssetsLibrary()
        var count = 0
        var images : [UIImage] = []
        var stopped = false
        
        library.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group,var stop) -> Void in
            
            group?.setAssetsFilter(ALAssetsFilter.allPhotos())
            
            group?.enumerateAssetsWithOptions(NSEnumerationOptions.Reverse, usingBlock: {
                (asset : ALAsset!, index, var stopEnumeration) -> Void in
                
                if (!stopped)
                {
                    
                    if count >= savedVariables.numberOfPhotos
                    {
                        self.photoBeingTested.text = "Finshed"
                        self.testBeingTested.text = ""
                        stopEnumeration.memory = ObjCBool(true)
                        stop.memory = ObjCBool(true)
                        completionBlock(images)
                        stopped = true
                        if(savedVariables.initalCalibrationTesting == false){
                            self.performSegueWithIdentifier("segueToPerformArea", sender: nil)
                        }
                        if(savedVariables.initalCalibrationTesting == true){
                            self.performSegueWithIdentifier("segueToSelectArea", sender: nil)
                        }
                    }
                    else
                    {
                        // For just the thumbnails use the following line.
                        //let cgImage = asset.thumbnail().takeUnretainedValue()
                        
                        // Use the following line for the full image.
                        let cgImage = asset.defaultRepresentation().fullScreenImage().takeUnretainedValue()
                        var a = UIImage(CGImage: cgImage)
                        
                        if let image = UIImage(CGImage: cgImage) {
                            //analyze(4, y: 4, radius: 50, optimization: 1, image: image)
                            //self.analyze(3, y: 3, radius: 200, optimization: 1, testImagine: a!)
                            //Starts at 1 to skip the calibration mark
                            for var subIndex = 1; subIndex < savedVariables.numberOfTestAreas; subIndex++ {
                                var x      = savedVariables.xCoordinateArray[subIndex]
                                var y      = savedVariables.yCoordinateArray[subIndex]
                                var radius = savedVariables.radiusArray[subIndex]
                                var xLoc   = (x as NSString).integerValue
                                var yLoc   = (y as NSString).integerValue
                                //println("Testing \(xLoc) \(yLoc) \n")
                                var rad    = (radius as NSString).integerValue
                                self.analyze(xLoc,y: yLoc,radius: rad,optimization: 5, testImagine: image, testArea: subIndex, photoUsed: count)
                            }
                            images.append(image)
                            /*if(count == savedVariables.numberOfPhotos){
                            self.performSegueWithIdentifier("SegueToSelectAreaViewController", sender: nil)
                            }*/
                            count += 1
                            
                            
                        }
                    }
                }
                
            })
            
            },failureBlock : { error in
                println(error)
        })
    }
    
    var image = UIImage()
    var buffer = UIImage()
    //Flag that is called in both displayImage & analzye
    var ifFlag = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previewView: PreviewView!
    
    //Force Landscape View
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    func analyze(x: Int, y: Int, radius: Int, optimization: Int, testImagine: UIImage, testArea: Int, photoUsed: Int) {
        photoBeingTested.text = "Photo \(photoUsed + 1) of \(savedVariables.numberOfPhotos)"
        testBeingTested.text = "Test Area \(testArea + 1) of \(savedVariables.numberOfTestAreas)"
        let x = x * 2
        let y = y * 2
        var position = CGPoint(x: x, y: y)
        // Dump RGBA values
        var redval:   CGFloat = 0
        var greenval: CGFloat = 0
        var blueval:  CGFloat = 0
        var alphaval: CGFloat = 0
        //RGBA Sum Values
        var redSum:     CGFloat = 0
        var greenSum:   CGFloat = 0
        var blueSum:    CGFloat = 0
        var alphaSum:   CGFloat = 0
        var totalLoops: CGFloat = 0
        //If Flag
        var flag = false
        
        //println(position)
        
        println("Testing: \(x) \(y) \(radius)")
        //radius * 2??????
        for var xIndex = 0; xIndex < radius; xIndex++ {
            for var yIndex = 0; yIndex < radius; yIndex++ {
                position = CGPoint(x: x + xIndex, y: y + yIndex)
                //println(position)
                // Use your extension
                let colour = testImagine.getPixelColor(position)
                
                //println("x=\(xIndex), y=\(yIndex)")
                colour.getRed(&redval, green: &greenval, blue: &blueval, alpha:&alphaval)
                
                redSum = redSum + redval
                greenSum = greenSum + greenval
                blueSum = blueSum + blueval
                alphaSum = alphaSum + alphaval
                totalLoops = totalLoops + 1
                
                
                //println("Green is r: \(redval) g: \(greenval) b: \(blueval) a: \(alphaval)")
                if(xIndex == radius - 1 /*- optimization*/ && yIndex == radius - 1/* - optimization*/){
                    //println("index if statement hit")
                    flag = true
                }
                //let hsv = HSV(redval, greenval, blueval)
                //println("Adjusted RGB: \(redval*255) g: \(greenval*255) b: \(blueval * 255)")
                //println("hue is \(hsv.hue), sat is \(hsv.saturation), value is \(hsv.value)")
            }
        }
        if(flag == true){
            println("Photo Tested: \(savedVariables.numberOfPhotos - photoUsed)")
            // println("Flag hit")
            //println("\(redSum) \(greenSum) \(blueSum) \(totalLoops)")
            var avgRed = redSum / totalLoops
            var avgGreen = greenSum / totalLoops
            var avgBlue = blueSum / totalLoops
            // alphaval = alphaSum / totalLoops
            //let hsv = HSV(redval, greenval, blueval)
            let hsv = HSV(avgRed, avgGreen, avgBlue)
            var grayScale = avgRed + avgGreen + avgBlue / 3
            //use testArea && photUsed
            
            //println("Unadjusted RGB r: \(redval) g: \(greenval) b: \(blueval) a: \(alphaval)")
            println("Adjusted RGB r: \(avgRed*255) g: \(avgGreen*255) b: \(avgBlue * 255)")
            println("Gray Scale is: \(grayScale)")
            println("hue is \(hsv.hue), sat is \(hsv.saturation), value is \(hsv.value)")
            savedVariables.redArray += [CGFloat(avgRed*255.0)]
            savedVariables.greenArray += [avgGreen*255]
            savedVariables.blueArray += [avgBlue*255]
            savedVariables.hueArray += [hsv.hue]
            savedVariables.saturationArray += [hsv.saturation]
            savedVariables.valueArray += [hsv.value]
            
            //Needs to save the photodata in the reserve order on the order of the photo being loaded
            savedVariables.calibrationRedArray[savedVariables.numberOfPhotos - photoUsed][testArea]        = Double(avgRed*255.0)
            savedVariables.calibrationGreenArray[savedVariables.numberOfPhotos - photoUsed][testArea]      = Double(avgGreen*255.0)
            savedVariables.calibrationBlueArray[savedVariables.numberOfPhotos - photoUsed][testArea]       = Double(avgBlue*255.0)
            savedVariables.calibrationHueArray[savedVariables.numberOfPhotos - photoUsed][testArea]        = Double(hsv.hue)
            savedVariables.calibrationSaturationArray[savedVariables.numberOfPhotos - photoUsed][testArea] = Double(hsv.saturation)
            savedVariables.calibrationValueArray[savedVariables.numberOfPhotos - photoUsed][testArea]      = Double(hsv.value)
            /*
            savedVariables.calibrationRedArray[savedVariables.photoCount][testArea]        = Double(avgRed*255.0)
            savedVariables.calibrationGreenArray[savedVariables.photoCount][testArea]      = Double(avgGreen*255.0)
            savedVariables.calibrationBlueArray[savedVariables.photoCount][testArea]       = Double(avgBlue*255.0)
            savedVariables.calibrationHueArray[savedVariables.photoCount][testArea]        = Double(hsv.hue)
            savedVariables.calibrationSaturationArray[savedVariables.photoCount][testArea] = Double(hsv.saturation)
            savedVariables.calibrationValueArray[savedVariables.photoCount][testArea]      = Double(hsv.value)
            */
            /*savedVariables.calibrationRedArray[savedVariables.photoCount][testArea]        =  avgRed * 255
            savedVariables.calibrationGreenArray[savedVariables.photoCount][testArea]      = avgGreen * 255
            savedVariables.calibrationBlueArray[savedVariables.photoCount][testArea]       = avgBlue * 255
            savedVariables.calibrationHueArray[savedVariables.photoCount][testArea]        = hsv.hue
            savedVariables.calibrationSaturationArray[savedVariables.photoCount][testArea] = hsv.saturation
            savedVariables.calibrationValueArray[savedVariables.photoCount][testArea]      = hsv.value*/
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onlyStartOneTestFlag = 1
        savedVariables.photoCount       += 1
        savedVariables.redArray         = ["Filler"]
        savedVariables.greenArray       = ["Filler"]
        savedVariables.blueArray        = ["Filler"]
        savedVariables.hueArray         = ["Filler"]
        savedVariables.saturationArray  = ["Filler"]
        savedVariables.valueArray       = ["Filler"]
        
        getLatestPhotos(completion: { images in
            println(images)
            //Set Images in this block.
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 */   
}