// AppState.swift
// RoscoeEats

import Foundation

class AppState: ObservableObject {
    func updateUserProfile(
        name: String,
        email: String,
        weight: Double,
        age: Int,
        height: Double,
        dietaryPreference: String,
        dailyCalorieGoal: Double
    ) {
        // Implement your profile update logic here
        print("Profile updated: \(name), \(email), Weight: \(weight), Age: \(age), Height: \(height), Preference: \(dietaryPreference), Calorie Goal: \(dailyCalorieGoal)")
    }
}
