import UIKit
import Charts

class test: UIViewController {
 
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet var scatterPlot: ScatterChartView!
    
    @IBOutlet var comboChart: CombinedChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
    
        
        let scatterChartDataSet = ScatterChartDataSet(yVals: dataEntries, label: "test")
        let scatterChartData = ScatterChartData(xVals: dataPoints, dataSet: scatterChartDataSet)
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        
        //comboChart.data = scatterChartData
     
        //var scatterDataEntries: [ChartDataSet] = [scatterChartDataSet, lineChartDataSet]
        //var a  = ChartDataSet(yVals: dataEntries, label: "a")
        
        //let combineChartData = CombinedChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        let combineChartData = CombinedChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        combineChartData.scatterData = scatterChartData
        combineChartData.lineData = lineChartData 
        //lineChartView.data = lineChartData
        scatterPlot.data = scatterChartData
        comboChart.data = combineChartData
    }
    
}