import UIKit
import AVFoundation
import Photos
import AssetsLibrary



class PerformTestViewController: UIViewController {
    @IBOutlet weak var photoBeingTested: UILabel!
    @IBOutlet weak var testBeingTested: UILabel!
    
    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    
    
    func getLatestPhotos(completion completionBlock : ([UIImage] -> ()))   {
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
                        //self.photoBeingTested.text = "Finshed"
                        //self.testBeingTested.text = ""
                        stopEnumeration.memory = ObjCBool(true)
                        stop.memory = ObjCBool(true)
                        completionBlock(images)
                        stopped = true
                        if(savedVariables.performingTest == true){
                            
                            //savedVariables.instanceCount = savedVariables.instanceCount + 1
                            //self.performSegueWithIdentifier("SegueToResults1", sender: nil)
                            print("test")
                            savedVariables.currentTestArea = 0
                            var averageColor = 1.1
                            var channel = savedVariables.channelUsed[savedVariables.currentTestArea]
                            print(channel)
                            if(channel == "0"){
                                averageColor = savedVariables.calibrationRedArray[0][0]
                                print(averageColor)
                            }
                            if(channel == "1"){
                                averageColor = savedVariables.calibrationGreenArray[0][0]
                            }
                            if(channel == "2"){
                                averageColor = savedVariables.calibrationBlueArray[0][0]
                            }
                            
                            var slope = (savedVariables.slopeArray[0] as NSString).doubleValue
                            var intercept = (savedVariables.interceptArray[1] as NSString).doubleValue
                            var concertationNumber =  intercept + slope * averageColor
                            print(concertationNumber)
                            self.labelOne.text = "1: \(concertationNumber) \(savedVariables.concertationArray[0])"
                            
                            
                            print("test")
                            savedVariables.currentTestArea = 1
                            averageColor = 1.1
                            channel = savedVariables.channelUsed[savedVariables.currentTestArea]
                            print(channel)
                            if(channel == "0"){
                                averageColor = savedVariables.calibrationRedArray[1][0] 
                                print(averageColor)
                            }
                            if(channel == "1"){
                                averageColor = savedVariables.calibrationGreenArray[1][0]
                            }
                            if(channel == "2"){
                                averageColor = savedVariables.calibrationBlueArray[1][0]
                            }
                            
                            
                            slope = (savedVariables.slopeArray[0] as NSString).doubleValue
                            intercept = (savedVariables.interceptArray[1] as NSString).doubleValue
                            concertationNumber =  intercept + slope * averageColor
                            print(concertationNumber)
                            self.labelOne.text = "2: \(concertationNumber) \(savedVariables.concertationArray[1])"
                        }
                        else{
                            //savedVariables.photoCount = 0
                            self.performSegueWithIdentifier("SegueToAddConcentrationValue", sender: nil)
                        }
                    }
                    else
                    {
                        // Use the following line for the full image.
                        let cgImage = asset.defaultRepresentation().fullScreenImage().takeUnretainedValue()
                        var a = UIImage(CGImage: cgImage)
                        let image = UIImage(CGImage: cgImage)
                                                print("***********")
                        print("The number of testAreas: \(savedVariables.numberOfTestAreas)")
                        print("***********")
                        
                        for var subIndex = 0; subIndex < savedVariables.numberOfTestAreas; subIndex++ {
                            var x      = savedVariables.xCoordinateArray[subIndex]
                            var y      = savedVariables.yCoordinateArray[subIndex]
                            var radius = savedVariables.radiusArray[subIndex]
                            var xLoc   = (x as NSString).integerValue
                            var yLoc   = (y as NSString).integerValue
                            print("Testing \(xLoc) \(yLoc) \n")
                            var rad    = (radius as NSString).integerValue
                            self.analyze(xLoc,y: yLoc,radius: rad,optimization: 5, testImagine: image, testArea: subIndex, photoUsed: count)
                        }
                        images.append(image)
                        /*if(count == savedVariables.numberOfPhotos){
                        self.performSegueWithIdentifier("SegueToSelectAreaViewController", sender: nil)
                        }*/
                        count += 1
                        
                        
                        //}
                    }
                }
                
            })
            
            },failureBlock : { error in
                print(error)
        })
    }
    
    var image = UIImage()
    var buffer = UIImage()
    //Flag that is called in both displayImage & analzye
    var ifFlag = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previewView: PreviewView!
    
    //Force Landscape View
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    func analyze(x: Int, y: Int, radius: Int, optimization: Int, testImagine: UIImage, testArea: Int, photoUsed: Int) {
        //photoBeingTested.text = "Photo \(photoUsed + 1) of \(savedVariables.numberOfPhotos)"
        //testBeingTested.text = "Test Area \(testArea + 1) of \(savedVariables.numberOfTestAreas)"
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
            }
        }
        if(flag == true){
        //,if(testArea == (savedVariables.numberOfTestAreas - 1)){
            print("Photo Tested: \(savedVariables.numberOfPhotos - photoUsed)")
            // println("Flag hit")
            //println("\(redSum) \(greenSum) \(blueSum) \(totalLoops)")
            let avgRed = redSum / totalLoops
            let avgGreen = greenSum / totalLoops
            let avgBlue = blueSum / totalLoops
            let hsv = HSV(avgRed, g: avgGreen, b: avgBlue)
            let grayScale = avgRed + avgGreen + avgBlue / 3
            //use testArea && photUsed
            
            //println("Unadjusted RGB r: \(redval) g: \(greenval) b: \(blueval) a: \(alphaval)")
            print("Adjusted RGB r: \(avgRed*255) g: \(avgGreen*255) b: \(avgBlue * 255)")
            print("Gray Scale is: \(grayScale)")
            print("hue is \(hsv.hue), sat is \(hsv.saturation), value is \(hsv.value)")
            savedVariables.redArray += [CGFloat(avgRed*255.0)]
            savedVariables.greenArray += [avgGreen*255]
            savedVariables.blueArray += [avgBlue*255]
            savedVariables.hueArray += [hsv.hue]
            savedVariables.saturationArray += [hsv.saturation]
            savedVariables.valueArray += [hsv.value]
            
            //Needs to save the photodata in the reserve order on the order of the photo being loaded
            
            savedVariables.calibrationRedArray[testArea][photoUsed]       = Double(avgRed*255.0)
            savedVariables.calibrationGreenArray[testArea][photoUsed]     = Double(avgGreen*255.0)
            savedVariables.calibrationBlueArray[testArea][photoUsed]      = Double(avgBlue*255.0)
            savedVariables.calibrationHueArray[testArea][photoUsed]        = Double(hsv.hue)
            savedVariables.calibrationSaturationArray[testArea][photoUsed] = Double(hsv.saturation)
            savedVariables.calibrationValueArray[testArea][photoUsed    ]      = Double(hsv.value)




            print("**************************")
            //print("The instance is \(savedVariables.instanceCount)")
            print("The count is \(photoUsed)")
            print("The counter is \(counter)")
            print("The testArea is \(testArea)")
            print("**************************")
            //savedVariables.photoCount = savedVariables.photoCount + 1
            counter = counter + 1
        }
    }
    
    
    
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        onlyStartOneTestFlag = 1
        
        

        //savedVariables.photoCount       += 1
        savedVariables.redArray         = ["Filler"]
        savedVariables.greenArray       = ["Filler"]
        savedVariables.blueArray        = ["Filler"]
        savedVariables.hueArray         = ["Filler"]
        savedVariables.saturationArray  = ["Filler"]
        savedVariables.valueArray       = ["Filler"]
        




        getLatestPhotos(completion: { images in
            print(images)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}