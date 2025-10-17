# Commandes Flutter HippoQuiz

# BUILD RELEASE

flutter build appbundle --release

Ce fichier contient toutes les commandes utiles pour développer et déployer l'application HippoQuiz.

## 🚀 Développement

### Lancer l'application

```bash
# Sur un émulateur/appareil connecté
flutter run

# Sur un émulateur Android spécifique
flutter run -d <device-id>

# En mode debug avec hot reload
flutter run --debug

# En mode release (performance optimale)
flutter run --release

# Sur Chrome (pour tester l'UI rapidement)
flutter run -d chrome
```

### Gestion des dépendances

```bash
# Installer/mettre à jour les dépendances
flutter pub get

# Mettre à jour toutes les dépendances
flutter pub upgrade

# Vérifier les dépendances obsolètes
flutter pub outdated

# Nettoyer le cache et rebuilder
flutter clean
flutter pub get
```

## 🔍 Qualité du code

### Analyse statique

```bash
# Analyser le code (détection d'erreurs et warnings)
flutter analyze

# Lancer les tests unitaires
flutter test

# Lancer un test spécifique
flutter test test/specific_test.dart

# Tests avec couverture de code
flutter test --coverage
```

### Formatage

```bash
# Formater automatiquement tout le code
dart format lib/ test/

# Vérifier le formatage sans modifier
dart format --output=none --set-exit-if-changed lib/
```

## 📦 Build Android

### Builds de développement

```bash
# APK debug (pour tester)
flutter build apk --debug

# APK debug avec split par architecture (fichiers plus petits)
flutter build apk --debug --split-per-abi
```

### Builds de production

```bash
# APK release (pour distribution manuelle)
flutter build apk --release

# APK release avec split par architecture (recommandé)
flutter build apk --release --split-per-abi

# App Bundle pour Google Play Store (RECOMMANDÉ)
flutter build appbundle --release

# Build avec obfuscation du code (sécurité accrue)
flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols
```

### Fichiers générés

- **APK debug** : `build/app/outputs/flutter-apk/app-debug.apk`
- **APK release** : `build/app/outputs/flutter-apk/app-release.apk`
- **App Bundle** : `build/app/outputs/bundle/release/app-release.aab`

## 🍎 Build iOS (nécessite macOS)

```bash
# Build iOS debug
flutter build ios --debug

# Build iOS release
flutter build ios --release

# Générer l'archive IPA pour App Store
flutter build ipa --release
```

## 🧹 Nettoyage

```bash
# Nettoyer les builds
flutter clean

# Nettoyer + reconstruire
flutter clean && flutter pub get

# Nettoyer le cache Gradle (Android seulement)
cd android && ./gradlew clean && cd ..

# Arrêter tous les démons Gradle
cd android && ./gradlew --stop && cd ..
```

## 🔧 Maintenance

### Mise à jour Flutter

```bash
# Mettre à jour Flutter SDK
flutter upgrade

# Vérifier l'installation Flutter
flutter doctor

# Vérifier en détail
flutter doctor -v
```

### Gestion des icônes d'application

```bash
# Générer les icônes d'app depuis flutter_launcher_icons
flutter pub run flutter_launcher_icons
```

### Base de données SQLite

```bash
# Pour réinitialiser la base de données :
# 1. Désinstaller l'app de l'appareil
# 2. Réinstaller avec : flutter run
```

## 📊 Informations utiles

### Lister les appareils connectés

```bash
flutter devices
```

### Voir les logs en temps réel

```bash
# Logs de l'application en cours
flutter logs

# Logs Android (adb)
adb logcat

# Effacer les logs Android
adb logcat -c
```

### Ouvrir l'émulateur Android

```bash
# Lister les émulateurs disponibles
flutter emulators

# Lancer un émulateur spécifique
flutter emulators --launch <emulator-id>
```

## 🚢 Publication sur Google Play Store

### Étapes de publication

1. **Préparer le build**

   ```bash
   flutter build appbundle --release
   ```

2. **Fichier à uploader**

   - Fichier : `build/app/outputs/bundle/release/app-release.aab`
   - Taille : ~40-60 MB (selon les assets)

3. **Informations de version**

   - Modifier dans `pubspec.yaml` : `version: 1.0.0+1`
   - Format : `versionName+versionCode`

4. **Générer les symboles de débogage** (pour crash reports)
   ```bash
   flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols
   ```
   - Uploader le dossier `symbols` dans Google Play Console

### Checklist avant publication

- [ ] Tester l'app en mode release : `flutter run --release`
- [ ] Vérifier qu'il n'y a pas d'erreurs : `flutter analyze`
- [ ] Incrémenter la version dans `pubspec.yaml`
- [ ] Générer le bundle : `flutter build appbundle --release`
- [ ] Tester l'installation du bundle avec `bundletool`

## 🛠️ Dépannage

### Problèmes courants

**"Gradle build failed"**

```bash
cd android && ./gradlew clean && ./gradlew --stop && cd ..
flutter clean
flutter pub get
flutter build apk --debug
```

**"Version conflict" ou dépendances corrompues**

```bash
flutter clean
rm pubspec.lock
flutter pub get
```

**"Cache corrompu"**

```bash
# Supprimer le cache Gradle (Windows)
rm -rf C:\Users\<Username>\.gradle\caches

# Reconstruire
flutter clean && flutter pub get
```

**"Hot reload ne fonctionne pas"**

```bash
# Arrêter et relancer l'app
r (dans le terminal Flutter)
# ou redémarrage complet
R (dans le terminal Flutter)
```

## 📝 Notes importantes

- **Toujours tester en mode release** avant de publier : `flutter run --release`
- **App Bundle vs APK** : Utilisez toujours `.aab` pour Google Play Store (taille optimisée)
- **Obfuscation** : Activez pour la production pour protéger le code
- **Signing Config** : Configuré dans `android/app/build.gradle` avec `key.properties`

## 🔗 Liens utiles

- [Documentation Flutter](https://docs.flutter.dev)
- [Déploiement Android](https://docs.flutter.dev/deployment/android)
- [Google Play Console](https://play.google.com/console)
- [FlutterFire (Firebase)](https://firebase.flutter.dev)
