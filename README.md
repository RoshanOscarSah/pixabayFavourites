# Pixabay Favorites - Mobile Developer Home Exercise

A Flutter mobile application that allows users to search for images from Pixabay and manage their favorite images. Built following Clean Architecture principles with platform-aware UI design.

## 📋 Requirements Checklist

### Core Requirements ✅

- [x] Flutter mobile app
- [x] Search images from Pixabay API
- [x] Add images to favorite list
- [x] View and maintain favorite images (add/remove)
- [x] Two main pages: Home page and Add new images page

### Home Page Requirements ✅

- [x] Title: "Your favorite images"
- [x] Button to navigate to "Add new images" page
- [x] Display favorite images in a grid (2 images per row)
- [x] Display owner's name below each image
- [x] Display image size in short format (custom formatting algorithm)
  - Less than 1K: show number (e.g., 550)
  - Less than 1M: show with 'K' (e.g., 950K)
  - Less than 1GB: show with 'M' (e.g., 2.3M, 5M)
  - 1GB or more: show with 'GB' (e.g., 1.2GB)
- [x] Tap image to show YES/NO dialog for removal
- [x] Empty state message: "Your favorite list is empty"

### Search Page Requirements ✅

- [x] Header with back button and title "Add new images"
- [x] Search bar with text field and search button
- [x] Fetch up to 20 images from Pixabay API per search
- [x] Display images in grid (2 images per row) with same info as home page
- [x] Tap image to select (shows checkmark overlay)
- [x] Tap selected image to deselect (removes checkmark and from favorites)

### Bonus Features ✅

- [x] **2 Unit Tests**
  - FormatBytes utility test (`test/utils/format_bytes_test.dart`)
  - FavoritesRepository test (`test/repositories/favorites_repository_test.dart`)
- [x] **Local Persistence**: Favorites saved using GetStorage (persists across app launches)
- [x] **Pagination**: Infinite scroll pagination for search results

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # API and app constants
│   ├── errors/             # Custom exceptions and failures
│   ├── injection/          # Dependency injection container
│   ├── network/             # Network connectivity checker
│   ├── secrets.dart        # API key configuration
│   └── utils/              # Utility functions (FormatBytes)
├── data/                    # Data layer
│   ├── data_sources/       # Remote (Pixabay API) and Local (GetStorage)
│   ├── models/             # Data models with JSON serialization
│   └── repositories/       # Repository implementations
├── domain/                  # Business logic layer
│   ├── entities/           # Business entities (ImageItem)
│   ├── repositories/       # Repository interfaces
│   └── use_cases/          # Business logic use cases
└── presentation/            # UI layer
    ├── pages/              # App screens (Home, Search)
    ├── providers/         # State management (FavoritesProvider)
    ├── theme/              # Platform-aware theming
    └── widgets/            # Reusable UI components
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.8.1 or higher)
- Dart SDK
- Pixabay API key ([Get one here](https://pixabay.com/api/docs/))

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/yourusername/pixabay_favorites.git
cd pixabay_favorites
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Configure API Key:**

   - Open `lib/core/secrets.dart`
   - Replace `pixabayApiKeyFromSecrets` with your Pixabay API key:

   ```dart
   const String pixabayApiKeyFromSecrets = 'YOUR_API_KEY_HERE';
   ```

4. **Run the app:**

```bash
flutter run
```

### Building APK

To build a release APK for Android:

```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

For a split APK (smaller file size):

```bash
flutter build apk --split-per-abi --release
```

## 📦 Dependencies

### Main Dependencies

- `flutter`: Flutter SDK
- `http: ^1.2.2` - HTTP client for API calls
- `provider: ^6.1.2` - State management (Well-known package as required)
- `connectivity_plus: ^6.1.0` - Network connectivity monitoring
- `equatable: ^2.0.5` - Value equality comparisons
- `dartz: ^0.10.1` - Functional programming (Either type for error handling)
- `get_storage: ^2.1.1` - Local storage (bonus feature)
- `cached_network_image: ^3.3.1` - Image caching for offline support

### Dev Dependencies

- `flutter_test`: Testing framework
- `flutter_lints: ^5.0.0` - Linting rules
- `mocktail: ^1.0.0` - Mocking for unit tests

## 🎨 Platform Support

The app automatically adapts its UI based on the platform:

- **Android**: Uses Material Design
- **iOS**: Uses Cupertino (iOS-style) design

## 📱 Features

### Image Search

- Search for images using Pixabay API
- Pagination support (infinite scroll)
- Up to 20 images per page
- Cached images for offline viewing

### Favorites Management

- Add images to favorites by tapping
- Remove images with confirmation dialog
- View all favorites on home screen
- Persistent storage (bonus feature)

### Image Formatting

Custom algorithm for displaying image sizes:

- `< 1KB`: `550`, `999`
- `< 1MB`: `950K`, `1.5K`, `2K`
- `< 1GB`: `2.3M`, `5M`, `10.5M`
- `≥ 1GB`: `1.2GB`, `2.5GB`

## 🧪 Testing

Run unit tests:

```bash
flutter test
```

Test files:

- `test/utils/format_bytes_test.dart` - Tests byte formatting utility
- `test/repositories/favorites_repository_test.dart` - Tests favorites repository

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── app_constants.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── injection/
│   │   └── injection_container.dart
│   ├── network/
│   │   └── network_info.dart
│   ├── secrets.dart
│   └── utils/
│       └── format_bytes.dart
├── data/
│   ├── data_sources/
│   │   ├── local_data_source.dart
│   │   └── remote_data_source.dart
│   ├── models/
│   │   └── image_item_model.dart
│   └── repositories/
│       ├── favorites_repository_impl.dart
│       └── images_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── image_item.dart
│   ├── repositories/
│   │   ├── favorites_repository.dart
│   │   └── images_repository.dart
│   └── use_cases/
│       └── search_images_use_case.dart
├── presentation/
│   ├── pages/
│   │   ├── home_page.dart
│   │   └── search_page.dart
│   ├── providers/
│   │   └── favorites_provider.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       ├── connectivity_widget.dart
│       └── image_grid_item.dart
└── main.dart
```

## 🛠️ State Management

The app uses **Provider** (a well-known Flutter state management package) as required:

- `FavoritesProvider`: Manages favorite images state
- Notifies listeners when favorites change
- Integrates with repository layer for data persistence

## 🔒 Error Handling

Robust error handling implemented using:

- `Either<Failure, T>` pattern from `dartz` package
- Custom `Failure` classes (ServerFailure, NetworkFailure, CacheFailure)
- User-friendly error messages displayed in UI
- Network connectivity checking before API calls

## 📝 Notes

- **State Management**: Uses Provider package as specified in requirements
- **Clean Architecture**: Follows SOLID principles with clear layer separation
- **Bonus Features**: All three bonus features implemented (unit tests, persistence, pagination)
- **Platform Awareness**: Automatically switches between Material and Cupertino designs
- **Offline Support**: Images are cached for offline viewing
- **Image Caching**: Uses `cached_network_image` for efficient image loading and offline access

## 🐛 Known Issues

None. The app is fully functional with no known defects.

## 📄 License

This project is proprietary and confidential - created for Dreemz mobile developer home exercise.

## 👤 Author

Submitted as part of the mobile developer home exercise for Dreemz.

---

**Built with Flutter** 🚀
