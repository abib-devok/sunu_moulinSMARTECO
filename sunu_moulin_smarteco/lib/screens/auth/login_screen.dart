import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/screens/home/connect_to_mill_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Écran de connexion principal offrant plusieurs méthodes d'authentification.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Barre supérieure avec le bouton de langue.
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: IconButton(
                  icon: Icon(Icons.language, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),

            // Contenu principal centré.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo de l'application.
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.grain, size: 48, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Titres de bienvenue.
                    Text(
                      l10n.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.loginPrompt,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Boutons de méthode de connexion.
                    _AuthButton(
                      label: l10n.scanQR,
                      icon: Icons.qr_code_scanner,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectToMillScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                    _AuthButton(
                      label: l10n.enterPIN,
                      icon: Icons.pin,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectToMillScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                    _AuthButton(
                      label: l10n.guestAccess,
                      icon: Icons.person,
                      isGuest: true,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectToMillScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Lien d'assistance en bas de page.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                l10n.needHelp,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      // Bouton flottant pour la commande vocale.
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final voiceService = ref.read(voiceServiceProvider);
          await voiceService.speak(l10n.loginPrompt);
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.mic, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Widget personnalisé pour les boutons d'authentification pour la cohérence.
class _AuthButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isGuest;
  final VoidCallback onPressed;

  const _AuthButton({
    required this.label,
    required this.icon,
    this.isGuest = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isGuest ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.secondary,
          foregroundColor: isGuest ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSecondary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
