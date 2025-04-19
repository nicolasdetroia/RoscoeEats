# 🍽️ TCNJ Dining AI Companion

This Hackathon project focuses on **web scraping dynamic content** from **The College of New Jersey’s Eickhoff Dining Hall** website, which is rendered using **Angular.js**.  
The goal is to extract **structured, up-to-date meal information** — including:

- Meal times (Breakfast, Lunch, Brunch, Dinner)  
- Food stations  
- Individual menu items  
- Calorie data  

...and make it easily accessible through a **mobile-friendly UI** for the TCNJ student community.

---

## 🛠️ Tech Stack

### 🎨 Frontend
- **Preferred**: Flutter (cross-platform for iOS/Android)
- **Alternative**: React Native

### 🔧 Backend
- **Preferred**: Node.js with Express + MongoDB  
  - ✅ 90% completed on [GitHub](https://github.com/praneels2005/Hackathon)
- **Alternative**: Firebase (for simplicity and quick iteration)

### 🔔 Notifications
- Firebase Cloud Messaging (FCM)

### 🧠 AI Logic
- **Prototyping**: Python  
- **Deployment**: JavaScript (integrated with backend)

### ☁️ Hosting
- Google Cloud Platform *(robust, scalable)*  
- Heroku *(easy to deploy, ideal for MVP)*

### 🔗 APIs & Data Sources
- TCNJ Dining Services (if available)
- Otherwise, custom web scraper for dynamic menu data

---

## 🧩 Web Scraping Engine

### 📌 Objective:
Scrape meal data from an **Angular.js** website that dynamically renders content.

### 🔍 Key Challenges

1. **Dynamic DOM Rendering**  
   - DOM changes frequently due to Angular.js
   - Class names, child nodes, and hierarchy mutate on interaction

2. **Limitations of Static Scraping**  
   - Traditional scrapers fail due to:
     - Frequent DOM mutations  
     - Asynchronous content loading  
     - Inconsistent HTML structures

---

### ✅ Implemented Solutions

#### **Mutation Observers**
- Detect real-time DOM changes
- Monitor when new content (menus) is injected
- Ensure scraper waits before accessing the right data

#### **Structured Data Collection**
Data is parsed into nested JavaScript objects:
```json
{
  "Date": {
    "MealType": {
      "Station": {
        "ItemName": "Calories"
      }
    }
  }
}
