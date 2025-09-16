import 'package:flutter/foundation.dart';
import '../../data/models/pass_model.dart';
import '../../data/repositories/pass_repository.dart';

class PassesViewModel extends ChangeNotifier {
  final PassRepository _passRepository;

  List<PassModel> _passes = [];
  bool _isLoading = false;
  String? _error;
  bool _isCancelling = false;

  PassesViewModel(this._passRepository);

  List<PassModel> get passes => _passes;
  List<PassModel> get activePasses => _passes.where((pass) => pass.status == PassStatus.active).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isCancelling => _isCancelling;

  /// Charge la liste des passes actifs
  Future<void> loadPasses() async {
    _setLoading(true);
    _clearError();

    try {
      _passes = await _passRepository.getActivePasses();
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors du chargement des passes: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Annule un pass
  Future<bool> cancelPass(String passId) async {
    _setCancelling(true);
    _clearError();

    try {
      final success = await _passRepository.cancelPass(passId);
      if (success) {
        // Recharger la liste des passes
        await loadPasses();
      }
      return success;
    } catch (e) {
      _setError('Erreur lors de l\'annulation du pass: $e');
      return false;
    } finally {
      _setCancelling(false);
    }
  }

  /// Formate la date pour l'affichage
  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }

  /// Formate la durée restante
  String formatRemainingTime(int days) {
    if (days <= 0) return 'Expiré';
    if (days == 1) return '1 Jour';
    return '$days Jours';
  }

  /// Calcule le pourcentage de progression
  double getProgressPercentage(PassModel pass) {
    return pass.progressPercentage;
  }

  /// Vérifie si un pass est sur le point d'expirer (moins de 3 jours)
  bool isPassExpiringSoon(PassModel pass) {
    return pass.remainingDays <= 3 && pass.remainingDays > 0;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setCancelling(bool cancelling) {
    _isCancelling = cancelling;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
