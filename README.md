# Emvigo - Flutter Authentication & Profile Management App

A modern Flutter application demonstrating **Clean Architecture** with **BLoC State Management** pattern. The app features user authentication, profile creation, and Firebase integration.

---

## 📋 Table of Contents

- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Features](#features)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)

---

## 🏗️ Architecture

### **Clean Architecture Layers**

The project follows **Clean Architecture** principles with three distinct layers:

#### **1. Presentation Layer** (`lib/features/*/presentation/`)
- **Responsibility**: UI components and user interaction
- **Contains**:
  - **Pages**: Full-screen widgets (e.g., `sign_up_view.dart`, `sign_in_view.dart`)
  - **Widgets**: Reusable UI components
  - **BLoC**: State management and business logic orchestration
  - **Events**: User actions dispatched to BLoC
  - **States**: UI state representations

#### **2. Domain Layer** (`lib/features/*/domain/`)
- **Responsibility**: Business logic, entities, and use cases
- **Contains**:
  - **Entities**: Core business objects (e.g., `SignUpCredentialEntity`)
  - **Repositories**: Abstract repository interfaces
  - **Use Cases**: Business logic orchestration (e.g., `SignUpUseCase`)

#### **3. Data Layer** (`lib/features/*/data/`)
- **Responsibility**: Data sources and repository implementations
- **Contains**:
  - **Data Sources**: Remote (Firebase) and local data fetching
  - **Repository Implementations**: Concrete repository logic
  - **Models**: Data transfer objects

### **State Management: BLoC Pattern**

```
User Input (View)
       ↓
   Event (BLoC)
       ↓
   Business Logic (Use Case)
       ↓
   State (UI Update)
       ↓
   Widget Rebuild
```

**Key Benefits**:
- ✅ Separation of concerns
- ✅ Testability
- ✅ Reusability
- ✅ Predictable state changes

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point & BLoC providers
├── di.dart                            # Dependency injection setup (GetIt)
├── firebase_options.dart              # Firebase configuration
│
├── core/
│   ├── constants/                     # App constants
│   ├── error/
│   │   ├── failure.dart              # Failure handling
│   │   └── network_exceptions.dart   # Network error handling
│   └── usecase/
│       └── use_case.dart             # Abstract UseCase base class
│
└── features/                          # Feature modules (Clean Architecture)
    │
    ├── sign_up/
    │   ├── data/
    │   │   ├── data_sources/
    │   │   │   ├── i_sign_up_remote_ds.dart      # Data source interface
    │   │   │   └── sign_up_remote_ds_impl.dart   # Firebase implementation
    │   │   └── domain_impl/
    │   │       ├── sign_up_repo_impl.dart        # Repository implementation
    │   │       └── sign_up_remote_ds_impl.dart   # Firebase operations
    │   │
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── sign_up_request_entity.dart   # Business entity
    │   │   ├── repositories/
    │   │   │   └── i_sign_up_repo.dart          # Repository interface
    │   │   └── use_cases/
    │   │       └── sign_up_use_case.dart        # Business logic
    │   │
    │   └── presentation/
    │       ├── pages/
    │       │   └── sign_up_view.dart             # Signup screen
    │       ├── bloc/
    │       │   ├── sign_up_bloc.dart             # BLoC logic
    │       │   ├── sign_up_event.dart            # User actions
    │       │   └── sign_up_state.dart            # UI states
    │       └── widgets/                          # Reusable UI components
    │
    ├── sign_in/                       # Similar structure to sign_up
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── create_profile/                # Profile creation feature
        ├── data/
        ├── domain/
        └── presentation/

android/                               # Android platform-specific code
ios/                                   # iOS platform-specific code
```

---

## 📦 Dependencies

### **Core Framework**

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | Latest | UI framework |
| `flutter_screenutil` | ^5.9.3 | Responsive UI scaling |

### **State Management**

| Package | Version | Purpose |
|---------|---------|---------|
| `bloc` | ^9.2.1 | State management library |
| `flutter_bloc` | ^9.1.1 | Flutter BLoC integration |
| `equatable` | ^2.1.0 | Value equality support |

### **Dependency Injection**

| Package | Version | Purpose |
|---------|---------|---------|
| `get_it` | ^9.2.1 | Service locator for DI |

### **Firebase & Backend**

| Package | Version | Purpose |
|---------|---------|---------|
| `firebase_core` | ^4.11.0 | Firebase initialization |
| `firebase_auth` | ^6.5.4 | User authentication |
| `cloud_firestore` | ^6.6.0 | Cloud database |

### **Functional Programming**

| Package | Version | Purpose |
|---------|---------|---------|
| `fpdart` | ^1.2.0 | Functional programming (Either/Result pattern) |

### **UI & Styling**

| Package | Version | Purpose |
|---------|---------|---------|
| `google_fonts` | ^8.1.0 | Google fonts library |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

### **Development**

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_lints` | ^6.0.0 | Lint rules for code quality |

---

## ✨ Features

### **1. User Authentication**
- **Sign Up**: Email/password registration with validation
  - Email format validation
  - Password strength check (min 6 characters)
  - Duplicate email detection
  - Firebase Authentication integration

- **Sign In**: User login with error handling
  - Credential validation
  - Firebase Auth integration

- **Error Handling**:
  - `email-already-in-use`: User-friendly error message
  - `weak-password`: Password strength suggestion
  - `invalid-email`: Email format validation
  - `operation-not-allowed`: Server availability message

### **2. Profile Management**
- **Create Profile**: User profile setup after registration
  - Personal information (name, DOB, gender)
  - Nationality and language preferences
  - Profile persistence to Firestore

### **3. State Management**
- Real-time loading states
- Success/failure handling
- Automatic form clearing on success
- Navigation on authentication completion

---

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK 3.12.2+
- Dart SDK 3.12.2+
- Firebase project setup
- Android Studio / Xcode (for iOS)

### **Installation**

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd emvigo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   ```bash
   flutterfire configure
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### **Build**

```bash
# Android
flutter build apk

# iOS
flutter build ios
```

---

## 🔧 Development Workflow

### **Adding a New Feature**

1. **Create feature folder** in `lib/features/`
2. **Implement layers in order**:
   - Domain (entities, repositories, use cases)
   - Data (data sources, repository implementations)
   - Presentation (BLoC, events, states, views)

3. **Register in DI** (`lib/di.dart`)

### **BLoC Event Handling Example**

```dart
// 1. Define Event
class SignUp extends SignUpEvent {
  final String email;
  final String password;
  const SignUp({required this.email, required this.password});
}

// 2. Handle in BLoC
on<SignUp>((event, emit) async {
  emit(SignUpLoading());
  final result = await signUpUseCase.call(...);
  result.fold(
    (failure) => emit(SignUpFailure(...)),
    (success) => emit(SignUpSuccess(...)),
  );
});

// 3. Listen in UI
BlocListener<SignUpBloc, SignUpState>(
  listener: (context, state) {
    if (state is SignUpSuccess) {
      // Navigate or show success
    }
  },
)
```

---

## 🔐 Error Handling Strategy

The app uses the **Either/Result Pattern** from `fpdart`:

```dart
Either<Failure, UserCredential> // Success or Failure
```

**Benefits**:
- Type-safe error handling
- Functional approach to error management
- Prevents null reference exceptions
- Clear success/failure paths

---

## 📱 UI/UX Features

- **Responsive Design**: Uses `flutter_screenutil` for all screen sizes
- **Loading States**: Visual feedback during operations
- **Error Messages**: User-friendly error notifications
- **Google Fonts**: Professional typography
- **Color Scheme**: Green accent (`#006E5C`) for primary actions

---

## 🧪 Testing Recommendations

- Unit tests for Use Cases
- Widget tests for UI components
- BLoC tests for state management
- Integration tests for Firebase operations

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Library](https://bloclibrary.dev/)
- [Firebase Flutter Guide](https://firebase.flutter.dev/)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [FPDart Documentation](https://pub.dev/packages/fpdart)

---

## 📝 License

This project is licensed under the MIT License.

---

## 👨‍💻 Author

Emvigo Development Team

---

**Last Updated**: 2026-07-06
