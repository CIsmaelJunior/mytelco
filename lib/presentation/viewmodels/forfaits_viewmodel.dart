import 'package:flutter/foundation.dart';
import '../../data/models/forfait_model.dart';
import '../../data/repositories/forfait_repository.dart';
import '../../data/repositories/pass_repository.dart';
import '../../data/repositories/user_repository.dart';

class ForfaitsViewModel extends ChangeNotifier {
  final ForfaitRepository _forfaitRepository;
  final PassRepository _passRepository;
  final UserRepository _userRepository;

  List<ForfaitModel> _forfaits = [];
  bool _isLoading = false;
  String? _error;
  bool _isSubscribing = false;

  ForfaitsViewModel(
    this._forfaitRepository,
    this._passRepository,
    this._userRepository,
  );

  List<ForfaitModel> get forfaits => _forfaits;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSubscribing => _isSubscribing;

  /// Charge la liste des forfaits disponibles
  Future<void> loadForfaits() async {
    _setLoading(true);
    _clearError();

    try {
      _forfaits = await _forfaitRepository.getForfaits();
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors du chargement des forfaits: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Souscrit à un forfait
  Future<bool> subscribeToForfait(ForfaitModel forfait) async {
    _setSubscribing(true);
    _clearError();

    try {
      // Vérifier le solde de l'utilisateur
      final user = await _userRepository.getUser();
      if (user.balance < forfait.price) {
        _setError('Solde insuffisant pour souscrire à ce forfait');
        return false;
      }

      // Ajouter le pass
      await _passRepository.subscribeToForfait(forfait);

      // Déduire le montant du solde
      await _userRepository.updateBalance(user.balance - forfait.price);

      return true;
    } catch (e) {
      _setError('Erreur lors de la souscription: $e');
      return false;
    } finally {
      _setSubscribing(false);
    }
  }

  /// Récupère les forfaits populaires
  List<ForfaitModel> get popularForfaits {
    return _forfaits.where((forfait) => forfait.isPopular).toList();
  }

  /// Récupère les forfaits par type
  List<ForfaitModel> getForfaitsByType(ForfaitType type) {
    return _forfaits.where((forfait) => forfait.type == type).toList();
  }

  /// Formate le prix pour l'affichage
  String formatPrice(double price) {
    return '${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]} ',
    )} FCFA';
  }

  /// Formate la validité
  String formatValidity(int days) {
    if (days == 1) return '1 Jour';
    if (days < 7) return '$days Jours';
    if (days == 7) return '1 Semaine';
    if (days < 30) return '${(days / 7).ceil()} Semaines';
    if (days == 30) return '1 Mois';
    return '${(days / 30).ceil()} Mois';
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setSubscribing(bool subscribing) {
    _isSubscribing = subscribing;
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
