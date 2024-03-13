//
//  CoreDataEntities.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import Foundation
import CoreData

// MARK: - Expense Entity

class Expense: NSManagedObject {
    @NSManaged var amount: NSDecimalNumber
    @NSManaged var category: String
    @NSManaged var note: String?
    @NSManaged var timestamp: Date
}

// MARK: - Budget Entity

class Budget: NSManagedObject {
    @NSManaged var category: String
    @NSManaged var limit: NSDecimalNumber
}

// MARK: - Income Entity

class Income: NSManagedObject {
    @NSManaged var amount: NSDecimalNumber
    @NSManaged var source: String
    @NSManaged var timestamp: Date
}

// MARK: - Investments Entity

class Investment: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var amount: Double
}


// MARK: - API Manager

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchInvestments(context: NSManagedObjectContext, completion: @escaping (Result<[Investment], Error>) -> Void) {
        // Implement code to fetch investments from your API
        // For demonstration purposes, return sample data
        let sampleInvestmentData = [
            ["name": "Stock A", "amount": 1000.0],
            ["name": "Stock B", "amount": 2000.0],
            // Add more sample investment data as needed
        ]
        
        var investments: [Investment] = []
        for data in sampleInvestmentData {
            if let name = data["name"] as? String, let amount = data["amount"] as? Double {
                let investment = NSEntityDescription.insertNewObject(forEntityName: "Investment", into: context) as! Investment
                investment.name = name
                investment.amount = amount
                investments.append(investment)
            }
        }
        
        completion(.success(investments))
    }
}
