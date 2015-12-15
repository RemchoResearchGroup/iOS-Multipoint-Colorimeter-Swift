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
    static var concertationArray = [AnyObject] ()
    static var concertationValueArray = [AnyObject] ()
    static var typeOfTestArray = [AnyObject] ()
    static var totalTestTimeArray = [AnyObject] ()
    static var intervalTestTimeArray = [AnyObject] ()
    static var initalCalibrationTesting = false
    
    static var timingArray = [Int] ()
    
    static var highestTotalTime = 0
    
    
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
    
    static var redArray = [AnyObject] ()
    static var greenArray = [AnyObject] ()
    static var blueArray = [AnyObject] ()
    static var hueArray = [AnyObject] ()
    static var saturationArray = [AnyObject] ()
    static var valueArray = [AnyObject] ()
    //static var concentrationArray = [[Int]]()
    //static var photoCount = 0
    //static var concentrationArray = Array<Array<Double>>()
    //static var instanceCount = 0

    static var concentrationArray         = Array<Array<Double>>()
    static var calibrationRedArray        = Array<Array<Double>>()
    static var calibrationGreenArray      = Array<Array<Double>>()
    static var calibrationBlueArray       = Array<Array<Double>>()
    static var calibrationHueArray        = Array<Array<Double>>()
    static var calibrationSaturationArray = Array<Array<Double>>()
    static var calibrationValueArray      = Array<Array<Double>>()
    
    

    /*static var xCord  = Array<Array<Double>>()
    static var yCord  = Array<Array<Double>>()
    static var radius = Array<Array<Double>>()
    static var slope       = Array<Array<Double>>()
    static var intercept   = Array<Array<Double>>()*/
  
    static var countTracker = 0
    static var firstCal = true
    
}



