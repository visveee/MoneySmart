//
//  InvestmentManagerAPI.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import Foundation

struct Config: Codable {
    let apiKey: String
}

func readApiKeyFromConfig() -> String? {
    guard let url = Bundle.main.url(forResource: "config", withExtension: "json") else {
        print("Config file not found.")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let config = try decoder.decode(Config.self, from: data)
        return config.apiKey
    } catch {
        print("Error reading config file:", error)
        return nil
    }
}

func configureAPIKey() {
    if let apiKey = readApiKeyFromConfig() {
        print("API Key:", apiKey)
    }
}

// Enum to represent different symbols (e.g., stocks)
enum Symbol: String {
    case AAPL // Apple Inc.
    case MSFT // Microsoft Corporation
    // Add more symbols as needed
}

// Enum to represent different functions (e.g., metrics)
enum Function: String {
    case TIME_SERIES_MONTHLY // Monthly time series
    case GLOBAL_QUOTE // Global quote
    // Add more functions as needed
}

class AlphaVantageAPI {
    static let shared = AlphaVantageAPI()
    
    private let apiKey = "YOUR_ALPHA_VANTAGE_API_KEY_HERE"
    
    private init() {}
    
    func fetchInvestments(symbol: Symbol, function: Function, completion: @escaping (Result<[Investment], Error>) -> Void) {
        let urlString = "https://www.alphavantage.co/query?function=\(function.rawValue)&symbol=\(symbol.rawValue)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let investments = try JSONDecoder().decode([Investment].self, from: data)
                completion(.success(investments))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct InvestmentManagerAPI {
    
    func fetchStockData(function: String, symbol: String, options: [String]) {
        // Construct the command with function, symbol, and options
        var command = ["sav", "stock", function, symbol] + options
        
        // Execute the command
        let task = Process()
        task.launchPath = "/usr/bin/env" // Assuming `sav` is installed in the system path
        task.arguments = command
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        // Handle the output (parse or display as needed)
        print("Stock Data:", output ?? "No data received")
    }
    
}
