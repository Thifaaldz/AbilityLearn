# Aku Bisa Merawat Diriku

An interactive educational mobile application designed for children to learn essential self-care skills, emotional intelligence, and social awareness through engaging games and quizzes.

## Description

"Aku Bisa Merawat Diriku" (I Can Take Care of Myself) is a Flutter-based educational app aimed at helping young children develop independence and life skills. The app features various modules that teach children about personal hygiene, daily routines, emotional recognition, and social interactions through interactive games, quizzes, and audio-visual feedback.

## Features

### Core Modules
- **Self-Care Module**: Interactive lessons on daily hygiene routines including bathing, eating, dressing, drinking water, and hair care
- **Emotional & Social Skills**: Activities to help children recognize and understand emotions and social interactions
- **Knowing Surroundings**: Quizzes and games to familiarize children with their environment and common objects
- **Mini-Games**:
  - Feed Animals: Interactive game teaching responsibility through pet care simulation
  - Tidy Toys: Organizational skills game where children learn to sort and store toys

### Technical Features
- **Audio Feedback**: Sound effects for correct/incorrect answers and background music
- **Text-to-Speech**: Voice narration for accessibility and learning reinforcement
- **Animations**: Lottie animations for engaging visual feedback
- **Responsive Design**: Optimized for mobile devices with clean, child-friendly UI
- **Multi-language Support**: Designed with Indonesian language content

### Educational Benefits
- Promotes independence and self-care skills
- Enhances emotional intelligence
- Develops problem-solving abilities
- Encourages interactive learning through play
- Provides immediate feedback for better learning outcomes

## Screenshots

*(Add screenshots here when available)*

## Installation

### Prerequisites
- Flutter SDK (^3.10.7)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ability_learn
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build Instructions

**For Android APK:**
```bash
flutter build apk --release
```

**For iOS (on macOS):**
```bash
flutter build ios --release
```

## Usage

1. **Launch the App**: Open the app on your device
2. **Splash Screen**: Initial loading screen with app branding
3. **Home Screen**: Navigate through different modules using the menu cards
4. **Interactive Learning**: Engage with quizzes, games, and activities
5. **Feedback System**: Receive audio and visual feedback for answers
6. **Progress Tracking**: View results and track learning progress

## Project Structure

```
ability_learn/
├── .gitignore                    # Git ignore rules
├── .metadata                     # Flutter project metadata
├── analysis_options.yaml         # Dart analysis configuration
├── pubspec.yaml                  # Flutter project dependencies and configuration
├── pubspec.lock                  # Lockfile for dependencies
├── README.md                     # Project documentation
├── TODO.md                       # Development tasks and notes
├── android/                      # Android platform-specific code
│   ├── .gitignore
│   ├── build.gradle.kts          # Android build configuration
│   ├── gradle.properties         # Gradle properties
│   ├── settings.gradle.kts       # Gradle settings
│   ├── app/
│   │   ├── build.gradle.kts      # App-level build configuration
│   │   └── src/                  # Android source code
│   ├── build/                    # Build outputs
│   ├── gradle/                   # Gradle wrapper
│   └── gradle.properties
├── assets/                       # Static assets
│   ├── audio/                    # Audio files
│   │   ├── background music.mp3
│   │   ├── correct.mp3
│   │   ├── result.mp3
│   │   └── wrong.mp3
│   └── images/                   # Image assets
│       ├── banner_aku_anak_hebat.png
│       ├── bowl_blue.png
│       ├── bowl_red.png
│       ├── btn_buang_sampah.png
│       ├── btn_memberi_makan.png
│       ├── btn_rapikan_mainan.png
│       ├── cat_food.png
│       ├── cat.png
│       ├── cloud.png
│       ├── milk.png
│       ├── toy_ball.png
│       ├── toy_box.png
│       ├── toy_car.png
│       ├── toy_duck.png
│       ├── toy_gamepad.png
│       ├── trash_apple.png
│       ├── trash_bin_character.png
│       ├── trash_can.png
│       ├── trash_egg.png
│       ├── tree.png
│       ├── home/                 # Home screen images
│       ├── icons/                # Icon assets
│       ├── items/                # Item images (clothing, etc.)
│       ├── modul3/               # Module 3 specific images
│       └── questions/            # Quiz question images
├── build/                        # Flutter build outputs
├── ios/                          # iOS platform-specific code
│   ├── .gitignore
│   ├── Flutter/                  # Flutter iOS integration
│   ├── Runner/                   # iOS app runner
│   ├── Runner.xcodeproj/         # Xcode project files
│   ├── Runner.xcworkspace/       # Xcode workspace
│   └── RunnerTests/              # iOS unit tests
├── lib/                          # Main Flutter application code
│   ├── main.dart                 # App entry point
│   ├── data/                     # Static data and configurations
│   │   ├── game_items.dart       # Game item data
│   │   ├── quiz_data.dart        # Quiz questions and data
│   │   └── quiz_data_kenal_sekitarku.dart
│   ├── models/                   # Data models
│   │   ├── quiz_item.dart        # Quiz item model
│   │   ├── quiz_item_kenal_sekitarku.dart
│   │   └── selectable_item.dart  # Selectable item model
│   ├── modul4/                   # Module 4 features
│   │   ├── core/                 # Core utilities for module 4
│   │   ├── features/             # Feature-specific code
│   │   │   ├── feed_animals/     # Feed animals mini-game
│   │   │   │   └── presentation/
│   │   │   │       └── screens/
│   │   │   │           └── feed_animals_screen.dart
│   │   │   ├── home/             # Home feature for module 4
│   │   │   │   └── widgets/
│   │   │   │       └── home_menu_card.dart
│   │   │   └── tidy_toys/        # Tidy toys mini-game
│   │   │       └── presentation/
│   │   │           └── screens/
│   │   │               └── tidy_toys_screen.dart
│   │   └── utils/                # Utility functions for module 4
│   ├── screens/                  # Main application screens
│   │   ├── emosi_sosial_screen.dart
│   │   ├── game_kenal_sekitarku_screen.dart
│   │   ├── game_screen.dart
│   │   ├── home_screen.dart
│   │   ├── kenal_sekitarku_screen.dart
│   │   ├── result_screen.dart
│   │   └── splash_screen.dart
│   ├── theme/                    # App theming
│   │   └── app_theme.dart        # Application theme configuration
│   └── widgets/                  # Reusable UI components
│       ├── feedback_modal.dart   # Feedback modal widget
│       └── item_card.dart        # Item card widget
├── linux/                        # Linux platform-specific code
│   ├── .gitignore
│   ├── CMakeLists.txt
│   ├── flutter/
│   └── runner/
├── macos/                        # macOS platform-specific code
│   ├── .gitignore
│   ├── Flutter/
│   ├── Runner/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   └── RunnerTests/
├── test/                         # Unit and widget tests
│   └── widget_test.dart          # Basic widget test
├── web/                          # Web platform-specific code
│   ├── favicon.png
│   ├── index.html
│   ├── manifest.json
│   └── icons/
└── windows/                      # Windows platform-specific code
    ├── .gitignore
    ├── CMakeLists.txt
    ├── flutter/
    └── runner/
```

## Dependencies

### Core Dependencies
- **Flutter**: UI framework
- **audioplayers**: Audio playback for sound effects
- **lottie**: Vector animations
- **flutter_tts**: Text-to-speech functionality
- **provider**: State management
- **google_fonts**: Custom typography
- **equatable**: Object comparison
- **gap**: Spacing utilities

### Development Dependencies
- **flutter_lints**: Code linting
- **flutter_launcher_icons**: App icon generation

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with Flutter framework
- Designed for educational purposes
- Audio assets and visual content created for child-friendly learning experience

## Support

For support or questions, please contact the development team or create an issue in the repository.

---

**Note**: This app is designed for children and should be used under adult supervision.
