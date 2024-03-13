//
//  MainViewController.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    // IBOutlets for displaying/editing values
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var isActiveSwitch: UISwitch!
    @IBOutlet weak var interestsTextView: UITextView!
    @IBOutlet weak var lastLoginLabel: UILabel!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Update UI elements with initial values
            usernameLabel.text = username
            ageTextField.text = String(age)
            balanceLabel.text = String(format: "$%.2f", balance)
            isActiveSwitch.isOn = isActive
            interestsTextView.text = interests.joined(separator: ", ")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy hh:mm:ss"
            lastLoginLabel.text = dateFormatter.string(from: lastLogin)
        }
        
        // IBAction for updating age variable when text field value changes
        @IBAction func ageTextFieldDidChange(_ sender: UITextField) {
            if let text = sender.text, let newAge = Int(text) {
                age = newAge
            }
        }
        
        // IBAction for toggling isActive variable when switch value changes
        @IBAction func isActiveSwitchDidChange(_ sender: UISwitch) {
            isActive = sender.isOn
        }
        
        // IBAction for updating interests variable when text view value changes
        @IBAction func interestsTextViewDidChange(_ sender: UITextView) {
            if let text = sender.text {
                interests = text.components(separatedBy: ", ")
            }
        }
    }

    // MARK: - Properties
    
    var username: String = "JohnDoe"
    var age: Int = 30
    var balance: Double = 1500.50
    var isActive: Bool = true
    var interests: [String] = ["Reading", "Traveling", "Cooking"]
    var lastLogin: Date = Date()
    var expenses: [Expense] = []
    var budgets: [Budget] = []
    var incomes: [Income] = []

    var managedObjectContext: NSManagedObjectContext = {
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
        newExpense.amount = NSDecimalNumber(value: amount)
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
        newBudget.limit = NSDecimalNumber(value: limit)
        
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
        newIncome.amount = NSDecimalNumber(value: amount)
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
    
    // MARK: - User Interaction Examples
    
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
    
    // Additional IBActions for other user interactions
