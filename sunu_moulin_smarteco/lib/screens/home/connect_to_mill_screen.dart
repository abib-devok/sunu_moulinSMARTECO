import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/screens/milling/milling_setup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Modèle simple pour représenter un moulin avec son état.
class MillDevice {
  final String name;
  final String status; // 'Available', 'In Use', 'Offline'
  final String signalStrength; // 'strong', 'medium', 'weak', 'off'

  MillDevice({required this.name, required this.status, required this.signalStrength});
}

// Écran permettant de rechercher et de se connecter à un moulin à proximité.
class ConnectToMillScreen extends ConsumerWidget {
  const ConnectToMillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // Données fictives pour la liste des moulins.
    final List<MillDevice> nearbyMills = [
      MillDevice(name: 'Sunu Moulin #123', status: 'Available', signalStrength: 'strong'),
      MillDevice(name: 'Sunu Moulin #456', status: 'In Use', signalStrength: 'medium'),
      MillDevice(name: 'Sunu Moulin #789', status: 'Offline', signalStrength: 'off'),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.connectToMill),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.notImplemented)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            // Panneaux d'état pour la connectivité.
            _buildStatusPanels(context, l10n),
            const SizedBox(height: 24),
            // Titre de la section des moulins à proximité.
            Text(
              l10n.nearbyMills,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Liste des cartes de moulins.
            ...nearbyMills.map((mill) => _MillDeviceCard(mill: mill)),
            const SizedBox(height: 12),
            // Indicateur de scan.
            _buildScanningIndicator(context, l10n),
          ],
        ),
      ),
      // Boutons d'action flottants en bas.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButtons(context, l10n),
    );
  }

  // Construit les panneaux d'état pour Bluetooth et Wi-Fi.
  Widget _buildStatusPanels(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: _StatusCard(
            title: l10n.bluetooth,
            status: l10n.enabled,
            icon: Icons.bluetooth_connected,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatusCard(
            title: l10n.wifi,
            status: l10n.enabled,
            icon: Icons.wifi,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  // Construit l'indicateur visuel de scan.
  Widget _buildScanningIndicator(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            l10n.scanning,
            style: GoogleFonts.inter(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  // Construit les boutons d'action flottants.
  Widget _buildFloatingActionButtons(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.notImplemented)),
                );
              },
              icon: const Icon(Icons.refresh),
              label: Text(l10n.scanForMills),
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

// Widget pour une carte d'état (Bluetooth/Wi-Fi).
class _StatusCard extends StatelessWidget {
  final String title;
  final String status;
  final IconData icon;
  final Color iconColor;

  const _StatusCard({
    required this.title,
    required this.status,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                status,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget pour une carte affichant un moulin détecté.
class _MillDeviceCard extends StatelessWidget {
  final MillDevice mill;

  const _MillDeviceCard({required this.mill});

  // Détermine la couleur et l'icône en fonction du statut.
  Map<String, dynamic> _getStatusStyle(BuildContext context) {
    switch (mill.status) {
      case 'Available':
        return {'color': Colors.green, 'icon': Icons.check_circle, 'text': AppLocalizations.of(context)!.available};
      case 'In Use':
        return {'color': Colors.orange, 'icon': Icons.hourglass_top, 'text': AppLocalizations.of(context)!.inUse};
      case 'Offline':
        return {'color': Colors.grey, 'icon': Icons.cancel, 'text': AppLocalizations.of(context)!.offline};
      default:
        return {'color': Colors.grey, 'icon': Icons.help, 'text': AppLocalizations.of(context)!.offline};
    }
  }

  // Détermine l'icône de la force du signal.
  IconData _getSignalIcon() {
    switch (mill.signalStrength) {
      case 'strong':
        return Icons.signal_wifi_4_bar;
      case 'medium':
        return Icons.wifi_2_bar;
      default:
        return Icons.signal_wifi_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(context);
    final bool isEnabled = mill.status == 'Available';

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.grain, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mill.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: statusStyle['color'],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusStyle['text'],
                          style: GoogleFonts.inter(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                        ),
                        const Spacer(),
                        Icon(_getSignalIcon(), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: isEnabled ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MillingSetupScreen()));
                } : null,
                child: Text(AppLocalizations.of(context)!.connect),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
