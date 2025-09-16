# MyTelco - Application de Gestion Télécom

## 📱 Description

MyTelco est une application Flutter de gestion de compte télécom qui permet aux utilisateurs de consulter leur solde, gérer leurs forfaits actifs et suivre leur historique de consommation.

## ✨ Fonctionnalités

### 🏠 Page d'Accueil (Dashboard)
- Affichage du profil utilisateur avec nom et numéro de téléphone
- Solde principal avec date de validité
- Volume internet restant (en Go)
- Minutes d'appel restantes
- SMS restants
- Design responsive adapté mobile et tablette

### 📦 Forfaits Disponibles
- Liste des forfaits télécom (data, voix, mixtes)
- Informations détaillées : nom, description, prix, validité
- Badge "Forfait Populaire" pour les offres recommandées
- Souscription en un clic avec confirmation
- Vérification du solde avant souscription

### 🎫 Mes Pass Actifs
- Liste des forfaits souscrits
- Dates d'activation et d'expiration
- Barre de progression du temps restant
- Statut actif avec indicateur visuel
- Résiliation de pass avec confirmation

### 📊 Historique des Consommations
- Filtres par type : Appels, Internet, SMS
- Liste chronologique des consommations
- Détails : montant, destination, date
- Interface intuitive avec onglets

## 🏗️ Architecture

L'application utilise une architecture **MVVM (Model-View-ViewModel)** avec les composants suivants :

### 📁 Structure des Dossiers

```
lib/
├── core/
│   ├── constants/          # Constantes de l'application
│   ├── theme/             # Thème et styles
│   └── utils/             # Utilitaires (responsive, etc.)
├── data/
│   ├── models/            # Modèles de données
│   ├── repositories/      # Couche d'accès aux données
│   └── services/          # Services de données
├── presentation/
│   ├── pages/             # Pages de l'application
│   ├── viewmodels/        # ViewModels (logique métier)
│   └── widgets/           # Widgets réutilisables
└── assets/
    ├── data/              # Fichiers JSON de données
    └── icons/             # Icônes SVG
```

### 🔧 Technologies Utilisées

- **Flutter** : Framework de développement
- **Provider** : Gestion d'état
- **Google Fonts** : Police Roboto
- **Flutter SVG** : Support des icônes SVG
- **JSON Serialization** : Sérialisation des données
- **Intl** : Formatage des dates et nombres

## 🚀 Installation et Lancement

### Prérequis
- Flutter SDK (version 3.9.2 ou supérieure)
- Dart SDK
- Android Studio / VS Code avec extensions Flutter

### Installation

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   cd mytelco
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers de sérialisation**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Lancer l'application**
   ```bash
   flutter run
   ```

### Tests

```bash
# Lancer les tests
flutter test

# Analyser le code
flutter analyze
```

## 📱 Design et UI/UX

### 🎨 Palette de Couleurs
- **Orange Principal** : #FF8C00
- **Orange Secondaire** : #FFA500
- **Orange Clair** : #FFEDD5
- **Vert Succès** : #4CAF50
- **Vert Clair** : #E8F5E8
- **Texte Sombre** : #1F2937
- **Texte Gris** : #6B7280
- **Arrière-plan** : #F9FAFB

### 📐 Responsive Design
- **Mobile** : Interface optimisée pour smartphones
- **Tablette** : Adaptation automatique avec colonnes multiples
- **Breakpoints** : 768px (tablette), 1024px (desktop)

### 🔤 Typographie
- **Police** : Roboto (Google Fonts)
- **Tailles** : 12px à 28px selon le contexte
- **Poids** : Normal, Medium, Bold selon la hiérarchie

## 📊 Gestion des Données

### 📁 Sources de Données JSON

L'application utilise des données JSON statiques stockées dans `assets/data/` :

- **`user_data.json`** : Informations utilisateur (nom, téléphone, solde, volumes)
- **`forfaits_data.json`** : Catalogue des forfaits disponibles
- **`passes_data.json`** : Passes actifs de l'utilisateur
- **`consommations_data.json`** : Historique des consommations

### 🔄 Flux de Chargement des Données

```
assets/data/*.json → DataService → Repository → ViewModel → UI
```

1. **DataService** (`lib/data/services/data_service.dart`)
   - Charge les fichiers JSON depuis les assets
   - Gère les erreurs de chargement
   - Retourne des Map<String, dynamic>

2. **Repository** (`lib/data/repositories/`)
   - Interface entre les données et la logique métier
   - Cache les données en mémoire
   - Transforme les Map en objets typés (Models)

3. **ViewModel** (`lib/presentation/viewmodels/`)
   - Logique métier et état de l'interface
   - Appelle les repositories
   - Notifie l'UI des changements

### 🔌 Connexion Backend - Très Simple !

L'architecture actuelle est **parfaitement préparée** pour une connexion backend. Voici comment l'intégrer :

#### 🚀 Migration vers API Backend

**1. Remplacer DataService par ApiService :**

```dart
// lib/data/services/api_service.dart
class ApiService {
  static const String baseUrl = 'https://api.mytelco.com';
  
  static Future<Map<String, dynamic>> loadUserData() async {
    final response = await http.get(Uri.parse('$baseUrl/user'));
    return json.decode(response.body);
  }
  
  static Future<List<Map<String, dynamic>>> loadForfaitsData() async {
    final response = await http.get(Uri.parse('$baseUrl/forfaits'));
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }
}
```

**2. Modifier les Repositories :**

```dart
// lib/data/repositories/user_repository.dart
class UserRepository {
  Future<UserModel> getUser() async {
    // Remplacer DataService.loadUserData() par ApiService.loadUserData()
    final userData = await ApiService.loadUserData();
    return UserModel.fromJson(userData);
  }
}
```

**3. Ajouter la gestion d'authentification :**

```dart
// lib/data/services/auth_service.dart
class AuthService {
  static Future<String> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'phone': phone, 'password': password},
    );
    return response.headers['authorization'] ?? '';
  }
}
```

#### ✅ Avantages de l'Architecture Actuelle

- **Séparation claire** : Data/Repository/ViewModel/UI
- **Modèles typés** : Prêts pour la sérialisation JSON
- **Gestion d'erreurs** : Déjà implémentée
- **Cache** : Système de cache en mémoire
- **État** : Provider gère déjà les états de chargement

#### 🔧 Étapes pour Backend

1. **Ajouter http** dans `pubspec.yaml`
2. **Créer ApiService** (remplace DataService)
3. **Modifier les Repositories** (changer les appels)
4. **Ajouter l'authentification** (AuthService)
5. **Gérer les tokens** (stockage sécurisé)

**Temps estimé : 2-4 heures** pour une migration complète !

#### 📋 Exemples de Structure JSON

**Données Utilisateur** (`user_data.json`) :
```json
{
  "name": "Eddy sosthene !",
  "phoneNumber": "07 00 00 00 00",
  "balance": 18525.0,
  "balanceValidity": "20/09/2025",
  "internetVolume": 3.56,
  "minutes": 35,
  "sms": 303,
  "volumeValidity": "20/09/2025"
}
```

**Forfaits** (`forfaits_data.json`) :
```json
[
  {
    "id": "1",
    "name": "Pass Internet 5GB",
    "description": "Naviguez sans limite avec 5 Go de data",
    "price": 3000.0,
    "validityDays": 15,
    "icon": "assets/icons/Wifi.svg",
    "features": ["5GB de data", "4G/5G inclus", "Valable 30 jours"],
    "isPopular": false,
    "type": "internet"
  }
]
```

**Passes Actifs** (`passes_data.json`) :
```json
[
  {
    "id": "1",
    "name": "Pass Internet 5GB",
    "icon": "assets/icons/Wifi.svg",
    "activationDate": "2025-09-01T00:00:00.000Z",
    "expirationDate": "2025-09-15T23:59:59.000Z",
    "remainingDays": 15
  }
]
```

## 🔄 Gestion d'État

L'application utilise **Provider** pour la gestion d'état avec :

- **ViewModels** : Logique métier et état des pages
- **Repositories** : Accès aux données avec cache
- **Services** : Chargement des données JSON

## 🎯 Fonctionnalités Techniques

### ✅ Implémentées
- [x] Architecture MVVM complète
- [x] Navigation par onglets
- [x] Design responsive
- [x] Gestion d'état avec Provider
- [x] Sérialisation JSON
- [x] Thème personnalisé
- [x] Widgets réutilisables
- [x] Gestion d'erreurs
- [x] Loading states
- [x] Confirmations d'actions

### 🔮 Améliorations Possibles
- [ ] Persistance des données (SQLite/Hive)
- [ ] Authentification utilisateur
- [ ] API backend
- [ ] Notifications push
- [ ] Mode sombre
- [ ] Internationalisation
- [ ] Tests unitaires étendus
- [ ] CI/CD


## 👨‍💻 Développement

### 🔧 Commandes Utiles

```bash
# Nettoyer le projet
flutter clean

# Mettre à jour les dépendances
flutter pub upgrade

# Analyser le code
flutter analyze

# Formater le code
dart format .

# Lancer en mode debug
flutter run --debug

# Lancer en mode release
flutter run --release
```

### 📋 Checklist de Développement

- [x] Structure de projet organisée
- [x] Architecture MVVM implémentée
- [x] Thème et design system
- [x] Navigation fonctionnelle
- [x] Gestion d'état
- [x] Données JSON intégrées
- [x] Responsive design
- [x] Tests de base
- [x] Documentation

## 📄 Licence

Ce projet est développé dans le cadre d'un test technique. Tous droits réservés.

---
