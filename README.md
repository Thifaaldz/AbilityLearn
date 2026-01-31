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
lib/
├── main.dart                 # App entry point
├── screens/                  # Main application screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── game_screen.dart
│   └── ...
├── widgets/                  # Reusable UI components
├── models/                   # Data models
├── data/                     # Static data and configurations
├── theme/                    # App theming
└── modul4/                   # Modular features (games)

assets/
├── images/                   # Image assets
└── audio/                    # Audio files
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
