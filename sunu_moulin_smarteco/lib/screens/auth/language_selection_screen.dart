import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/screens/auth/login_screen.dart';

// Écran de sélection de la langue au démarrage de l'application.
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Les couleurs et le thème sont inspirés du design fourni.
    final Color primaryColor = const Color(0xFF13EC37);
    final Color backgroundColor = const Color(0xFFF6F8F6);
    final Color textColor = const Color(0xFF102213);
    final Color buttonTextColor = const Color(0xFF102213);
    final Color buttonBackgroundColor = const Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: backgroundColor,
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
                    Icon(Icons.grain, size: 40, color: primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      'Sunu Moulin',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: textColor,
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
                  'Choose your language / Choisissez votre langue / Tànnal sa làkk',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ),

              // Boutons de sélection de langue
              _LanguageButton(
                label: '🇸🇳  Wolof',
                backgroundColor: buttonBackgroundColor,
                textColor: buttonTextColor,
                onPressed: () {
                  // TODO: Implémenter la logique de changement de langue
                },
              ),
              const SizedBox(height: 12),
              _LanguageButton(
                label: '🇫🇷  Français',
                backgroundColor: buttonBackgroundColor,
                textColor: buttonTextColor,
                onPressed: () {
                  // TODO: Implémenter la logique de changement de langue
                },
              ),
              const SizedBox(height: 12),
              _LanguageButton(
                label: '🇬🇧  English',
                backgroundColor: buttonBackgroundColor,
                textColor: buttonTextColor,
                onPressed: () {
                  // TODO: Implémenter la logique de changement de langue
                },
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
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
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _LanguageButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
