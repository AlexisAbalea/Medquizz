import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Paths to sound assets
  static const String _correctSound = 'assets/sounds/correct.mp3';
  static const String _wrongSound = 'assets/sounds/wrong.mp3';
  static const String _endSound = 'assets/sounds/end.mp3';

  /// Play correct answer sound
  Future<void> playCorrectSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/correct.mp3'));
    } catch (e) {
      // Silently fail if sound can't be played
    }
  }

  /// Play wrong answer sound
  Future<void> playWrongSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/wrong.mp3'));
    } catch (e) {
      // Silently fail if sound can't be played
    }
  }

  /// Play quiz end sound
  Future<void> playEndSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/end.mp3'));
    } catch (e) {
      // Silently fail if sound can't be played
    }
  }

  /// Stop any currently playing sound
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      // Silently fail
    }
  }

  /// Dispose of the audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}
