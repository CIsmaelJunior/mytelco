import 'dart:convert';
import 'package:flutter/services.dart';

class DataService {
  static const String _userDataPath = 'assets/data/user_data.json';
  static const String _forfaitsDataPath = 'assets/data/forfaits_data.json';
  static const String _passesDataPath = 'assets/data/passes_data.json';
  static const String _consommationsDataPath = 'assets/data/consommations_data.json';

  /// Charge les données utilisateur depuis le fichier JSON
  static Future<Map<String, dynamic>> loadUserData() async {
    try {
      final String jsonString = await rootBundle.loadString(_userDataPath);
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Erreur lors du chargement des données utilisateur: $e');
    }
  }

  /// Charge la liste des forfaits depuis le fichier JSON
  static Future<List<Map<String, dynamic>>> loadForfaitsData() async {
    try {
      final String jsonString = await rootBundle.loadString(_forfaitsDataPath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Erreur lors du chargement des forfaits: $e');
    }
  }

  /// Charge la liste des passes actifs depuis le fichier JSON
  static Future<List<Map<String, dynamic>>> loadPassesData() async {
    try {
      final String jsonString = await rootBundle.loadString(_passesDataPath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Erreur lors du chargement des passes: $e');
    }
  }

  /// Charge l'historique des consommations depuis le fichier JSON
  static Future<List<Map<String, dynamic>>> loadConsommationsData() async {
    try {
      final String jsonString = await rootBundle.loadString(_consommationsDataPath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Erreur lors du chargement des consommations: $e');
    }
  }
}
