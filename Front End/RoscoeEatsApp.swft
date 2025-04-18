//
//  RoscoeEatsApp.swift
//  Stealth-Startup-RoscoeEats
//
//  Created by Nicolas DeTroia on 4/9/25.
//

import SwiftUI

/// The main entry point for the RoscoeEats application.
/// This app leverages SwiftUI for a modern, declarative UI experience.
@main
struct RoscoeEatsApp: App {
    // MARK: - Properties
    
    /// Shared app state for managing meal plans and user preferences.
    @StateObject private var appState = AppState()
    
    
    // MARK: - Scene
    
    /// Defines the primary window group for the app.
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(.light)
                .onAppear {
                    print("RoscoeEats app launched on \(Date())")
                }
        }
    }
}

/// A class to manage app-wide state, such as meal plans and user data.
/// Conforms to ObservableObject to enabwle SwiftUI reactivity.
class AppState: ObservableObject {
    /// Published property for meal plans, accessible across the app.
    @Published var mealPlans: [MealPlan] = []
    
    /// Published property for user-specific food requests (e.g., Eick’s picks).
    @Published var requestedFoods: [String] = []
    
    /// Initializes the app state with default values or persisted data.
    init() {
        // Placeholder for loading persisted data (e.g., from UserDefaults or a database)
    }
    
    /// Adds a meal plan to the state with animation support.
    func addMealPlan(_ mealPlan: MealPlan) {
        withAnimation(.easeInOut(duration: 0.5)) {
            mealPlans.append(mealPlan)
        }
    }
    
    /// Updates requested foods with animation support.
    func updateRequestedFoods(_ foods: [String]) {
        withAnimation(.easeInOut(duration: 0.5)) {
            requestedFoods = foods
        }
    }
}

// MARK: - Meal Plan Model

/// A model for meal plans, used app-wide.
struct MealPlan: Identifiable {
    let id = UUID()
    let day: String
    let mealName: String
    let foods: [String]
    let calories: Double
}
