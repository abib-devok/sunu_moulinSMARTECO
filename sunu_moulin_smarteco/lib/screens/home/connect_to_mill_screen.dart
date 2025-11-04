import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/screens/milling/milling_setup_screen.dart';

// Modèle simple pour représenter un moulin avec son état.
class MillDevice {
  final String name;
  final String status; // 'Available', 'In Use', 'Offline'
  final String signalStrength; // 'strong', 'medium', 'weak', 'off'

  MillDevice({required this.name, required this.status, required this.signalStrength});
}

// Écran permettant de rechercher et de se connecter à un moulin à proximité.
class ConnectToMillScreen extends StatelessWidget {
  const ConnectToMillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données fictives pour la liste des moulins.
    final List<MillDevice> nearbyMills = [
      MillDevice(name: 'Sunu Moulin #123', status: 'Available', signalStrength: 'strong'),
      MillDevice(name: 'Sunu Moulin #456', status: 'In Use', signalStrength: 'medium'),
      MillDevice(name: 'Sunu Moulin #789', status: 'Offline', signalStrength: 'off'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6), // background-light
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF102213)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Connecter à un Moulin',
          style: GoogleFonts.inter(
            color: const Color(0xFF102213),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFF102213)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonctionnalité pas encore implémentée.')),
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
            _buildStatusPanels(),
            const SizedBox(height: 24),
            // Titre de la section des moulins à proximité.
            Text(
              'Moulins à Proximité',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF102213),
              ),
            ),
            const SizedBox(height: 16),
            // Liste des cartes de moulins.
            ...nearbyMills.map((mill) => _MillDeviceCard(mill: mill)),
            const SizedBox(height: 12),
            // Indicateur de scan.
            _buildScanningIndicator(),
          ],
        ),
      ),
      // Boutons d'action flottants en bas.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  // Construit les panneaux d'état pour Bluetooth et Wi-Fi.
  Widget _buildStatusPanels() {
    return Row(
      children: [
        Expanded(
          child: _StatusCard(
            title: 'Bluetooth',
            status: 'Activé',
            icon: Icons.bluetooth_connected,
            iconColor: const Color(0xFF13EC37), // primary
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatusCard(
            title: 'Wi-Fi',
            status: 'Activé',
            icon: Icons.wifi,
            iconColor: const Color(0xFF13EC37), // primary
          ),
        ),
      ],
    );
  }

  // Construit l'indicateur visuel de scan.
  Widget _buildScanningIndicator() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircularProgressIndicator(color: const Color(0xFF13EC37)),
          const SizedBox(height: 16),
          Text(
            'Recherche d\'autres moulins...',
            style: GoogleFonts.inter(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // Construit les boutons d'action flottants.
  Widget _buildFloatingActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fonctionnalité pas encore implémentée.')),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Scanner'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF333333), // sunu-charcoal
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonctionnalité pas encore implémentée.')),
              );
            },
            backgroundColor: const Color(0xFF13EC37), // primary
            child: const Icon(Icons.mic, color: Colors.black),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: Colors.grey.shade600)),
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
                  color: const Color(0xFF102213),
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
  Map<String, dynamic> _getStatusStyle() {
    switch (mill.status) {
      case 'Available':
        return {'color': Colors.green, 'icon': Icons.check_circle};
      case 'In Use':
        return {'color': Colors.orange, 'icon': Icons.hourglass_top};
      case 'Offline':
        return {'color': Colors.grey, 'icon': Icons.cancel};
      default:
        return {'color': Colors.grey, 'icon': Icons.help};
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
    final statusStyle = _getStatusStyle();
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
                  color: const Color(0xFF13EC37).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.grain, color: Color(0xFF13EC37)),
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
                        color: const Color(0xFF102213),
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
                          mill.status,
                          style: GoogleFonts.inter(color: Colors.grey.shade600),
                        ),
                        const Spacer(),
                        Icon(_getSignalIcon(), color: Colors.grey.shade500),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEnabled ? const Color(0xFF13EC37) : Colors.grey.shade300,
                  foregroundColor: isEnabled ? Colors.black : Colors.grey.shade500,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
