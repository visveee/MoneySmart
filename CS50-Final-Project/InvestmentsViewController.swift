//
//  InvestmentsViewController.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import UIKit

class InvestmentsViewController: UIViewController {
    
    // MARK: - Properties
    
    // Example properties (replace with your own)
    private var investments: [Investment] = []
    private var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchInvestmentData()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        // Set up table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func fetchInvestmentData() {
        // Fetch investment data from your backend or local storage
        // Example of fetching data from a hypothetical API
        APIManager.shared.fetchInvestments(context: <#NSManagedObjectContext#>) { [weak self] result in
            switch result {
            case .success(let investments):
                self?.investments = investments
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch investments: \(error)")
            }
        }
    }
    
}

// MARK: - UITableView DataSource & Delegate

extension InvestmentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return investments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let investment = investments[indexPath.row]
        // Configure cell with investment data
        cell.textLabel?.text = "\(investment.name): \(investment.amount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle selection if needed
    }
    
}
