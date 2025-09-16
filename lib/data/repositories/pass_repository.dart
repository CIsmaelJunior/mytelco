import '../models/pass_model.dart';
import '../models/forfait_model.dart';
import '../services/data_service.dart';

class PassRepository {
  List<PassModel>? _cachedPasses;

  /// Récupère la liste de tous les passes actifs
  Future<List<PassModel>> getPasses() async {
    if (_cachedPasses != null) {
      return _cachedPasses!;
    }

    try {
      final passesData = await DataService.loadPassesData();
      _cachedPasses = passesData
          .map((json) => PassModel.fromJson(json))
          .toList();
      return _cachedPasses!;
    } catch (e) {
      throw Exception('Impossible de charger les passes: $e');
    }
  }

  /// Récupère un pass par son ID
  Future<PassModel?> getPassById(String id) async {
    final passes = await getPasses();
    try {
      return passes.firstWhere((pass) => pass.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Récupère les passes actifs uniquement
  Future<List<PassModel>> getActivePasses() async {
    final passes = await getPasses();
    return passes.where((pass) => pass.status == PassStatus.active).toList();
  }

  /// Ajoute un nouveau pass (souscription)
  Future<PassModel> subscribeToForfait(ForfaitModel forfait) async {
    final passes = await getPasses();
    
    final newPass = PassModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: forfait.name,
      description: forfait.description,
      activationDate: DateTime.now(),
      expirationDate: DateTime.now().add(Duration(days: forfait.validityDays)),
      icon: forfait.icon,
      status: PassStatus.active,
      price: forfait.price,
      validityDays: forfait.validityDays,
    );

    _cachedPasses = [...passes, newPass];
    return newPass;
  }

  /// Annule un pass (résiliation)
  Future<bool> cancelPass(String passId) async {
    final passes = await getPasses();
    final passIndex = passes.indexWhere((pass) => pass.id == passId);
    
    if (passIndex == -1) {
      return false;
    }

    final updatedPass = passes[passIndex].copyWith(status: PassStatus.cancelled);
    _cachedPasses = [
      ...passes.sublist(0, passIndex),
      updatedPass,
      ...passes.sublist(passIndex + 1),
    ];

    return true;
  }

  /// Vide le cache
  void clearCache() {
    _cachedPasses = null;
  }
}
