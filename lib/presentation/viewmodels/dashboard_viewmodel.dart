import 'package:flutter/foundation.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class DashboardViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  DashboardViewModel(this._userRepository);

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Charge les données de l'utilisateur
  Future<void> loadUserData() async {
    _setLoading(true);
    _clearError();

    try {
      _user = await _userRepository.getUser();
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors du chargement des données: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Met à jour le solde après une transaction
  Future<void> updateBalance(double newBalance) async {
    try {
      _user = await _userRepository.updateBalance(newBalance);
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors de la mise à jour du solde: $e');
    }
  }

  /// Met à jour le volume internet
  Future<void> updateInternetVolume(double newVolume) async {
    try {
      _user = await _userRepository.updateInternetVolume(newVolume);
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors de la mise à jour du volume: $e');
    }
  }

  /// Met à jour les minutes
  Future<void> updateMinutes(int newMinutes) async {
    try {
      _user = await _userRepository.updateMinutes(newMinutes);
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors de la mise à jour des minutes: $e');
    }
  }

  /// Met à jour les SMS
  Future<void> updateSms(int newSms) async {
    try {
      _user = await _userRepository.updateSms(newSms);
      notifyListeners();
    } catch (e) {
      _setError('Erreur lors de la mise à jour des SMS: $e');
    }
  }

  /// Formate le solde pour l'affichage
  String get formattedBalance {
    if (_user == null) return '0 FCFA';
    return '${_user!.balance.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]} ',
    )} FCFA';
  }

  /// Formate le volume internet
  String get formattedInternetVolume {
    if (_user == null) return '0 Go';
    return '${_user!.internetVolume.toStringAsFixed(2)} Go';
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
