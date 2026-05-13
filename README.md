# Plus90 ⚽️🏀🎾

Plus90 is a modern iOS sports application developed as part of the Information Technology Institute curriculum.
The app delivers real-time sports updates, league information, fixtures, and detailed team statistics through a smooth and responsive user experience built using modern iOS engineering practices.

---

## 🚀 Features

* **Live Sports Data**

  * Real-time leagues, fixtures, and team information integration using sports APIs.

* **Advanced UI/UX**

  * Dynamic interfaces powered by `UICollectionViewCompositionalLayout` and `Diffable Data Source`.

* **Favorites Management**

  * Save favorite leagues locally using **CoreData** for persistent offline access.

* **Dark & Light Mode**

  * Fully customized dynamic theming system with seamless appearance switching.

* **Custom Navigation Experience**

  * Replaced default navigation bars with branded custom headers for a cleaner and more immersive experience.

* **Team Details & Events**

  * Explore latest matches, upcoming fixtures, teams, and squad information.

* **Onboarding Experience**

  * Smooth onboarding flow implemented using `UIPageViewController`.

* **Testing & Mocking**

  * Unit testing and integration testing using `XCTest`.
  * Mock networking layer for testing success and failure API scenarios.
  * Network service coverage validation with mocked API responses.

---

## 🛠 Tech Stack

| Technology           | Description                |
| -------------------- | -------------------------- |
| **Language**         | Swift 5                    |
| **UI Framework**     | UIKit                      |
| **Architecture**     | MVP (Model-View-Presenter) |
| **Networking**       | URLSession / Alamofire     |
| **Persistence**      | CoreData                   |
| **Layout System**    | Compositional Layout       |
| **State Management** | Diffable Data Source       |
| **Testing**          | XCTest + Mocking           |
| **IDE**              | Xcode 14+                  |

---

## 🧩 Architecture

The project follows the **MVP (Model-View-Presenter)** architecture pattern to ensure:

* Clear separation of concerns
* Better scalability
* Easier maintainability
* Improved unit testing and mocking support

---

## 👥 Team Members & Contributions

### Mahmoud Bayoumi

* Developed the **Favorites Screen** UI and implemented local persistence using CoreData.
* Built the **Latest Events** and **Teams** sections in League Details.
* Created the **Team Details** screen using advanced collection view layouts.
* Implemented the onboarding experience using `UIPageViewController`.
* Developed network layer tests and mock-based testing scenarios.

---

### Esraa Ehab

* Developed the **Leagues Screen** for browsing available leagues.
* Implemented the **Upcoming Events** section in League Details.
* Built the main **Sports Categories Screen**.
* Developed the splash screen and dynamic dark/light theme engine.

---

## 📂 Project Structure

```bash id="m3j5p0"
Plus90-Swift
├── App
├── Shared
├── View
├── Modules
├── Model
├── Assets
└── Info.plist
```

---

## ⚙️ Installation

### 1. Clone the repository

```bash id="4dr6w4"
git clone https://github.com/YourUsername/Plus90-Swift.git
```

### 2. Open the project

```bash id="s43v8q"
cd Plus90-Swift
open Plus90-Swift.xcodeproj
```

### 3. Requirements

* Xcode 14+
* iOS 15.0+
* Swift 5

### 4. Run the application

Build and run the project using your preferred simulator or physical device.

---

## 🧪 Testing

The project includes:

* Unit Testing using `XCTest`
* Mock-based networking tests
* API integration tests
* Asynchronous testing using `XCTestExpectation`
* Network service coverage validation
* Success and failure scenario testing

---

## 📌 Future Improvements

* Push notifications for live matches
* Match highlights integration
* Advanced player statistics
* Search functionality
* Offline fixtures caching

---

## 📄 License

This project was developed for educational purposes as part of the Information Technology Institute program.
