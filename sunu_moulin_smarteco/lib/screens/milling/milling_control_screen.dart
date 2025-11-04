import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/screens/history/milling_history_screen.dart';

// Écran de contrôle et de surveillance de la mouture en temps réel.
class MillingControlScreen extends StatelessWidget {
  const MillingControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Palette de couleurs et styles dérivés du design "Screen 5".
    const Color primaryColor = Color(0xFF2ECC71);
    const Color backgroundColor = Color(0xFFF0F4F8);
    const Color textColor = Color(0xFF1A2530);
    const Color accentRed = Color(0xFFE74C3C);
    const Color accentBlue = Color(0xFF3498DB);
    const Color accentOrange = Color(0xFFF39C12);
    const Color cardBackgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Barre d'application personnalisée.
            _buildAppBar(context, textColor, primaryColor),

            // Bannière d'alerte/notification.
            _buildAlertBanner(primaryColor),

            // Indicateur d'état principal (cercle animé).
            _buildMainStatusIndicator(primaryColor, textColor),

            // Jauges de données en temps réel.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    _DataGauge(
                      label: 'Température',
                      valueText: '65°C',
                      percentage: 0.65,
                      color: accentOrange,
                      backgroundColor: cardBackgroundColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),
                    _DataGauge(
                      label: 'Vibration',
                      valueText: 'Normale',
                      percentage: 0.30,
                      color: primaryColor,
                      backgroundColor: cardBackgroundColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),
                    _DataGauge(
                      label: 'Progression',
                      valueText: '75%',
                      percentage: 0.75,
                      color: accentBlue,
                      backgroundColor: cardBackgroundColor,
                      textColor: textColor,
                    ),
                  ],
                ),
              ),
            ),

            // Boutons d'action en bas de page.
            _buildActionButtons(primaryColor, accentRed, accentBlue),
          ],
        ),
      ),
    );
  }

  // Construit la barre d'application.
  Widget _buildAppBar(BuildContext context, Color textColor, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.menu, color: textColor), onPressed: () {}),
          Text(
            'Moulin 01 - Connecté',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          IconButton(icon: Icon(Icons.wifi, color: primaryColor), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.history, color: textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MillingHistoryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Construit la bannière d'alerte.
  Widget _buildAlertBanner(Color primaryColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: primaryColor),
          const SizedBox(width: 12),
          Text(
            'Mouture démarrée avec succès.',
            style: GoogleFonts.inter(
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Construit l'indicateur d'état central.
  Widget _buildMainStatusIndicator(Color primaryColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        width: 224,
        height: 224,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor.withOpacity(0.1),
        ),
        child: Center(
          child: Container(
            width: 192,
            height: 192,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.2),
            ),
            child: Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.rotate_right, size: 60, color: primaryColor),
                    const SizedBox(height: 8),
                    Text(
                      'Mouture...',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Construit la section des boutons d'action.
  Widget _buildActionButtons(Color primaryColor, Color accentRed, Color accentBlue) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: null, // Désactivé comme dans le design
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor.withOpacity(0.2),
                disabledBackgroundColor: primaryColor.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Démarrer',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor.withOpacity(0.4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: accentRed,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Arrêter',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: accentBlue,
            child: const Icon(Icons.mic, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}

// Widget personnalisé pour afficher une jauge de données.
class _DataGauge extends StatelessWidget {
  final String label;
  final String valueText;
  final double percentage;
  final Color color;
  final Color backgroundColor;
  final Color textColor;

  const _DataGauge({
    required this.label,
    required this.valueText,
    required this.percentage,
    required this.color,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 16, color: textColor),
              ),
              Text(
                valueText,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
