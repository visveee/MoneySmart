//
//  AuthenticationManager.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//

import Foundation
import LocalAuthentication

class AuthenticationManager {
    
    // MARK: - Properties
    
    static let shared = AuthenticationManager()
    private let context = LAContext()
    
    // MARK: - Public Methods
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        if canUseBiometricAuthentication() {
            authenticateWithBiometrics(completion: completion)
        } else {
            // Fall back to password authentication
            // Implement your own custom password authentication logic here
        }
    }
    
    // MARK: - Private Methods
    
    private func canUseBiometricAuthentication() -> Bool {
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    private func authenticateWithBiometrics(completion: @escaping (Bool, Error?) -> Void) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access your financial data") { (success, error) in
            DispatchQueue.main.async {
                if success {
                    completion(true, nil)
                } else {
                    if let error = error {
                        completion(false, error)
                    } else {
                        // User canceled authentication
                        completion(false, nil)
                    }
                }
            }
        }
    }
}
