# 🚀 PulseNow – Real-Time Crypto Market Tracker

PulseNow is a Flutter application that displays real-time cryptocurrency market data with live updates via WebSocket, search functionality, detailed analytics, dark mode support, and full unit testing.

The app is built with clean architecture principles, Provider state management, and production-ready testing practices.

---

## 📱 Features

### ✅ Core Features

* 📊 **Live Market Data** – Fetches cryptocurrency prices from REST API
* 🔄 **Real-Time Updates** – Live price updates via WebSocket
* 🔍 **Search & Filter** – Search by symbol or description
* 📃 **Detailed View** – Individual coin analytics screen
* ♻️ **Pull to Refresh** – Manual refresh support
* ⚡ **Optimized List Rendering** – Uses `ListView.builder` with `itemExtent`

### 🌗 UI & UX

* 🌞 **Light Mode / Dark Mode / System Mode**
* 💾 **Theme Persistence** – Remembers user preference
* 🎨 **Material 3 UI Design**
* 📱 **Responsive Layouts**
* 🧭 **Smooth Navigation**

### 🧪 Quality & Testing

* ✅ **Unit Tests for Models**
* ✅ **API Service Tests (Mocked HTTP)**
* ✅ **Provider Logic Tests**
* ✅ **Widget Smoke Tests**
* 🧪 **Mocktail Based Testing Architecture**

---

## 🏗 Project Architecture

```
lib/
 ├── models/
 ├── providers/
 ├── services/
 ├── screens/
 ├── utils/
 └── main.dart

test/
 ├── models/
 ├── services/
 ├── providers/
 └── widget_test.dart
```

### Architecture Highlights

* Provider for state management
* Service layer abstraction
* Dependency injection for testability
* Clean separation of concerns

---

## 🔌 Tech Stack

* **Flutter (Material 3)**
* **Provider** – State management
* **HTTP** – REST API calls
* **WebSocket Channel** – Live updates
* **Shared Preferences** – Theme persistence
* **Intl** – Currency formatting
* **Mocktail** – Unit testing

---

## ⚙️ Setup Instructions

### 1️⃣ Clone Repository

```bash
git clone <your-repo-url>
cd assessment
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Run Application

```bash
flutter run
```

> Android Emulator uses:

```
http://10.0.2.2:3000
```

---

## 🧪 Run Tests

```bash
flutter test
```

---

## 🌙 Dark Mode Usage

Tap the theme icon in the AppBar and select:

* System
* Light
* Dark

The app automatically remembers your preference.

---

## 🔄 API Configuration

Update in:

```
lib/utils/constants.dart
```

```dart
static const String baseUrl = 'http://10.0.2.2:3000/api';
static const String wsUrl = 'ws://10.0.2.2:3000';
```

---

## 📦 Build APK

```bash
flutter build apk --release
```

---

## 🧑‍💻 Developer

**Mohd Faizan**
Senior Flutter Developer

---

## ⭐ Future Enhancements

* 📈 Charts Integration
* 🔔 Price Alerts
* 📊 Portfolio Tracking
* 🌐 Offline Caching
* 🔒 Authentication
* 🚀 CI/CD Pipeline

---

## 📜 License

MIT Lic

