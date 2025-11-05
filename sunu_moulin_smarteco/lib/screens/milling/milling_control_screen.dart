import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/screens/history/milling_history_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Écran de contrôle et de surveillance de la mouture en temps réel.
class MillingControlScreen extends ConsumerStatefulWidget {
  const MillingControlScreen({super.key});

  @override
  ConsumerState<MillingControlScreen> createState() => _MillingControlScreenState();
}

class _MillingControlScreenState extends ConsumerState<MillingControlScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(bleServiceProvider).startSensorSimulation();
  }

  @override
  void dispose() {
    ref.read(bleServiceProvider).stopSensorSimulation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Barre d'application personnalisée.
            _buildAppBar(context, l10n),

            // Bannière d'alerte/notification.
            _buildAlertBanner(context, l10n),

            // Indicateur d'état principal (cercle animé).
            _buildMainStatusIndicator(context, l10n),

            // Jauges de données en temps réel.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StreamBuilder<Map<String, double>>(
                  stream: ref.watch(bleServiceProvider).sensorDataStream,
                  initialData: const {'temperature': 0, 'vibration': 0, 'progress': 0},
                  builder: (context, snapshot) {
                    final data = snapshot.data!;
                    return ListView(
                      children: [
                        _DataGauge(
                          label: l10n.temperature,
                          valueText: '${data['temperature']!.toStringAsFixed(1)}°C',
                          percentage: data['temperature']! / 100,
                          color: const Color(0xFFF39C12),
                        ),
                        const SizedBox(height: 16),
                        _DataGauge(
                          label: l10n.vibration,
                          valueText: data['vibration']! < 0.6 ? l10n.normal : 'Élevée',
                          percentage: data['vibration']!,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        _DataGauge(
                          label: l10n.progress,
                          valueText: '${(data['progress']! * 100).toStringAsFixed(0)}%',
                          percentage: data['progress']!,
                          color: const Color(0xFF3498DB),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Boutons d'action en bas de page.
            _buildActionButtons(context, l10n),
          ],
        ),
      ),
    );
  }

  // Construit la barre d'application.
  Widget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.notImplemented)),
              );
            },
          ),
          Text(
            l10n.millControlTitle,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(icon: Icon(Icons.wifi, color: Theme.of(context).colorScheme.primary), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.history),
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
  Widget _buildAlertBanner(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            l10n.millStarted,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Construit l'indicateur d'état central.
  Widget _buildMainStatusIndicator(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        width: 224,
        height: 224,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        child: Center(
          child: Container(
            width: 192,
            height: 192,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
            child: Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
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
                    Icon(Icons.rotate_right, size: 60, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 8),
                    Text(
                      l10n.milling,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
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
  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: null, // Désactivé comme dans le design
              child: Text(
                l10n.startMilling,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.notImplemented)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(
                l10n.stop,
              ),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.notImplemented)),
              );
            },
            child: const Icon(Icons.mic),
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

  const _DataGauge({
    required this.label,
    required this.valueText,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 16),
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
