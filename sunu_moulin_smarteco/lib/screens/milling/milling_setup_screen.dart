import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/screens/milling/milling_control_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Providers pour gérer l'état de la configuration de la mouture.
final selectedCerealProvider = StateProvider<String>((ref) => 'Mil');
final selectedFinenessProvider = StateProvider<String>((ref) => 'Medium');
final quantityProvider = StateProvider<int>((ref) => 5);

// Modèle de données pour un type de céréale.
class Cereal {
  final String name;
  final String imageUrl;

  Cereal({required this.name, required this.imageUrl});
}

// Écran de configuration de la mouture, étape par étape.
class MillingSetupScreen extends ConsumerWidget {
  const MillingSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // Données fictives pour les types de céréales.
    final List<Cereal> cereals = [
      Cereal(name: l10n.cerealMil, imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDAPs9oPbj15HMXk-R_0WTdcBRUP_CSSj3D7s6eHRVJop3hoZTbpId6A5m7JMLBobKAoX-S7WIA2PITxA-POfC5PS8bWheqfFlqjqtAnhIrobA_oZhiSWBcYrhHo-SnMAszfzmMXIuYtNjWVQhowyjSwIPp_w-XV6udvgxlHgxLV_-35f_wI5tfNUcS47DU6ON5dVoBy10NgCQ99LI4QICJDXS20Yzi-OKrZnSe2amEHkqgR2S3R4smMqEmC4H_iOO_gXF9nMivmYU'),
      Cereal(name: l10n.cerealMaize, imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBt0oiOWj2XBW7dxDr4j5Le_BZDjrEiuBJmIhjuiXsige3yYkIBiSyBG8JFXP6ARSTw9hz1j3YCrefyBdzzN1ryDhO5wBs-LZZ_6GmVUfzAxqOwoF-WWgFoV_f5_qevnKXcPLnNm8qOub1oYGtgzNP_aVj2WJF12CfyfSmDPn0bNJ_CHr1BKf0fMuP4Dx8LQ0B_pmhmotvH4p5nYO4g085bm4lO7EomFENSYR2FQ4Gu1tk7L_X8AuaIsyU7yQjZaLCQ8D7LEMqDM4w'),
      Cereal(name: l10n.cerealWheat, imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCAjgXshp1mJ9e45PuvmXgn8nA85wvsClVm56LSSvoTBo03SydJ3nFN9f52QGjcf7hBSMebE3gBtYsaQsE0lw76HUyOCJWmwMNLpHO99UnfFMGJ2PMJ6214c1HbnQL6IIiRgbZ_8xkXChzH-jZjiXnx4eEEe8iSdp-dOI9ylBnpD6Jveu1Kuqharoxqqtg9hA3lOV2i4TFmSagwkX_-YZih0UfPu4FlLchcZcClBg_JnnxQiGPeR9oyot9TZgL0osrURSDnVLhFL7M'),
      Cereal(name: l10n.cerealSorghum, imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD4TcyMsZTtwDZZGrmZ-u0cBiDPBtEL5TsS0f-cUM6o-SOzkQdGKh66yHS9Nws6QEr1M8Sr_RpXTHS3Pxwp4assFRB6yZaYMCLugHG7ILDCaUbPk_YWeSuxSHJVtHfbB9jL8u7VsmPQ8hq6D5I8I_7bJcrC07vlSsIZ7z4IyJLG3ECEb1okoJkXdTyeQsQl0N2ZEo5AORWKAPSJXmDVyLD-MOY5d7y7ulxpuWql0WtyMr9AHfOGVxQWs3bnFLlVeDxPYPqpfWZoomc'),
    ];

    // Couleurs spécifiques au design.
    const Color sunuOrange = Color(0xFFD97706);
    const Color sunuCharcoal = Color(0xFF333333);
    const Color sunuBeige = Color(0xFFF5F5F4);
    const Color sunuYellow = Color(0xFFFBBF24);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(l10n.appTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              l10n.configureMilling,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Indicateur de progression.
          _buildStepIndicator(context, l10n),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                // Section 1: Choix de la céréale.
                _buildSectionHeader(l10n.chooseCereal),
                _buildCerealCarousel(cereals, ref),

                // Section 2: Choix de la finesse.
                _buildSectionHeader(l10n.selectFineness),
                _buildFinenessSelector(ref, sunuOrange, l10n),

                // Section 3: Définition de la quantité.
                _buildSectionHeader(l10n.setQuantity),
                _buildQuantitySelector(ref, sunuCharcoal),
              ],
            ),
          ),
          // Actions en bas de page.
          _buildBottomActions(context, sunuOrange, sunuYellow, sunuCharcoal, l10n),
        ],
      ),
    );
  }

  // Construit l'en-tête pour une section.
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Construit l'indicateur de progression.
  Widget _buildStepIndicator(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.step1Of3, style: GoogleFonts.inter(color: Colors.grey[700])),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(flex: 1, child: Container(height: 6, color: const Color(0xFFD97706))),
              const SizedBox(width: 4),
              Expanded(flex: 1, child: Container(height: 6, color: Colors.grey[300])),
              const SizedBox(width: 4),
              Expanded(flex: 1, child: Container(height: 6, color: Colors.grey[300])),
            ],
          ),
        ],
      ),
    );
  }

  // Construit le carrousel de sélection de céréales.
  Widget _buildCerealCarousel(List<Cereal> cereals, WidgetRef ref) {
    final selectedCereal = ref.watch(selectedCerealProvider);
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cereals.length,
        itemBuilder: (context, index) {
          final cereal = cereals[index];
          final isSelected = cereal.name == selectedCereal;
          return GestureDetector(
            onTap: () => ref.read(selectedCerealProvider.notifier).state = cereal.name,
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFFD97706) : Colors.transparent,
                  width: 3,
                ),
                color: isSelected ? const Color(0xFFD97706).withOpacity(0.1) : Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9),
                      ),
                      child: Image.network(cereal.imageUrl, fit: BoxFit.cover, width: double.infinity),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cereal.name,
                      style: GoogleFonts.inter(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Construit le sélecteur de finesse.
  Widget _buildFinenessSelector(WidgetRef ref, Color activeColor, AppLocalizations l10n) {
    final selectedFineness = ref.watch(selectedFinenessProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _FinenessButton(
            label: l10n.fine,
            icon: Icons.grain,
            isSelected: selectedFineness == 'Fine',
            onTap: () => ref.read(selectedFinenessProvider.notifier).state = 'Fine',
            activeColor: activeColor,
          ),
          const SizedBox(width: 12),
          _FinenessButton(
            label: l10n.medium,
            icon: Icons.view_cozy,
            isSelected: selectedFineness == 'Medium',
            onTap: () => ref.read(selectedFinenessProvider.notifier).state = 'Medium',
            activeColor: activeColor,
          ),
          const SizedBox(width: 12),
          _FinenessButton(
            label: l10n.coarse,
            icon: Icons.apps,
            isSelected: selectedFineness == 'Coarse',
            onTap: () => ref.read(selectedFinenessProvider.notifier).state = 'Coarse',
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }

  // Construit le sélecteur de quantité.
  Widget _buildQuantitySelector(WidgetRef ref, Color charcoal) {
    final quantity = ref.watch(quantityProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _QuantityButton(
            icon: Icons.remove,
            onPressed: () {
              if (ref.read(quantityProvider.notifier).state > 1) {
                ref.read(quantityProvider.notifier).state--;
              }
            },
          ),
          Text(
            '$quantity',
            style: GoogleFonts.inter(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: charcoal,
            ),
          ),
          _QuantityButton(
            icon: Icons.add,
            onPressed: () => ref.read(quantityProvider.notifier).state++,
          ),
        ],
      ),
    );
  }

  // Construit les actions en bas de la page.
  Widget _buildBottomActions(BuildContext context, Color orange, Color yellow, Color charcoal, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.voiceHint,
                style: GoogleFonts.inter(color: Colors.grey[600]),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.notImplemented)),
                  );
                },
                backgroundColor: yellow,
                child: Icon(Icons.mic, color: charcoal),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MillingControlScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                l10n.confirmMilling,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget pour un bouton de sélection de finesse.
class _FinenessButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  const _FinenessButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF333333),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : const Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget pour un bouton d'ajustement de la quantité.
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.grey.shade200,
        foregroundColor: const Color(0xFF333333),
        elevation: 0,
      ),
      child: Icon(icon, size: 32),
    );
  }
}
