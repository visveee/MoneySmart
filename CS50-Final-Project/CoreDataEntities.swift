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
