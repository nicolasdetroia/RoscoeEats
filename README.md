# RoscoeEats

🧠 Project Overview
This Hackathon project focuses on web scraping dynamic content from The College of New Jersey’s Eickhoff Dining Hall website, which is rendered using Angular.js.
The primary goal is to extract structured, up-to-date meal information—including:

Meal times (Breakfast, Lunch, Brunch, Dinner)

Food stations

Individual menu items

Calorie data

...and make it easily accessible through a mobile-friendly UI for the TCNJ student community.

⚙️ Tech Stack
🎨 Frontend
Preferred: Flutter (cross-platform for iOS/Android)

Alternative: React Native

🔧 Backend
Preferred: Node.js with Express + MongoDB

✅ 90% completed on GitHub

Alternative: Firebase (for simplicity and quick iteration)

🔔 Notifications
Firebase Cloud Messaging (FCM)

🧠 AI Logic
Prototyping: Python

Deployment: JavaScript (integrated with backend)

☁️ Hosting
Options:

Google Cloud Platform

Heroku

🔗 APIs & Data
TCNJ Dining Services (if available)

Otherwise, use custom scraper for dynamic menu data

🛠️ Web Scraping Engine
📌 Key Focus:
Scraping meal data from a dynamically rendered Angular.js website using smart DOM handling strategies.

🧩 Key Challenges
Dynamic DOM Rendering

Angular.js causes the DOM to change frequently.

Class names, child nodes, and structures mutate based on interaction.

Limitations of Static Scraping

Traditional scraping fails due to:

Frequent DOM mutations

Asynchronous content loading

Inconsistent element paths

🧠 Backend Scraper Logic
✅ Implemented Solutions:
Mutation Observers

Detect real-time DOM changes.

Monitor when new content (like menus) is injected.

Ensures scraper waits for correct data before running.

Structured Data Collection

Data is parsed into nested JavaScript objects:

js
Copy
Edit
{
  "Date": {
    "MealType": {
      "Station": {
        "ItemName": "Calories"
      }
    }
  }
}
⚠️ Current Limitations
Network Reliability: Heavy requests may delay or overload server responses.

DOM Inconsistency: Angular rendering introduces timing issues (e.g., content appears late).

No Official API: All data must be manually scraped via client-side logic.

🚀 Features
🧠 AI Nutrition Planner

Suggests weekly meal prep based on student dietary preferences and calorie needs.

📥 Request Feature for Eick

Allows students to suggest food items they'd like added to the dining hall.

📷 Food Recognition Integration

Uses CAL AI API for recognizing meals in real-time via camera.

📱 Future Use Case
A sleek mobile interface to:

View real-time menus based on day and meal time

Plan meals according to nutritional goals

Avoid long lines by previewing food station offerings

