# Guide de Contribution - MyTelco

Merci de votre intérêt à contribuer au projet MyTelco ! 🎉

## 🚀 Comment Contribuer

### 1. Fork et Clone
```bash
# Fork le repository sur GitHub
# Puis clonez votre fork
git clone https://github.com/VOTRE_USERNAME/mytelco.git
cd mytelco
```

### 2. Configuration de l'Environnement
```bash
# Installer les dépendances
flutter pub get

# Générer les fichiers de sérialisation
flutter packages pub run build_runner build

# Lancer l'application
flutter run
```

### 3. Créer une Branche
```bash
git checkout -b feature/nom-de-votre-feature
# ou
git checkout -b fix/nom-du-bug
```

### 4. Développement
- Suivez l'architecture MVVM existante
- Respectez les conventions de nommage Dart/Flutter
- Ajoutez des tests pour les nouvelles fonctionnalités
- Documentez votre code

### 5. Tests
```bash
# Lancer les tests
flutter test

# Analyser le code
flutter analyze

# Formater le code
dart format .
```

### 6. Commit et Push
```bash
git add .
git commit -m "feat: ajouter nouvelle fonctionnalité"
git push origin feature/nom-de-votre-feature
```

### 7. Pull Request
- Créez une Pull Request sur GitHub
- Décrivez clairement vos changements
- Référencez les issues liées si applicable

## 📋 Standards de Code

### Architecture
- **MVVM** : Model-View-ViewModel
- **Provider** : Gestion d'état
- **Repository Pattern** : Accès aux données

### Conventions
- **Nommage** : camelCase pour les variables, PascalCase pour les classes
- **Fichiers** : snake_case pour les noms de fichiers
- **Commentaires** : En français, clairs et concis

### Structure des Dossiers
```
lib/
├── core/           # Constantes, thème, utilitaires
├── data/           # Modèles, repositories, services
└── presentation/   # Pages, viewmodels, widgets
```

## 🐛 Signaler un Bug

1. Vérifiez que le bug n'a pas déjà été signalé
2. Créez une issue avec :
   - Description claire du problème
   - Étapes pour reproduire
   - Comportement attendu vs actuel
   - Captures d'écran si applicable

## ✨ Proposer une Fonctionnalité

1. Créez une issue avec le label "enhancement"
2. Décrivez la fonctionnalité souhaitée
3. Expliquez pourquoi elle serait utile
4. Proposez une implémentation si possible

## 📝 Types de Commits

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `style:` Formatage, point-virgules manquants, etc.
- `refactor:` Refactoring du code
- `test:` Ajout ou modification de tests
- `chore:` Maintenance, dépendances, etc.

## 🤝 Code de Conduite

- Soyez respectueux et constructif
- Acceptez les critiques constructives
- Aidez les autres contributeurs
- Respectez les décisions de l'équipe

## 📞 Contact

Pour toute question, n'hésitez pas à :
- Créer une issue sur GitHub
- Contacter l'équipe de développement

Merci de contribuer à MyTelco ! 🚀
