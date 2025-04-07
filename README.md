# 🚀 Flutter Job Listing App

A clean and modern Job Board App built using Flutter as part of a job application assignment. This app displays job listings, job details, and allows users to bookmark/save their favorite jobs.

---

## 📱 Features

- 📡 Fetches job data using **Dio** from a mock REST API
- 📦 Models API responses using **Freezed**
- 🧠 Handles state with **BLoC (Cubit)**
- 💾 Save/bookmark jobs to a separate screen
- 🎨 Beautiful light & dark theme switcher using **ThemeData**
- ✅ Clean architecture with modular folder structure
- ⚙️ Responsive and scalable code for production use

---

## 📸 Screenshots

| Job List | Job Details | Saved Jobs | Theme Switch | Splash |

### 🔹 Job List Screen
![Job List](screenshots/listing.jpeg)

### 🔹 Job Details Screen
![Job Details](screenshots/job_detail.png)

### 🔹 Saved Jobs Screen
![Saved Jobs](screenshots/saved_jobs.jpeg)

### 🔹 Splash Screen
![Splash Screen](screenshots/splash_screen.jpeg)


### 🔹 Dark Theme
![Dark Theme](screenshots/dark_theme.jpeg)


## 📦 Download APK

Want to test the app on your Android device?  
👇 Click the button below to download the release APK:

[![Download APK](https://img.shields.io/badge/Download-APK-blue?style=for-the-badge&logo=android)](https://drive.google.com/file/d/1qF5CUzhLQmzy1ds3A580TYaeh-hz6neo/view?usp=sharing)

> ⚠️ Note: To install the APK, you may need to enable "Install from Unknown Sources" in your device settings.

---

## 🧱 Architecture
lib/
├── core/
│   └── di/
│       └── injection_container.dart
├── data/
│   ├── models/
│   │   └── job_model.dart
│   └── repositories/
│       ├── job_repository_impl.dart
│       └── saved_jobs_repository_impl.dart
├── domain/
│   └── repositories/
│       ├── job_repository.dart
│       └── saved_jobs_repository.dart
├── presentation/
│   ├── blocs/
│   │   ├── jobs/
│   │   │   └── jobs_cubit.dart
│   │   ├── saved_jobs/
│   │   │   └── saved_jobs_cubit.dart
│   │   └── theme/
│   │       └── theme_cubit.dart
│   ├── config/
│   │   └── theme.dart
│   ├── screens/
│   │   ├── job_detail_screen.dart
│   │   ├── job_listing_screen.dart
│   │   └── saved_jobs_screen.dart
│   |   └── splash_screen.dart
│   └── widgets/
│       └── job_card.dart
└── main.dart

---

## 🛠️ Tech Stack

- Flutter
- Dio
- Freezed
- BLoC (Cubit)
- ThemeData
- MockAPI.io (for dummy job data)

---

## 📦 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/DEVILGHAZI/job_applocation.git
   cd job_applocation

2. Install dependencies:
flutter pub get

3. Run the app:
flutter run
📧 Contact
Mohd Washid
📧 mwashid914@gmail.com
📱 +91-8958618665
🌐 https://mohdwashid.github.io/my-resume-app/

💼 Assignment
This project was submitted as a part of the hiring process for the Flutter Developer

---

### ✨ Bonus Tip:
You can preview how it looks locally in **VS Code** or check it directly on GitHub after pushing.

---

Would you like me to help you add screenshots, or review your folder structure before you push it?

