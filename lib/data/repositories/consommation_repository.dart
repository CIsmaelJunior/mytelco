import '../models/consommation_model.dart';
import '../services/data_service.dart';

class ConsommationRepository {
  List<ConsommationModel>? _cachedConsommations;

  /// Récupère l'historique de toutes les consommations
  Future<List<ConsommationModel>> getConsommations() async {
    if (_cachedConsommations != null) {
      return _cachedConsommations!;
    }

    try {
      final consommationsData = await DataService.loadConsommationsData();
      _cachedConsommations = consommationsData
          .map((json) => ConsommationModel.fromJson(json))
          .toList();
      
      // Trier par date décroissante (plus récent en premier)
      _cachedConsommations!.sort((a, b) => b.date.compareTo(a.date));
      
      return _cachedConsommations!;
    } catch (e) {
      throw Exception('Impossible de charger les consommations: $e');
    }
  }

  /// Récupère les consommations par type
  Future<List<ConsommationModel>> getConsommationsByType(ConsommationType type) async {
    final consommations = await getConsommations();
    return consommations.where((consommation) => consommation.type == type).toList();
  }

  /// Récupère les consommations récentes (dernières 10)
  Future<List<ConsommationModel>> getRecentConsommations({int limit = 10}) async {
    final consommations = await getConsommations();
    return consommations.take(limit).toList();
  }

  /// Récupère les consommations d'une période donnée
  Future<List<ConsommationModel>> getConsommationsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final consommations = await getConsommations();
    return consommations.where((consommation) {
      return consommation.date.isAfter(startDate) && 
             consommation.date.isBefore(endDate);
    }).toList();
  }

  /// Ajoute une nouvelle consommation
  Future<ConsommationModel> addConsommation(ConsommationModel consommation) async {
    final consommations = await getConsommations();
    final newConsommation = consommation.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    
    _cachedConsommations = [newConsommation, ...consommations];
    return newConsommation;
  }

  /// Vide le cache
  void clearCache() {
    _cachedConsommations = null;
  }
}
