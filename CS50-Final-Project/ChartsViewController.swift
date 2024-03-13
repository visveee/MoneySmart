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
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configurePieChart()
        configureLineChart()
    }
    
    private func configurePieChart() {
        guard let pieChartView = pieChartView else {
            return
        }
        
        var dataEntries: [PieChartDataEntry] = []
        // Example data entries (replace with your own)
        dataEntries.append(PieChartDataEntry(value: 25.0, label: "Food"))
        dataEntries.append(PieChartDataEntry(value: 20.0, label: "Transportation"))
        dataEntries.append(PieChartDataEntry(value: 15.0, label: "Entertainment"))
        dataEntries.append(PieChartDataEntry(value: 40.0, label: "Others"))
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = ChartColorTemplates.joyful()
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.centerText = "Expenses"
        pieChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutBack)
    }
    
    private func configureLineChart() {
        guard let lineChartView = lineChartView else {
            return
        }
        
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
    
    // MARK: - Actions
    
    @IBAction func addExpenseButtonTapped(_ sender: UIButton) {
        // Example of adding an expense
        addExpense(50.0, category: "Food", note: "Lunch with friends")
    }
    
    @IBAction func deleteExpenseButtonTapped(_ sender: UIButton) {
        // Example of deleting an expense
        guard !expenses.isEmpty else {
            return
        }
        deleteExpense(at: 0)
    }
    
    // MARK: - Data Management
    
    func addExpense(_ amount: Double, category: String, note: String?) {
        // Implementation of adding expense
    }
    
    func deleteExpense(at index: Int) {
        // Implementation of deleting expense
    }
    
    // Additional methods for handling user interactions, navigation, etc.
    
}
