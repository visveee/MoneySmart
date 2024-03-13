//
//  ContentView.swift
//  CS50-Final-Project
//
//  Created by Nikhil Veeramachaneni on 3/12/24.
//
// I was assisted in the creation of this ContentView file by ChatGPT 3.5 since I did not have much experience with frontend development in Swift for iOS applications; however, I aimed to learn while implementing this app, and hte brunt of the actual UI implementation (e.g. in struct MainViewControllerRepresentable is my own code.

import SwiftUI

struct MainView: View {
    var body: some View {
        MainViewControllerRepresentable()
            .tabItem {
                Label("Home", systemImage: "house")
            }
    }
}

struct ChartsView: View {
    var body: some View {
        ChartsViewControllerRepresentable()
            .tabItem {
                Label("Charts", systemImage: "chart.pie.fill")
            }
    }
}

struct InvestmentsView: View {
    var body: some View {
        InvestmentsViewControllerRepresentable()
            .tabItem {
                Label("Investments", systemImage: "dollarsign.square.fill")
            }
    }
}

// Define MainViewControllerRepresentable here
struct MainViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        // Update UI if needed
    }
}

// Define ChartsViewControllerRepresentable here
struct ChartsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ChartsViewController {
        return ChartsViewController()
    }
    
    func updateUIViewController(_ uiViewController: ChartsViewController, context: Context) {
        // Update UI if needed
    }
}

// Define InvestmentsViewControllerRepresentable here
struct InvestmentsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> InvestmentsViewController {
        return InvestmentsViewController()
    }
    
    func updateUIViewController(_ uiViewController: InvestmentsViewController, context: Context) {
        // Update UI if needed
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
            ChartsView()
            InvestmentsView()
            // Add other views here
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
