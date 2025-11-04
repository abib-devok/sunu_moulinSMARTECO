import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunu_moulin_smarteco/screens/auth/language_selection_screen.dart';

void main() {
  runApp(
    // ProviderScope est nécessaire pour que Riverpod fonctionne dans toute l'application.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Widget racine de l'application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit permet de rendre l'interface utilisateur responsive.
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Taille de design de référence (iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Sunu Moulin SmartEco',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // L'écran de sélection de la langue est défini comme écran d'accueil.
          home: child,
        );
      },
      child: const LanguageSelectionScreen(),
    );
  }
}
