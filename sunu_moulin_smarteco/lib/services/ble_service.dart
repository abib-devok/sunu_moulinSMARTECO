import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Service pour gérer la communication Bluetooth Low Energy (BLE).
class BleService {
  final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  // TODO: Implémenter le scan, la connexion, la lecture/écriture de caractéristiques.
  Stream<List<ScanResult>> get scanResults => _flutterBlue.scanResults;
}
