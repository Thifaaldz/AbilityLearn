# TODO: Add Sound Effects to Feedback Modal

- [ ] Import audioplayers package in lib/widgets/feedback_modal.dart
- [ ] Add AudioPlayer instance to _FeedbackModalState class
- [ ] Modify initState to play correct/wrong sound after TTS initialization
- [ ] Modify dispose method to dispose AudioPlayer

  void _playBackgroundMusic() async {
    try {
      await _backgroundPlayer.setVolume(0.3); // Lower volume for background music
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundPlayer.play(AssetSource('audio/background music.mp3'));
    } catch (e) {
      print("Error playing background music: $e");
    }
  }