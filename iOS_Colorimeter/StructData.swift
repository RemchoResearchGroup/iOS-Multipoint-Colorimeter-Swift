//Struct used for referencing the models in the Take Measurement table
struct modelStored {
    static var modelTest = 0
    
    //For every model added, a number need to increase for the modelTable to sort the data
    
}

struct savedVariables {
    
    /*****************
    For Creating Panels
    ******************/
     
    //Maintains progress for creating panel and manages containers
    //0 = Name Panel Stage
    static var createPanelProgress = 0
    static var panelName = ""
    static var numberOfTestAreas = 0
    //Flag used to indicate whether to fill the testArrayName and conertationArray with empty data.
    //1 is first time, 0 is not the first time.
    static var firstTestAreaFlag = 0
    static var testAreaNameArray = [AnyObject] ()
    static var concentrationArray = [AnyObject] ()
    static var concentrationValueArray = [AnyObject] ()
    static var typeOfTestArray = [AnyObject] ()
    static var totalTestTimeArray = [AnyObject] ()
    static var intervalTestTimeArray = [AnyObject] ()
    static var takeSlopeDataArray = [AnyObject] ()
    static var initalCalibrationTesting = false
    
    static var timingArray = [Int] ()
    
    static var highestTotalTime = 0
    
    static var testSelected = 0
    
    static var currentTestArea = 1
    
    static var testTime = ""
    static var intervalTime = ""
    
    static var currentTestNumber = 0 
    
    
    static var performingCal = false
    
    //For editing panel name. 
    
    
    static var numberOfPhotos = 0
    //For storing the model area data.
    static var testAreaInfo = ""
    static var radiusArray = [String] ()
    static var xCoordinateArray = [String] ()
    static var yCoordinateArray = [String] ()
    //static var testAreaNameArray = [String] ()
    static var unitsNameArray = [String] ()
    static var slopeArray = [String] ()
    static var interceptArray = [String] ()
    
    
    static var channelUsed = [String] ()    
    static var performingTest = false

    static var markPhotosArray = Array<Array<Double>>()
    
    static var instanceCount = 0
    
    static var redArray        = Array<Array<Double>>()
    static var greenArray      = Array<Array<Double>>()
    static var blueArray       = Array<Array<Double>>()
    static var hueArray        = Array<Array<Double>>()
    static var saturationArray = Array<Array<Double>>()
    static var valueArray      = Array<Array<Double>>()

    static var concentrationMultipleArray         = Array<Array<Double>>()
    static var calibrationRedArray        = Array<Array<Double>>()
    static var calibrationGreenArray      = Array<Array<Double>>()
    static var calibrationBlueArray       = Array<Array<Double>>()
    static var calibrationHueArray        = Array<Array<Double>>()
    static var calibrationSaturationArray = Array<Array<Double>>()
    static var calibrationValueArray      = Array<Array<Double>>()
    
    static var calibrationSlopeRedArray        = Array<Array<Double>>()
    static var calibrationSlopeGreenArray      = Array<Array<Double>>()
    static var calibrationSlopeBlueArray       = Array<Array<Double>>()
    
    static var slopeRedArray        = Array<Array<Double>>()
    static var slopeGreenArray      = Array<Array<Double>>()
    static var slopeBlueArray       = Array<Array<Double>>()
    static var slopeHueArray        = Array<Array<Double>>()
    static var slopeSaturationArray = Array<Array<Double>>()
    static var slopeValueArray      = Array<Array<Double>>()
    
    static var conRedArray          = Array<Array<Double>>()
    static var conGreenArray        = Array<Array<Double>>()
    static var conBlueArray         = Array<Array<Double>>()

  
    static var countTracker = 0
    static var firstCal = true
    
    static var previousRedValue = 0.0
    static var previousGreenValue = 0.0
    static var previousBlueValue = 0.0
    

}



