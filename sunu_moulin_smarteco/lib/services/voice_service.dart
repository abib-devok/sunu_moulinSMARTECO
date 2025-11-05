import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Service pour gérer la synthèse vocale (TTS) et la reconnaissance vocale (STT).
class VoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();

  Future<void> init() async {
    await _flutterTts.setLanguage("fr-FR");
    await _speechToText.initialize();
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  // Simule l'écoute d'une commande vocale.
  Future<String> listen() async {
    // Dans une vraie application, on utiliserait _speechToText.listen(...)
    // et on attendrait un résultat. Ici, on simule.
    await Future.delayed(const Duration(seconds: 2));
    return "démarrer";
  }
}
