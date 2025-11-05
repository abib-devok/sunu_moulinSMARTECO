import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/screens/auth/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Écran de sélection de la langue au démarrage de l'application.
class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Section du logo et titre
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.grain, size: 40, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      l10n.appTitle,
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),

              // Image principale
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDVQf9Jnqmb9RqudOcE_cQJ99l-GD1jHcRmnGHh9JpKeq8-vV0xee7XL-LgT3RIgMiKzUg2jffTsxRfQbpZqmwHbSs2GV5dxm4ctVgixEjKvvj0BGnZXC8CJisz38UG3Ydcg_nbakkPQwV0dKqSmhsDhQryjFrc2bILjfmq7-BtSY7J4yWyIav1TAeE7CbEOjrmPPZWr7esmAoe3M_FIWPBKM2IxGuB7-P9iyMYtKX9azgo0FS-BLxo5y3y4W1MqTgrsEimRejr53o'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Texte d'instruction
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  l10n.languageSelectionTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ),

              // Boutons de sélection de langue
              _LanguageButton(
                label: '🇸🇳  ${l10n.wolof}',
                onPressed: () => ref.read(localeProvider.notifier).setLocale('wo'),
              ),
              const SizedBox(height: 12),
              _LanguageButton(
                label: '🇫🇷  ${l10n.french}',
                onPressed: () => ref.read(localeProvider.notifier).setLocale('fr'),
              ),
              const SizedBox(height: 12),
              _LanguageButton(
                label: '🇬🇧  ${l10n.english}',
                onPressed: () => ref.read(localeProvider.notifier).setLocale('en'),
              ),
              const SizedBox(height: 24),

              // Bouton Continuer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    l10n.continueButton,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget personnalisé pour les boutons de langue pour éviter la répétition de code.
class _LanguageButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _LanguageButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
