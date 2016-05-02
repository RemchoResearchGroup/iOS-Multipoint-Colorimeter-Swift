import UIKit
import AVFoundation
import Photos
import AssetsLibrary



class PerformTestViewController: UIViewController {
    @IBOutlet weak var photoBeingTested: UILabel!
    @IBOutlet weak var testBeingTested: UILabel! 
    @IBOutlet var progressLabel: UILabel!
    
    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelledSegue", sender: nil)
    }
    
    
    func getLatestPhotos(completion completionBlock : ([UIImage] -> ()))   {
        let library = ALAssetsLibrary()
        var count = 0
        var images : [UIImage] = []
        var stopped = false
        
        library.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group, stop) -> Void in
            
            group?.setAssetsFilter(ALAssetsFilter.allPhotos())
            
            group?.enumerateAssetsWithOptions(NSEnumerationOptions.Reverse, usingBlock: {
                (asset : ALAsset!, index, stopEnumeration) -> Void in
                
                if (!stopped)
                {
                    print(savedVariables.numberOfPhotos)
                    
                    if count >= savedVariables.numberOfPhotos
                    {
                         self.progressLabel.text = "Analyzing photo \(count) of \(savedVariables.numberOfPhotos)"
                        //self.photoBeingTested.text = "Finshed"
                        //self.testBeingTested.text = ""
                        stopEnumeration.memory = ObjCBool(true)
                        stop.memory = ObjCBool(true)
                        completionBlock(images)
                        stopped = true
                        if(savedVariables.performingTest == true){
                            self.findAverage()
                            self.performSegueWithIdentifier("SegueToTestResults", sender: nil)
                        }
                        else{
                            //savedVariables.photoCount = 0
                            self.findAverage()
                            self.performSegueWithIdentifier("SegueToAddConcentrationValue", sender: nil)
                        }
                    }
                    else
                    {
                        // Use the following line for the full image.
                   
                        let cgImage = asset.defaultRepresentation().fullScreenImage().takeUnretainedValue()
                        _ = UIImage(CGImage: cgImage)
                        let image = UIImage(CGImage: cgImage)
                        print("***********")
                        print("The number of testAreas: \(savedVariables.numberOfTestAreas)")
                        print("***********")
                        images.append(image)
                        for var subIndex = 0; subIndex < savedVariables.numberOfTestAreas; subIndex++ {
                            let x      = savedVariables.xCoordinateArray[subIndex]
                            let y      = savedVariables.yCoordinateArray[subIndex]
                            let radius = savedVariables.radiusArray[subIndex]
                            let xLoc   = (x as NSString).integerValue
                            let yLoc   = (y as NSString).integerValue
                            print("Testing \(xLoc) \(yLoc) \n")
                            let rad    = (radius as NSString).integerValue
                            self.analyze(xLoc,y: yLoc,radius: rad,optimization: 5, testImagine: images[count], testArea: subIndex, photoUsed: count)
                        }
                        
                        print(images)
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
        //photoBeingTested.text = "Photo \(photoUsed) of \(savedVariables.numberOfPhotos)"
        //testBeingTested.text = "Test Area \(testArea) of \(savedVariables.numberOfTestAreas)"
        progressLabel.text = "Analyzing photo \(photoUsed) of \(savedVariables.numberOfPhotos)"
        print("**************************")
        print("The photo is \(photoUsed)")
        print("The testArea is \(testArea)")
        print("**************************")
        
        
        let tempX = ((x) - (radius/2))*2
        let tempY = ((y) - (radius/2))*2

        
        
        var position = CGPoint(x: tempX, y: tempY)
        print(position)
        print(radius*2)
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
        //var flag = false
        
        
        for var xIndex = 0; xIndex < radius*2; xIndex++ {
            for var yIndex = 0; yIndex < radius*2; yIndex++ {
                position = CGPoint(x: tempX + xIndex, y: tempY + yIndex)
                //println(position)
                // Use your extension
                let colour = testImagine.getPixelColor(position)
                
                colour.getRed(&redval, green: &greenval, blue: &blueval, alpha:&alphaval)
                //print("x=\(tempX + xIndex), y=\(tempY + yIndex) .. red: \(redval*255), green: \(greenval*255), blue: \(blueval*255)")
                redSum = redSum + redval
                greenSum = greenSum + greenval
                blueSum = blueSum + blueval
                alphaSum = alphaSum + alphaval
                totalLoops = totalLoops + 1
            }
        }
        //if(flag == true){
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
            
            //Note pictures are being pulled in the reverse order.
            let tempInstance = (savedVariables.numberOfPhotos - 1) - photoUsed
            savedVariables.redArray[testArea][tempInstance]       = Double(avgRed*255.0)
            savedVariables.greenArray[testArea][tempInstance]     = Double(avgGreen*255.0)
            savedVariables.blueArray[testArea][tempInstance]      = Double(avgBlue*255.0)
        
            /*
            print("**************************")
            print("The photo is \(photoUsed)")
            print("The testArea is \(testArea)")
            print("**************************")
    
            print("**************************")
            print("The cal red is \(savedVariables.redArray[testArea][photoUsed])")
            print("The cal green is \(savedVariables.greenArray[testArea][photoUsed])")
            print("The cal blue is \(savedVariables.blueArray[testArea][photoUsed])")
            print("**************************")
            */
        //}
    }
    
    
    
    func findAverage(){
        print("The number of photos \(savedVariables.numberOfPhotos)")
        print("The number of test areas \(savedVariables.numberOfTestAreas)")
        
        var redSum   = 0.0
        var greenSum = 0.0
        var blueSum  = 0.0
        //var alphaSum = 0.0

        var redSlopeSum = 0.0
        var greenSlopeSum = 0.0
        var blueSlopeSum = 0.0
        
        //xIndex is the test area.
        //yIndex is the test instance.
        for var xIndex = 0; xIndex < savedVariables.numberOfTestAreas; xIndex++ {
        
            redSum   = 0.0
            greenSum = 0.0
            blueSum  = 0.0
            
            redSlopeSum = 0.0
            greenSlopeSum = 0.0
            blueSlopeSum = 0.0
            
            //Note this decreases (yIndex--) since the photos are being pulled in reverse.
            for var yIndex = 0; yIndex < savedVariables.numberOfPhotos; yIndex++ {
                print(yIndex)
                if(savedVariables.markPhotosArray[xIndex][yIndex] == 1){
                    print("Test Area: \(savedVariables.numberOfTestAreas)")
                    print(yIndex)
                    redSum = redSum + savedVariables.redArray[xIndex][yIndex]
                    greenSum = greenSum + savedVariables.greenArray[xIndex][yIndex]
                    blueSum = blueSum + savedVariables.blueArray[xIndex][yIndex]
                    
                    
                    //print("The type of test for \(yIndex): \(savedVariables.typeOfTestArray[xIndex])")
                    //if(savedVariables.performingTest == false){
                    if(savedVariables.takeSlopeDataArray[xIndex] as! String == "True"){
                        
                        let doubleIntervalTime = (savedVariables.intervalTestTimeArray[xIndex] as! NSString).doubleValue
                        let doubleEndTime = (savedVariables.totalTestTimeArray[xIndex] as! NSString).doubleValue
                        
                        
                        
                        //No previous slopes exist.
                        if(yIndex == 0){
                            savedVariables.previousRedValue = savedVariables.redArray[xIndex][yIndex]
                            savedVariables.previousGreenValue = savedVariables.greenArray[xIndex][yIndex]
                            savedVariables.previousBlueValue = savedVariables.blueArray[xIndex][yIndex]
                        }
                        
                        
                        //Have to factor in the first photo into the slope and is not == 1.
                        else if(yIndex == 1 && doubleIntervalTime != 1){
                            //Note: since I taking the slope in the format (a-b/c-d).  I reduce the yIndex by 1 since yIndex == 0 data is invalid.
                            savedVariables.slopeRedArray[xIndex][yIndex-1] = (savedVariables.redArray[xIndex][yIndex] - savedVariables.previousRedValue) / (doubleIntervalTime - 1)
                            savedVariables.slopeGreenArray[xIndex][yIndex-1] = (savedVariables.greenArray[xIndex][yIndex] - savedVariables.previousGreenValue) / (doubleIntervalTime - 1)
                            savedVariables.slopeBlueArray[xIndex][yIndex-1] = (savedVariables.blueArray[xIndex][yIndex] - savedVariables.previousBlueValue) / (doubleIntervalTime - 1)
                            
                            redSlopeSum = redSlopeSum + savedVariables.slopeRedArray[xIndex][yIndex-1]
                            greenSlopeSum = greenSlopeSum + savedVariables.slopeGreenArray[xIndex][yIndex-1]
                            blueSlopeSum = blueSlopeSum + savedVariables.slopeBlueArray[xIndex][yIndex-1]
                            
                            savedVariables.previousRedValue = savedVariables.redArray[xIndex][yIndex]
                            savedVariables.previousGreenValue = savedVariables.greenArray[xIndex][yIndex]
                            savedVariables.previousBlueValue = savedVariables.blueArray[xIndex][yIndex]
                        
                        }
                        
                        else{
                            savedVariables.slopeRedArray[xIndex][yIndex-1] = (savedVariables.redArray[xIndex][yIndex] - savedVariables.previousRedValue) / doubleIntervalTime
                            savedVariables.slopeGreenArray[xIndex][yIndex-1] = (savedVariables.greenArray[xIndex][yIndex] - savedVariables.previousGreenValue) / doubleIntervalTime
                            savedVariables.slopeBlueArray[xIndex][yIndex-1] = (savedVariables.blueArray[xIndex][yIndex] - savedVariables.previousBlueValue) / doubleIntervalTime
                            
                            redSlopeSum = redSlopeSum + savedVariables.slopeRedArray[xIndex][yIndex-1]
                            greenSlopeSum = greenSlopeSum + savedVariables.slopeGreenArray[xIndex][yIndex-1]
                            blueSlopeSum = blueSlopeSum + savedVariables.slopeBlueArray[xIndex][yIndex-1]
                            
                            savedVariables.previousRedValue = savedVariables.redArray[xIndex][yIndex]
                            savedVariables.previousGreenValue = savedVariables.greenArray[xIndex][yIndex]
                            savedVariables.previousBlueValue = savedVariables.blueArray[xIndex][yIndex]
                        }
                        
                        //Without if statement prints will cause array out of index error, specifally yIndex - 1 = -1.
                        if(yIndex != 0){
                            print("*********")
                            print("Red Slope: \(savedVariables.slopeRedArray[xIndex][yIndex-1])")
                            print("Green Slope: \(savedVariables.slopeGreenArray[xIndex][yIndex-1])")
                            print("Blue Slope: \(savedVariables.slopeBlueArray[xIndex][yIndex-1])")
                            print("*********")
                        }
                    }
                    //}
                    
                    
                    
                }
                }
            print("The redSum is \(redSum)")
            print("The greenSum is \(greenSum)")
            print("The blueSum is \(blueSum)")
            
            let totalTime:Int = Int(savedVariables.totalTestTimeArray[xIndex] as! String)!
            let intervalTime:Int = Int(savedVariables.intervalTestTimeArray[xIndex] as! String)!
            print(totalTime)
            print(intervalTime)
            
            //The plus 1.0 is because of the first photo taken.
            /*The reason for the else statement is that there is always a photo taken at 1 second.  Because the interval time 
            does not factor in this first photo if the intervalTime > 1, 1.0 must be added to the divisor.*/
            var divisor = 1.0
            var slopeDivisor = 1.0

            if(intervalTime == 1){
               divisor = Double(totalTime/intervalTime)
               //Edge Case; total time == 1 && interval time == 1
                if(divisor == 1){
                    slopeDivisor = divisor
                }
                else{
                    slopeDivisor = (divisor - 1)
                }
               print("The divisor is \(divisor)")
            }
            else{
                divisor = Double(totalTime/intervalTime) + 1.0
                slopeDivisor = Double(totalTime/intervalTime)
                print("The divisor is \(divisor)")
            }
            
            if(savedVariables.takeSlopeDataArray[xIndex] as! String == "True"){
                print("Success")
                savedVariables.calibrationRedArray[xIndex][savedVariables.instanceCount] = redSlopeSum/slopeDivisor
                savedVariables.calibrationGreenArray[xIndex][savedVariables.instanceCount] = greenSlopeSum/slopeDivisor
                savedVariables.calibrationBlueArray[xIndex][savedVariables.instanceCount] = blueSlopeSum/slopeDivisor
            }
            else if(savedVariables.typeOfTestArray[xIndex] as! String == "End-Point"){
                savedVariables.calibrationRedArray[xIndex][savedVariables.instanceCount] = redSum
                savedVariables.calibrationGreenArray[xIndex][savedVariables.instanceCount] = greenSum
                savedVariables.calibrationBlueArray[xIndex][savedVariables.instanceCount] = blueSum
            }
            else{
                print(xIndex)
                print(savedVariables.typeOfTestArray[xIndex])
                print(savedVariables.takeSlopeDataArray[xIndex])
                print(savedVariables.takeSlopeDataArray)
                
                savedVariables.calibrationRedArray[xIndex][savedVariables.instanceCount] = redSum/divisor
                savedVariables.calibrationGreenArray[xIndex][savedVariables.instanceCount] = greenSum/divisor
                savedVariables.calibrationBlueArray[xIndex][savedVariables.instanceCount] = blueSum/divisor
            }
            
            print("**************************")
            //print("The instance is \(savedVariables.instanceCount)")
            print("The average RED is \(savedVariables.calibrationRedArray[xIndex][savedVariables.instanceCount])")
            print("The average GREEN is \(savedVariables.calibrationGreenArray[xIndex][savedVariables.instanceCount])")
            print("The average BLUE is \(savedVariables.calibrationBlueArray[xIndex][savedVariables.instanceCount])")
            print("**************************")
            
        }
    }
    
    

    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressLabel.text = "Analyzing photo 1 of \(savedVariables.numberOfPhotos)"
        print(savedVariables.markPhotosArray)
        onlyStartOneTestFlag = 1
        
        //Hides back button
        navigationItem.hidesBackButton = true
        
        getLatestPhotos(completion: { images in
            print(images)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}