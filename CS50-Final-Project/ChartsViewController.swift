//
//  ChartsViewController.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {
    
    // Define IBOutlet properties for chart views
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Implement viewDidLoad logic
        
        // Configure chart views with data and styling
        configurePieChart()
        configureLineChart()
    }
    
    // MARK: - Chart Configuration
    
    private func configurePieChart() {
        // Configure pie chart data and styling
        var dataEntries: [PieChartDataEntry] = []
        // Example data entries (replace with your own)
        dataEntries.append(PieChartDataEntry(value: 25.0, label: "Food"))
        dataEntries.append(PieChartDataEntry(value: 20.0, label: "Transportation"))
        dataEntries.append(PieChartDataEntry(value: 15.0, label: "Entertainment"))
        dataEntries.append(PieChartDataEntry(value: 40.0, label: "Others"))
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: nil)
        dataSet.colors = ChartColorTemplates.joyful()
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.centerText = "Expenses"
        pieChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutBack)
    }
    
    private func configureLineChart() {
        // Configure line chart data and styling
        var dataEntries: [ChartDataEntry] = []
        // Example data entries (replace with your own)
        dataEntries.append(ChartDataEntry(x: 1.0, y: 1000.0))
        dataEntries.append(ChartDataEntry(x: 2.0, y: 1500.0))
        dataEntries.append(ChartDataEntry(x: 3.0, y: 2000.0))
        dataEntries.append(ChartDataEntry(x: 4.0, y: 1800.0))
        dataEntries.append(ChartDataEntry(x: 5.0, y: 2500.0))
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Income")
        dataSet.colors = [NSUIColor.blue]
        
        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        lineChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutBack)
    }
    
    // Implement methods to populate charts with financial data
    
    // Implement functionality to display insights based on user's financial data
    
}
