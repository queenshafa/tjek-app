# Tjek

A student attendance app built with Flutter and Firebase. Students check in using the front camera, and the app logs the timestamp, checks if they arrived before 07:00 WIB, and saves the record to Firestore.

## Features

- **Front-camera check-in:** Takes a live photo with a quick preview screen before submitting.
- **Automatic status check:** Marks check-ins before 07:00 WIB as on time and anything after as late.
- **Home dashboard:** Shows the current time (WIB), weekly school days, and monthly on-time vs. late counts.
- **Attendance history:** Lists past check-ins with timestamps, status badges, and photo thumbnails.
- **Light & dark mode:** Supports both themes with saved preferences.
- **Profile:** Displays student details, profile photo updates, and sign-out.

## Stack

- Flutter & Dart
- Riverpod (state management)
- Firebase Auth & Cloud Firestore
- Shared Preferences
- Camera & Image packages

## Folder Layout

```text
lib/
├── core/                  # Theme, clock provider, and shared widgets
├── features/
│   ├── auth/              # Login screen and Firebase auth logic
│   ├── attendance/        # Home, calendar, check-in card, history, and bottom nav
│   ├── camera/            # Front camera session and photo encoding
│   └── profile/           # Profile screen and avatar controls
├── app.dart
└── main.dart

```

## Setup

1. Clone the repo:
```bash
git clone [https://github.com/queenshafa/tjek-app.git](https://github.com/queenshafa/tjek-app.git)
cd tjek-app

```


2. Install packages:
```bash
flutter pub get

```


3. Add your Firebase config:
* Put `google-services.json` in `android/app/` (and `GoogleService-Info.plist` in `ios/Runner/` for iOS), or run `flutterfire configure`.
* Enable Email/Password sign-in and Cloud Firestore in your Firebase console.


4. Run the app:
```bash
flutter run

```



## Tests

```bash
flutter test

```