import '../models/user_model.dart';
import '../services/data_service.dart';

class UserRepository {
  UserModel? _cachedUser;

  /// Récupère les données de l'utilisateur
  Future<UserModel> getUser() async {
    if (_cachedUser != null) {
      return _cachedUser!;
    }

    try {
      final userData = await DataService.loadUserData();
      _cachedUser = UserModel.fromJson(userData);
      return _cachedUser!;
    } catch (e) {
      throw Exception('Impossible de charger les données utilisateur: $e');
    }
  }

  /// Met à jour le solde de l'utilisateur
  Future<UserModel> updateBalance(double newBalance) async {
    final user = await getUser();
    _cachedUser = user.copyWith(balance: newBalance);
    return _cachedUser!;
  }

  /// Met à jour le volume internet restant
  Future<UserModel> updateInternetVolume(double newVolume) async {
    final user = await getUser();
    _cachedUser = user.copyWith(internetVolume: newVolume);
    return _cachedUser!;
  }

  /// Met à jour les minutes restantes
  Future<UserModel> updateMinutes(int newMinutes) async {
    final user = await getUser();
    _cachedUser = user.copyWith(minutes: newMinutes);
    return _cachedUser!;
  }

  /// Met à jour le nombre de SMS restants
  Future<UserModel> updateSms(int newSms) async {
    final user = await getUser();
    _cachedUser = user.copyWith(sms: newSms);
    return _cachedUser!;
  }

  /// Vide le cache
  void clearCache() {
    _cachedUser = null;
  }
}
