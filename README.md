# Merchant Product App (Offline-First)

A production-ready Flutter application demonstrating Clean Architecture, Offline Capability, and Data Synchronization.
Built as a technical assignment for the Senior Mobile Engineer position.

## Features
- **Clean Architecture:** Separated into Presentation, Domain, and Data layers.
- **Offline-First:** Create and view products without internet connection.
- **Auto Synchronization:** Automatically syncs pending data when connection is restored.
- **State Management:** Flutter Bloc (Cubit) for predictable state transitions.
- **Local Persistence:** Hive (NoSQL) for fast local data storage.
- **Dependency Injection:** GetIt + Injectable.

## Tech Stack
- **Framework:** Flutter 3.x
- **Language:** Dart
- **Network:** Dio
- **Local DB:** Hive
- **State Management:** Flutter Bloc
- **Service Locator:** GetIt
- **Code Generation:** Freezed / JsonSerializable / HiveGenerator

## How to Run

1. **Prerequisites**
   Ensure you have Flutter installed and Node.js (for the mock backend).

2. **Setup Backend**
   This app requires a local JSON server.
   ```bash
   # Install dependencies
   npm install -g json-server
   
   # Run the server (Make sure to use host 0.0.0.0 for Android Emulator access)
   npx json-server --watch mock_backend/db.json --port 3000 --host 0.0.0.0

   
