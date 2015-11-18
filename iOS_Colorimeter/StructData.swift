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
    
    //For editing panel name. 
    
    
    
}



