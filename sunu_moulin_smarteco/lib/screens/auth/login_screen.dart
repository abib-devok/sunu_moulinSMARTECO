import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/screens/home/connect_to_mill_screen.dart';

// Écran de connexion principal offrant plusieurs méthodes d'authentification.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Palette de couleurs et styles dérivés du design fourni (Screen 4).
    final Color primaryColor = const Color(0xFFE8772E); // Orange du design
    final Color backgroundColor = const Color(0xFFF9F6F1);
    final Color textColor = const Color(0xFF1A2530);
    final Color guestButtonColor = const Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Barre supérieure avec le bouton de langue.
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: IconButton(
                  icon: Icon(Icons.language, color: textColor.withOpacity(0.7)),
                  onPressed: () {
                    // TODO: Revenir à l'écran de sélection de la langue ou afficher un menu.
                  },
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
                        color: primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.grain, size: 48, color: primaryColor),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Titres de bienvenue.
                    Text(
                      'Bienvenue à Sunu Moulin',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choisissez comment vous connecter',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Boutons de méthode de connexion.
                    _AuthButton(
                      label: 'Scanner QR',
                      icon: Icons.qr_code_scanner,
                      backgroundColor: primaryColor,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectToMillScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                    _AuthButton(
                      label: 'Entrer PIN',
                      icon: Icons.pin,
                      backgroundColor: primaryColor,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectToMillScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                    _AuthButton(
                      label: 'Accès Invité',
                      icon: Icons.person,
                      backgroundColor: guestButtonColor,
                      textColor: textColor,
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
                'Besoin d\'assistance ?',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: textColor.withOpacity(0.6),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      // Bouton flottant pour la commande vocale.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Activer l'écoute pour la commande vocale.
        },
        backgroundColor: primaryColor,
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
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _AuthButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: textColor),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
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
