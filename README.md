# 📱 Excelerate My Learning App

A Flutter-based mobile application designed to streamline user onboarding and course discovery. This project integrates local storage, user authentication, and dynamic course rendering from JSON data.

## 🚀 Features Added

### 🔐 Authentication (Week 2)
- **Login and Signup Screens**: Located under the `authentication/` directory.
- Enables new users to register and existing users to log in securely.

### 📚 Course Management
- **Course Listing and Description**: Dynamically rendered from a local JSON file.
- Provides users with a structured overview of available courses.

### 🧠 Smart Entry Logic
- **Entry Screen**: Determines whether a user is new or returning.
- Redirects users accordingly to onboarding or home screens.

## 🗂️ Key Files and Modules

| File/Module       | Purpose                                                                 |
|-------------------|-------------------------------------------------------------------------|
| `user_storage.dart` | Stores user data for login and signup persistence.                     |
| `course_loader.dart` | Loads course data from local JSON for display.                         |
| `local_storage.dart` | Handles device-level data persistence using shared preferences or similar. |
| `entry_screen.dart`  | Checks user status and routes them to the appropriate screen.          |

## 🛠️ Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/excelerate.git
