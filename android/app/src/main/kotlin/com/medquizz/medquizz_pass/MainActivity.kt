package com.hippoquiz.hippoquiz_app

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Activer l'affichage edge-to-edge pour Android 15+ (SDK 35)
        // Compatible avec les versions antérieures grâce à androidx.core
        WindowCompat.setDecorFitsSystemWindows(window, false)

        // Configuration des barres système pour edge-to-edge
        // Utilise les API modernes WindowInsetsController au lieu des API obsolètes
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)

        // Définir les icônes de la barre de statut en mode sombre (pour fond clair)
        windowInsetsController.isAppearanceLightStatusBars = true

        // Définir les icônes de la barre de navigation en mode sombre (pour fond clair)
        windowInsetsController.isAppearanceLightNavigationBars = true
    }
}
