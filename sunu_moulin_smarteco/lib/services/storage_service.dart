import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunu_moulin_smarteco/models/app_models.dart';

// Service pour gérer le stockage de données local avec Hive.
class StorageService {
  // TODO: Implémenter l'initialisation de Hive et les méthodes CRUD pour les modèles.
  Future<void> init() async {
    await Hive.initFlutter();
    // Enregistrer les adaptateurs pour les modèles ici.
  }
}
