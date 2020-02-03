//
//  LineChartViewController.swift
//  ChartsTutorial
//
//  Created by Duy Bui on 4/20/19.
//  Copyright © 2019 iOSTemplates. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {

    @IBOutlet var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart(dataPoints: months, values: spending.map{ Double($0) })
    }

    
    func setChart(dataPoints: [String], values: [Double]) {
        lineChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
