import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunu_moulin_smarteco/services/ble_service.dart';
import 'package:sunu_moulin_smarteco/services/storage_service.dart';
import 'package:sunu_moulin_smarteco/services/voice_service.dart';

// --- App Providers ---

// Gère la locale (langue) actuelle de l'application.
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  // La locale par défaut est le français.
  LocaleNotifier() : super(const Locale('fr'));

  void setLocale(String languageCode) {
    state = Locale(languageCode);
  }
}

// --- Service Providers ---

// Fournit une instance unique du StorageService.
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// Fournit une instance unique du VoiceService.
final voiceServiceProvider = Provider<VoiceService>((ref) {
  return VoiceService();
});

// Fournit une instance unique du BleService.
final bleServiceProvider = Provider<BleService>((ref) {
  return BleService();
});
