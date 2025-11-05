import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunu_moulin_smarteco/config/theme.dart';
import 'package:sunu_moulin_smarteco/screens/auth/language_selection_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/services/storage_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  runApp(
    // ProviderScope est nécessaire pour que Riverpod fonctionne dans toute l'application.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Widget racine de l'application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    // ScreenUtilInit permet de rendre l'interface utilisateur responsive.
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Taille de design de référence (iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Sunu Moulin SmartEco',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system, // Utilise le thème du système
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          // L'écran de sélection de la langue est défini comme écran d'accueil.
          home: child,
        );
      },
      child: const LanguageSelectionScreen(),
    );
  }
}
