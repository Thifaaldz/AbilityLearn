import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  bool _isHomeMusicPlaying = false;

  AudioPlayer get backgroundPlayer => _backgroundPlayer;

  Future<void> playHomeBackgroundMusic() async {
    if (!_isHomeMusicPlaying) {
      try {
        await _backgroundPlayer.setVolume(0.3);
        await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
        await _backgroundPlayer.play(AssetSource('audio/backsound main.mp3'));
        _isHomeMusicPlaying = true;
        notifyListeners();
      } catch (e) {
        print("Error playing home background music: $e");
      }
    }
  }

  Future<void> stopHomeBackgroundMusic() async {
    if (_isHomeMusicPlaying) {
      await _backgroundPlayer.stop();
      _isHomeMusicPlaying = false;
      notifyListeners();
    }
  }

  void dispose() {
    _backgroundPlayer.dispose();
  }
}
