import UIKit
import AVFoundation

//Could convert this to a new function for better OO design. 
//Function is called in PanelTypeOfTestViewController.
/*
func getHighestTotalTestTime(){
    
    as this...
    func setHighestTotalTestTime(){
        //print("The current highest total time is : \(savedVariables.highestTotalTime)")
        
        let totalTestTimeToInt = Int(totalTestTimeTextField.text!)
        if(savedVariables.highestTotalTime < totalTestTimeToInt!){
            savedVariables.highestTotalTime = totalTestTimeToInt!
            //print("Highest Total Time: \(totalTestTimeToInt)")
        }
    }
    
}*/


func addToTimingArray(intervalVal: Int){
    
    var addFlag = true
    
    /*if(savedVariables.timingArray.count == 0){
        addFlag = false
    }*/
    
    //Need to check pervious values of timing array.
    for var i = 0; i < savedVariables.timingArray.count; i++ {
        if(intervalVal % savedVariables.timingArray[i] == 0){
            addFlag = false
        }
    }

    if(addFlag == true){
        savedVariables.timingArray += [intervalVal]
        print("addToTimingArray: \(intervalVal) added to timingArray.")
    }
    else{
        print("addToTimingArray: \(intervalVal) NOT added to timingArray.")
    }
    
}