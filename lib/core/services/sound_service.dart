import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playCorrectSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/correct.mp3'));
    } catch (_) {}
  }

  Future<void> playWrongSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/wrong.mp3'));
    } catch (_) {}
  }

  Future<void> playEndSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/end.mp3'));
    } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (_) {}
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
