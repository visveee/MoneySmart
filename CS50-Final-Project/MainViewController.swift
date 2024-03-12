//
//  MainViewController.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var expenses: [Expense] = []
    var budgets: [Budget] = []
    var incomes: [Income] = []
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInitialData()
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func fetchInitialData() {
        fetchExpenses()
        fetchBudgets()
        fetchIncomes()
    }
    
    private func configureUI() {
        // Configure UI elements
        // Example: Update labels, tables, etc.
    }
    
    // MARK: - Expense Tracking
    
    func fetchExpenses() {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            expenses = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching expenses: \(error.localizedDescription)")
        }
    }
    
    func addExpense(_ amount: Double, category: String, note: String?) {
        let newExpense = Expense(context: managedObjectContext)
        newExpense.amount = amount
        newExpense.category = category
        newExpense.timestamp = Date()
        newExpense.note = note
        
        do {
            try managedObjectContext.save()
            expenses.append(newExpense)
            // Update UI
        } catch {
            print("Error saving expense: \(error.localizedDescription)")
        }
    }
    
    func deleteExpense(at index: Int) {
        let expenseToDelete = expenses[index]
        managedObjectContext.delete(expenseToDelete)
        
        do {
            try managedObjectContext.save()
            expenses.remove(at: index)
            // Update UI
        } catch {
            print("Error deleting expense: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Budget Management
    
    func fetchBudgets() {
        let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest()
        do {
            budgets = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching budgets: \(error.localizedDescription)")
        }
    }
    
    func addBudget(_ category: String, limit: Double) {
        let newBudget = Budget(context: managedObjectContext)
        newBudget.category = category
        newBudget.limit = limit
        
        do {
            try managedObjectContext.save()
            budgets.append(newBudget)
            // Update UI
        } catch {
            print("Error saving budget: \(error.localizedDescription)")
        }
    }
    
    func deleteBudget(at index: Int) {
        let budgetToDelete = budgets[index]
        managedObjectContext.delete(budgetToDelete)
        
        do {
            try managedObjectContext.save()
            budgets.remove(at: index)
            // Update UI
        } catch {
            print("Error deleting budget: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Income Tracking
    
    func fetchIncomes() {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        do {
            incomes = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching incomes: \(error.localizedDescription)")
        }
    }
    
    func addIncome(_ amount: Double, source: String) {
        let newIncome = Income(context: managedObjectContext)
        newIncome.amount = amount
        newIncome.source = source
        newIncome.timestamp = Date()
        
        do {
            try managedObjectContext.save()
            incomes.append(newIncome)
            // Update UI
        } catch {
            print("Error saving income: \(error.localizedDescription)")
        }
    }
    
    func deleteIncome(at index: Int) {
        let incomeToDelete = incomes[index]
        managedObjectContext.delete(incomeToDelete)
        
        do {
            try managedObjectContext.save()
            incomes.remove(at: index)
            // Update UI
        } catch {
            print("Error deleting income: \(error.localizedDescription)")
        }
    }
    
    // Additional methods for handling user interactions, navigation, etc.
    
}
