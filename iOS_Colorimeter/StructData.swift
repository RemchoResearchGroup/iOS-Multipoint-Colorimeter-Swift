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
    static var typeOfTestArray = [AnyObject] ()
    static var totalTestTimeArray = [AnyObject] ()
    static var intervalTestTimeArray = [AnyObject] ()
    
    static var currentTestArea = 1
    
    static var testTime = ""
    static var intervalTime = ""
    
    
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
    
    
    
}



