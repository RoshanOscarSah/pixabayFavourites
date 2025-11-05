# Pixabay Favorites

A Flutter application that allows users to search for images from Pixabay and save their favorites locally. The app features a clean architecture, supports both Material and Cupertino design systems, and provides a seamless user experience across iOS and Android platforms.

## Features

- 🔍 **Search Images**: Search for images using the Pixabay API
- ⭐ **Favorites Management**: Save and manage your favorite images
- 📱 **Cross-Platform**: Supports iOS, Android, Web, macOS, Windows, and Linux
- 🎨 **Adaptive UI**: Automatically uses Material Design on Android and Cupertino on iOS
- 🌐 **Connectivity Check**: Monitors network connectivity status
- 🏗️ **Clean Architecture**: Well-organized codebase following clean architecture principles

## Screenshots

*Add screenshots of your app here*

## Architecture

The project follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/           # Core functionality (constants, errors, network, injection)
├── data/           # Data layer (data sources, models, repository implementations)
├── domain/         # Business logic (entities, repositories, use cases)
└── presentation/   # UI layer (pages, providers, widgets, theme)
```

### Key Components

- **Domain Layer**: Contains business entities, repository interfaces, and use cases
- **Data Layer**: Implements repositories, handles API calls, and data models
- **Presentation Layer**: UI components, state management (Provider), and theming
- **Core Layer**: Shared utilities, error handling, dependency injection, and network configuration

## Getting Started

### Prerequisites

- Flutter SDK (^3.8.1 or higher)
- Dart SDK
- Pixabay API key ([Get one here](https://pixabay.com/api/docs/))

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pixabay_favorites.git
cd pixabay_favorites
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure API Key:
   - Open `lib/core/secrets.dart`
   - Replace the `pixabayApiKeyFromSecrets` constant with your Pixabay API key:
   ```dart
   const String pixabayApiKeyFromSecrets = 'YOUR_API_KEY_HERE';
   ```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── constants/      # API and app constants
│   ├── errors/         # Custom exceptions and failures
│   ├── injection/      # Dependency injection container
│   ├── network/        # Network connectivity checker
│   ├── secrets.dart    # API keys and secrets
│   └── utils/          # Utility functions
├── data/
│   ├── data_sources/   # Remote data sources (Pixabay API)
│   ├── models/         # Data models
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── use_cases/      # Business logic use cases
└── presentation/
    ├── pages/          # App screens (Home, Search)
    ├── providers/      # State management (FavoritesProvider)
    ├── theme/          # App theming (Material/Cupertino)
    └── widgets/        # Reusable UI components
```

## Dependencies

### Main Dependencies
- `flutter`: Flutter SDK
- `http`: ^1.2.2 - HTTP client for API calls
- `provider`: ^6.1.2 - State management
- `connectivity_plus`: ^6.1.0 - Network connectivity monitoring
- `connectivity_widget`: ^3.0.0 - Connectivity-aware widgets
- `equatable`: ^2.0.5 - Value equality comparisons
- `dartz`: ^0.10.1 - Functional programming utilities (Either type)

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: ^5.0.0 - Linting rules
- `flutter_launcher_icons`: ^0.13.1 - App icon generation

## Usage

### Searching for Images

1. Tap the "Add new images" button on the home screen
2. Enter a search query in the search field
3. Tap the search button or press enter
4. Browse the search results in a grid layout

### Managing Favorites

- **Add to Favorites**: Tap on any image in the search results to add it to your favorites
- **View Favorites**: All saved favorites are displayed on the home screen
- **Remove from Favorites**: Tap on a favorite image to see a confirmation dialog and remove it

## State Management

The app uses the Provider package for state management:
- `FavoritesProvider`: Manages the list of favorite images and provides methods to add, remove, and check favorites

## Error Handling

The app implements robust error handling using:
- `Either<Failure, T>` pattern from the `dartz` package
- Custom `Failure` classes for different error types
- User-friendly error messages displayed in the UI

## Platform Support

- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Pixabay](https://pixabay.com/) for providing the image search API
- Flutter team for the amazing framework
- All contributors and open-source packages used in this project

## Contact

For questions or suggestions, please open an issue on GitHub.

---

Made with ❤️ using Flutter
