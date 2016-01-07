/*import UIKit
import AVFoundation
import AssetsLibrary
import Photos
import CoreData


import Charts


class test: UIViewController {
    
    @IBOutlet var barView: BarChartView!
    
    @IBOutlet var scatterView: ScatterChartView!
    
    var months: [String]!
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        //barView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        var scatEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            let scatterEntry = ChartDataEntry(value: values[i], xIndex: i)
            scatEntries.append(scatterEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
        let scatDataSet = ScatterChartDataSet(yVals: scatEntries, label: "Units Sold")
        let scatData = ScatterChartData(xVals: months, dataSet: scatDataSet)
        scatterView.data = chartData
        barView.data = scatData 
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //barView.noDataText = "CHeck"
        //barView.noDataText = "Date"
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        
       
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}*/