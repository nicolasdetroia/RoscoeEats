//
//  ContentView.swift
//  Stealth-Startup-RoscoeEats
//
//  Created by Nicolas DeTroia on 4/9/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    /// Access the shared app state via the environment.
    @EnvironmentObject private var appState: AppState
    
    // MARK: - Colors
    
    private let primaryColor = Color(red: 0.1, green: 0.4, blue: 0.3) // Deep teal
    private let accentColor = Color(red: 0.9, green: 0.5, blue: 0.1) // Vibrant orange
    private let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.95, green: 0.97, blue: 0.98),
            Color(red: 0.85, green: 0.9, blue: 0.92)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ProfilePageView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            AIMealPlannerPageView()
                .tabItem {
                    Label("Meal Planner", systemImage: "fork.knife")
                }
            
            RequestsPageView()
                .tabItem {
                    Label("Requests", systemImage: "list.bullet")
                }
        }
        .accentColor(accentColor) // Tab bar tint
        .background(backgroundGradient.edgesIgnoringSafeArea(.all))
        .onAppear {
            // Customize tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.white.opacity(0.95))
            appearance.shadowColor = UIColor.gray.withAlphaComponent(0.3)
            
            // Customize selected and unselected item appearance
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(primaryColor.opacity(0.5))
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(primaryColor.opacity(0.5)),
                .font: UIFont.systemFont(ofSize: 12, weight: .medium)
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(accentColor)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(accentColor),
                .font: UIFont.systemFont(ofSize: 12, weight: .bold)
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Home Page

struct HomePageView: View {
    private let primaryColor = Color(red: 0.1, green: 0.4, blue: 0.3)
    private let accentColor = Color(red: 0.9, green: 0.5, blue: 0.1)
    @State private var isAnimating = false
    
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
                
                VStack(spacing: 20) {
                    // Header with hero image
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [primaryColor, primaryColor.opacity(0.7)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 120, height: 120)
                            .shadow(color: primaryColor.opacity(0.3), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.white)
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .animation(.easeInOut(duration: 4).repeatForever(autoreverses: false), value: isAnimating)
                            .onAppear { isAnimating = true }
                    }
                    .padding(.top, 40)
                    
                    Text("Welcome to RoscoeEats")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(primaryColor)
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                    
                    Text("Your personal nutrition companion. Plan meals, track calories, and explore personalized food options with AI.")
                        .font(.system(.body, design: .rounded))
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    // Call-to-action button
                    NavigationLink(destination: AIMealPlannerPageView()) {
                        HStack {
                            Text("Get Started")
                            Image(systemName: "arrow.right")
                        }
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(accentColor)
                        .clipShape(Capsule())
                        .shadow(color: accentColor.opacity(0.4), radius: 6, x: 0, y: 3)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - AI Meal Planner Page

struct AIMealPlannerPageView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var isAnimating = false
    
    private let primaryColor = Color(red: 0.1, green: 0.4, blue: 0.3)
    private let accentColor = Color(red: 0.9, green: 0.5, blue: 0.1)
    
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
                
                VStack(spacing: 20) {
                    // Header
                    VStack {
                        Text("AI Meal Planner")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(primaryColor)
                            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        Button(action: generateMealPlan) {
                            HStack {
                                Image(systemName: "calendar")
                                Text("Plan My Week")
                            }
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 24)
                            .background(LinearGradient(
                                gradient: Gradient(colors: [accentColor, accentColor.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .clipShape(Capsule())
                            .shadow(color: accentColor.opacity(0.4), radius: 6, x: 0, y: 3)
                        }
                        .scaleEffect(isAnimating ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isAnimating)
                        .onAppear { isAnimating = true }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                    
                    ScrollView {
                        VStack(spacing: 25) {
                            mealPlanSection
                            foodRecognitionSection
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage, onImagePicked: recognizeFood)
            }
        }
    }
    
    private var mealPlanSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Next Week’s Meals")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(primaryColor)
                .padding(.horizontal)
            
            if appState.mealPlans.isEmpty {
                Text("Tap 'Plan My Week' to get started!")
                    .font(.system(.callout, design: .rounded))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
            } else {
                ForEach(appState.mealPlans) { plan in
                    HStack(spacing: 12) {
                        Image(systemName: "leaf.fill")
                            .foregroundStyle(accentColor)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(plan.day)
                                .font(.system(.caption, design: .rounded))
                                .foregroundStyle(.gray)
                            Text(plan.mealName)
                                .font(.system(.body, design: .rounded, weight: .semibold))
                                .foregroundStyle(primaryColor)
                            Text("Foods: \(plan.foods.joined(separator: ", "))")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(.gray)
                            Text("Calories: \(plan.calories, specifier: "%.0f") kcal")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
                    .padding(.horizontal)
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
    
    private var foodRecognitionSection: some View {
        VStack(spacing: 12) {
            Text("Snap a Meal")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(primaryColor)
                .padding(.horizontal)
            
            ZStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 3)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 180)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.gray.opacity(0.5))
                        )
                }
            }
            .padding(.horizontal)
            
            Button(action: { showingImagePicker = true }) {
                Text("Take Photo")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [primaryColor, primaryColor.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .clipShape(Capsule())
            }
            .shadow(color: primaryColor.opacity(0.3), radius: 6, x: 0, y: 3)
        }
    }
    
    private func generateMealPlan() {
        let days = ["Apr 10", "Apr 11", "Apr 12", "Apr 13", "Apr 14", "Apr 15", "Apr 16"]
        let newPlans = days.map { day in
            MealPlan(day: day, mealName: "Dinner", foods: ["chicken breast", "brown rice", "broccoli"], calories: 415)
        }
        withAnimation(.easeInOut(duration: 0.5)) {
            appState.mealPlans = newPlans
        }
    }
    
    private func recognizeFood(image: UIImage) {
        appState.addMealPlan(MealPlan(day: "Today", mealName: "Custom Meal", foods: ["salmon", "quinoa"], calories: 350))
    }
}

// MARK: - Requests Page

struct RequestsPageView: View {
    @EnvironmentObject private var appState: AppState
    
    private let primaryColor = Color(red: 0.1, green: 0.4, blue: 0.3)
    private let accentColor = Color(red: 0.9, green: 0.5, blue: 0.1)
    
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
                
                VStack(spacing: 20) {
                    Text("Requests")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(primaryColor)
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                        .padding(.top, 40)
                    
                    ScrollView {
                        VStack(spacing: 25) {
                            eickRequestSection
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var eickRequestSection: some View {
        VStack(spacing: 12) {
            Text("Eick’s Picks")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundStyle(primaryColor)
            
            Text(appState.requestedFoods.isEmpty ? "No picks yet" : appState.requestedFoods.joined(separator: ", "))
                .font(.system(.callout, design: .rounded))
                .foregroundStyle(appState.requestedFoods.isEmpty ? .gray : .black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
            
            Button(action: requestFoodOptions) {
                Text("Request for Eick")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [accentColor, accentColor.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .clipShape(Capsule())
            }
            .shadow(color: accentColor.opacity(0.3), radius: 6, x: 0, y: 3)
        }
    }
    
    private func requestFoodOptions() {
        appState.updateRequestedFoods(["grilled salmon", "quinoa", "asparagus"])
    }
}

// MARK: - Image Picker

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var onImagePicked: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.onImagePicked(uiImage)
            }
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Profile Page

struct ProfilePageView: View {
    private let primaryColor = Color(red: 0.1, green: 0.4, blue: 0.3)
    private let accentColor = Color(red: 0.9, green: 0.5, blue: 0.1)
    
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
                    VStack(spacing: 20) {
                        // Profile header
                        ZStack {
                            Circle()
                                .fill(primaryColor)
                                .frame(width: 120, height: 120)
                                .shadow(color: primaryColor.opacity(0.3), radius: 8, x: 0, y: 4)
                            
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 40)
                        
                        Text("Profile")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(primaryColor)
                            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        // Profile details card
                        VStack(spacing: 12) {
                            Text("User Details")
                                .font(.system(.title3, design: .rounded, weight: .semibold))
                                .foregroundStyle(primaryColor)
                            
                            ProfileDetailRow(label: "Name", value: "Alex Doe")
                            ProfileDetailRow(label: "Dietary Preference", value: "Balanced")
                            ProfileDetailRow(label: "Daily Calorie Goal", value: "2000 kcal")
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
                        .padding(.horizontal)
                        
                        // Edit button
                        Button(action: { /* Add edit functionality */ }) {
                            Text("Edit Profile")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(accentColor)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(accentColor, lineWidth: 1))
                        }
                        .shadow(color: accentColor.opacity(0.2), radius: 4, x: 0, y: 2)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfileDetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.gray)
            Spacer()
            Text(value)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.black)
        }
    }
}



// MARK: - Preview

#Preview {
    ContentView()
        .environmentObject(AppState())
}
