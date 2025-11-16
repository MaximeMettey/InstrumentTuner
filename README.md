# 🎵 Instrument Tuner

Une application d'accordeur multi-plateforme professionnelle avec support multilingue et reconnaissance de notes en temps réel.

## ✨ Fonctionnalités

- 🎸 **Support de nombreux instruments**
  - Guitare (6, 7, 8 cordes)
  - Basse (4 cordes)
  - Ukulélé
  - Violon, Alto, Violoncelle
  - Mandoline
  - Banjo

- 🎼 **Accordages préenregistrés**
  - Standard
  - Drop D, Drop C
  - Open G, Open D
  - DADGAD
  - Demi-ton / Ton descendant
  - Et bien d'autres...

- 🎤 **Détection de pitch en temps réel**
  - Reconnaissance automatique des notes
  - Affichage précis en centièmes
  - Visualisation avec jauge dynamique
  - Haute précision avec FFT

- 🔊 **Génération de tonalités**
  - Écoute des notes de référence
  - Générateur d'ondes sinusoïdales
  - Qualité audio optimale

- 🌍 **Support multilingue**
  - Français 🇫🇷
  - English 🇬🇧
  - Español 🇪🇸
  - Deutsch 🇩🇪

- 🎨 **Interface moderne**
  - Design Material 3
  - Mode sombre / clair
  - Animations fluides
  - Interface épurée et intuitive

- 📱 **Cross-platform**
  - Android
  - iOS
  - Web
  - Windows
  - macOS
  - Linux

## 🚀 Installation

### Prérequis

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0+)
- Dart SDK (inclus avec Flutter)

### Installation des dépendances

```bash
flutter pub get
```

### Génération des fichiers de localisation

```bash
flutter gen-l10n
```

## 🏃 Lancement

### Android / iOS

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios
```

### Web

```bash
flutter run -d chrome
```

### Desktop

```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 🏗️ Architecture

Le projet suit une architecture propre et modulaire :

```
lib/
├── models/          # Modèles de données
│   ├── note.dart
│   ├── tuning.dart
│   └── instrument.dart
├── services/        # Services (audio, détection)
│   ├── pitch_detector.dart
│   └── audio_player_service.dart
├── providers/       # State management (Provider)
│   ├── tuner_provider.dart
│   └── settings_provider.dart
├── screens/         # Écrans de l'application
│   ├── tuner_screen.dart
│   ├── instruments_screen.dart
│   └── settings_screen.dart
├── widgets/         # Widgets réutilisables
│   ├── tuner_gauge.dart
│   └── string_selector.dart
├── l10n/           # Fichiers de traduction
│   ├── app_en.arb
│   ├── app_fr.arb
│   ├── app_es.arb
│   └── app_de.arb
└── main.dart       # Point d'entrée
```

## 🔧 Technologies utilisées

- **Flutter** - Framework UI cross-platform
- **Provider** - Gestion d'état
- **FFT** - Transformée de Fourier rapide pour la détection de pitch
- **mic_stream** - Accès au microphone
- **audioplayers** - Lecture audio
- **Google Fonts** - Polices personnalisées
- **flutter_animate** - Animations

## 📖 Utilisation

1. **Sélectionner un instrument**
   - Appuyez sur la carte de l'instrument en haut
   - Choisissez votre instrument et accordage

2. **Mode Auto-détection**
   - Activez le mode auto-détection
   - Appuyez sur "Appuyez pour commencer"
   - Jouez une note - l'app détecte automatiquement la corde

3. **Mode Manuel**
   - Désactivez le mode auto-détection
   - Sélectionnez la corde à accorder
   - Jouez la corde et accordez selon l'indication

4. **Écouter une note de référence**
   - En mode manuel, appuyez sur l'icône de volume sur une corde
   - L'app joue la note de référence

## 🎯 Précision

L'application utilise un algorithme FFT avec interpolation parabolique pour une précision au centième près. L'affichage indique :

- **Vert** : Accordé (±5 centièmes)
- **Orange** : Proche (±15 centièmes)
- **Rouge** : Désaccordé (>15 centièmes)

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche pour votre fonctionnalité
3. Commit vos changements
4. Push vers la branche
5. Ouvrir une Pull Request

## 📝 License

Ce projet est sous licence MIT.

## 👨‍💻 Auteur

Créé avec ❤️ en utilisant Flutter