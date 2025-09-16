import '../models/forfait_model.dart';
import '../services/data_service.dart';

class ForfaitRepository {
  List<ForfaitModel>? _cachedForfaits;

  /// Récupère la liste de tous les forfaits disponibles
  Future<List<ForfaitModel>> getForfaits() async {
    if (_cachedForfaits != null) {
      return _cachedForfaits!;
    }

    try {
      final forfaitsData = await DataService.loadForfaitsData();
      _cachedForfaits = forfaitsData
          .map((json) => ForfaitModel.fromJson(json))
          .toList();
      return _cachedForfaits!;
    } catch (e) {
      throw Exception('Impossible de charger les forfaits: $e');
    }
  }

  /// Récupère un forfait par son ID
  Future<ForfaitModel?> getForfaitById(String id) async {
    final forfaits = await getForfaits();
    try {
      return forfaits.firstWhere((forfait) => forfait.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Récupère les forfaits populaires
  Future<List<ForfaitModel>> getPopularForfaits() async {
    final forfaits = await getForfaits();
    return forfaits.where((forfait) => forfait.isPopular).toList();
  }

  /// Récupère les forfaits par type
  Future<List<ForfaitModel>> getForfaitsByType(ForfaitType type) async {
    final forfaits = await getForfaits();
    return forfaits.where((forfait) => forfait.type == type).toList();
  }

  /// Vide le cache
  void clearCache() {
    _cachedForfaits = null;
  }
}
