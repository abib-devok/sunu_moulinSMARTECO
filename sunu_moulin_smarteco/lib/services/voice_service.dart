import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Service pour gérer la synthèse vocale (TTS) et la reconnaissance vocale (STT).
class VoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();

  // TODO: Implémenter les méthodes pour parler, écouter et gérer les langues.
  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }
}
