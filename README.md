# Posts App

A Flutter application that displays posts from an online REST API with local offline caching and favorites management.

## Features

- **Posts Listing:** Fetch and display posts from an online API.
- **Offline Caching:** Store posts locally using Hive for offline access.
- **Favorites Management:** Add and remove posts from favorites.
- **Data Persistence:** Keep posts and favorites saved after closing and reopening the application.
- **Offline Support:** Access previously cached posts and saved favorites without an internet connection.

## Technologies Used

- Flutter
- Dart
- Hive – Local NoSQL database
- Hive Flutter – Local database integration
- HTTP – API requests
- Connectivity Plus – Network connectivity detection

## Project Structure

```text
lib/
├── models/
│   └── post_model.dart
├── screens/
│   ├── posts_screen.dart
│   └── favorites_screen.dart
├── services/
│   ├── post_service.dart
│   └── favorites_service.dart
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Visual Studio Code or Android Studio

### Installation

1. Clone the repository:

```bash
git clone https://github.com/ahmedsalllem/posts_app.git
```

2. Navigate to the project directory:

```bash
cd posts_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## Testing

Run the following commands:

```bash
flutter analyze
flutter test
```

## Offline Mode Verification

The application was tested to verify that:

- Posts remain available after closing and reopening the application without internet.
- Favorite posts remain saved after closing and reopening the application without internet.

**Test Results:** Passed.

---

Developed using Flutter and Dart.
