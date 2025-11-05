import 'dart:async';
import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Service pour gérer la communication Bluetooth Low Energy (BLE).
class BleService {
  final Random _random = Random();
  Timer? _timer;

  // StreamController pour diffuser les fausses données des capteurs.
  final _sensorDataController = StreamController<Map<String, double>>.broadcast();
  Stream<Map<String, double>> get sensorDataStream => _sensorDataController.stream;

  // Simule le scan des appareils BLE.
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  void startSensorSimulation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final tempData = 60 + _random.nextDouble() * 10; // Température entre 60 et 70
      final vibData = 0.2 + _random.nextDouble() * 0.3; // Vibration entre 0.2 et 0.5
      final progData = timer.tick / 100; // Progression jusqu'à 100% en 100 secondes

      _sensorDataController.add({
        'temperature': tempData,
        'vibration': vibData,
        'progress': progData > 1 ? 1 : progData,
      });

      if (progData >= 1) {
        stopSensorSimulation();
      }
    });
  }

  void stopSensorSimulation() {
    _timer?.cancel();
  }

  void dispose() {
    _sensorDataController.close();
  }
}
