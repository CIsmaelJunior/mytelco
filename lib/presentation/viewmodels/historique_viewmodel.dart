import 'package:flutter/foundation.dart';
import '../../data/models/consommation_model.dart';
import '../../data/repositories/consommation_repository.dart';

class HistoriqueViewModel extends ChangeNotifier {
  final ConsommationRepository _consommationRepository;

  List<ConsommationModel> _consommations = [];
  ConsommationType _selectedType = ConsommationType.call;
  bool _isLoading = false;
  String? _error;

  HistoriqueViewModel(this._consommationRepository);

  List<ConsommationModel> get consommations => _consommations;
  ConsommationType get selectedType => _selectedType;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Charge l'historique des consommations
  Future<void> loadConsommations() async {
    _setLoading(true);
    _clearError();

    try {
      _consommations = await _consommationRepository.getConsommations();
      _filterConsommationsByType();
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors du chargement de l\'historique: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Change le type de consommation sélectionné
  void selectType(ConsommationType type) {
    _selectedType = type;
    _filterConsommationsByType();
    notifyListeners();
  }

  /// Filtre les consommations par type
  void _filterConsommationsByType() {
    if (_selectedType == ConsommationType.call) {
      _consommations = _consommations.where((c) => c.type == ConsommationType.call).toList();
    } else if (_selectedType == ConsommationType.sms) {
      _consommations = _consommations.where((c) => c.type == ConsommationType.sms).toList();
    } else if (_selectedType == ConsommationType.internet) {
      _consommations = _consommations.where((c) => c.type == ConsommationType.internet).toList();
    }
  }

  /// Récupère les consommations par type
  List<ConsommationModel> getConsommationsByType(ConsommationType type) {
    return _consommations.where((c) => c.type == type).toList();
  }

  /// Formate la date pour l'affichage
  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }

  /// Formate l'heure pour l'affichage
  String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Récupère le nom du type de consommation
  String getTypeName(ConsommationType type) {
    switch (type) {
      case ConsommationType.call:
        return 'Appels';
      case ConsommationType.sms:
        return 'SMS';
      case ConsommationType.internet:
        return 'Internet';
    }
  }

  /// Récupère l'icône du type de consommation
  String getTypeIcon(ConsommationType type) {
    switch (type) {
      case ConsommationType.call:
        return 'assets/icons/Appel orange.svg';
      case ConsommationType.sms:
        return 'assets/icons/sms orange.svg';
      case ConsommationType.internet:
        return 'assets/icons/Wifi orange.svg';
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
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
