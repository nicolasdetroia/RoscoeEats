//  SignUpView.swift
//  RoscoeEats
//  Created by Nicolas DeTroia on 4/9/25.

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var appState: AppState
    @Binding var hasSignedUp: Bool
    
    // Form fields
    @State var name: String = ""
    @State var email: String = ""
    @State var weight: String = ""
    @State var age: String = ""
    @State var height: String = ""
    @State var dietaryPreference: String = ""
    @State var dailyCalorieGoal: String = ""
    
    @State var errorMessage: String = ""
    @State var isSubmitting: Bool = false
    
    // Colors
    let primaryColor = Color(red: 0.1, green: 0.4, blue: 0.3)
    let accentColor = Color(red: 0.9, green: 0.5, blue: 0.1)
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 0.97, blue: 0.98),
                        Color(red: 0.85, green: 0.9, blue: 0.92)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Text("Welcome to RoscoeEats")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(primaryColor)
                            
                            Text("Create your profile")
                                .font(.system(.body, design: .rounded))
                                .foregroundStyle(.gray)
                        }
                        .padding(.top, 32)
                        
                        // Form Fields
                        VStack(spacing: 16) {
                            FormField(label: "Name", text: $name, placeholder: "Enter your name")
                            FormField(label: "Email (TCNJ only)", text: $email, placeholder: "yourname@tcnj.edu")
                            FormField(label: "Weight (lbs)", text: $weight, placeholder: "e.g., 150", keyboardType: .decimalPad)
                            FormField(label: "Age", text: $age, placeholder: "e.g., 20", keyboardType: .numberPad)
                            FormField(label: "Height (inches)", text: $height, placeholder: "e.g., 65", keyboardType: .decimalPad)
                            FormField(label: "Dietary Preference", text: $dietaryPreference, placeholder: "e.g., Vegan")
                            FormField(label: "Daily Calorie Goal", text: $dailyCalorieGoal, placeholder: "e.g., 2000", keyboardType: .decimalPad)
                        }
                        .padding(.horizontal, 24)
                        
                        // Error Message
                        Text(errorMessage)
                            .font(.callout)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 24)
                            .opacity(errorMessage.isEmpty ? 0 : 1)
                        
                        // Submit Button
                        Button(action: submitForm) {
                            if isSubmitting {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Sign Up")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                        }
                        .frame(maxWidth: 200)
                        .padding(.vertical, 12)
                        .foregroundStyle(.white)
                        .background(accentColor)
                        .clipShape(Capsule())
                        .disabled(isSubmitting)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func submitForm() {
        errorMessage = ""
        isSubmitting = true
        
        // Validation
        guard !name.isEmpty else {
            errorMessage = "Please enter your name"
            isSubmitting = false
            return
        }
        
        guard email.lowercased().hasSuffix("@tcnj.edu") else {
            errorMessage = "Please use a valid TCNJ email"
            isSubmitting = false
            return
        }
        
        guard let weightValue = Double(weight), weightValue > 0 else {
            errorMessage = "Please enter a valid weight"
            isSubmitting = false
            return
        }
        
        guard let ageValue = Int(age), ageValue > 0 else {
            errorMessage = "Please enter a valid age"
            isSubmitting = false
            return
        }
        
        guard let heightValue = Double(height), heightValue > 0 else {
            errorMessage = "Please enter a valid height"
            isSubmitting = false
            return
        }
        
        guard !dietaryPreference.isEmpty else {
            errorMessage = "Please enter a dietary preference"
            isSubmitting = false
            return
        }
        
        guard let calorieGoalValue = Double(dailyCalorieGoal), calorieGoalValue > 0 else {
            errorMessage = "Please enter a valid calorie goal"
            isSubmitting = false
            return
        }
        
        // Simulate submission
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.appState.updateUserProfile(
                name: self.name,
                email: self.email,
                weight: weightValue,
                age: ageValue,
                height: heightValue,
                dietaryPreference: self.dietaryPreference,
                dailyCalorieGoal: calorieGoalValue
            )
            self.hasSignedUp = true
            self.isSubmitting = false
        }
    }
}

// MARK: - Form Field Component
struct FormField: View {
    let label: String
    @Binding var text: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.callout)
                .foregroundStyle(.gray)
            
            TextField(placeholder, text: $text)
                .font(.body)
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .keyboardType(keyboardType)
                .submitLabel(.next)
        }
    }
}

// MARK: - Preview
#Preview {
    SignupView(hasSignedUp: .constant(false))
        .environmentObject(AppState())
}
