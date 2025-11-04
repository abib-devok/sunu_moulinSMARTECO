import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Modèle de données simple pour une session de mouture.
class MillingSession {
  final String id;
  final String details;
  final String date;
  final String status; // 'Completed', 'Anomaly', 'Failed'

  MillingSession({
    required this.id,
    required this.details,
    required this.date,
    required this.status,
  });
}

// Écran affichant l'historique des sessions de mouture.
class MillingHistoryScreen extends StatelessWidget {
  const MillingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données fictives pour l'historique.
    final List<MillingSession> sessions = [
      MillingSession(
        id: 'SM-20230915-001',
        details: 'Poids total: 50 kg | Durée: 45 min',
        date: '15 Sep 2023, 10:30',
        status: 'Completed',
      ),
      MillingSession(
        id: 'SM-20230914-003',
        details: 'Poids total: 75 kg | Durée: 62 min',
        date: '14 Sep 2023, 14:15',
        status: 'Anomaly',
      ),
      MillingSession(
        id: 'SM-20230914-002',
        details: 'Statut: Échec | Durée: 5 min',
        date: '14 Sep 2023, 11:00',
        status: 'Failed',
      ),
      MillingSession(
        id: 'SM-20230913-005',
        details: 'Poids total: 120 kg | Durée: 88 min',
        date: '13 Sep 2023, 09:05',
        status: 'Completed',
      ),
    ];

    // Couleurs du design.
    const Color backgroundColor = Color(0xFFF6F8F6);
    const Color cardBackgroundColor = Colors.white;
    const Color textColor = Color(0xFF1A2C1D);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Historique des Moutures',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: textColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Barre de recherche.
            _buildSearchBar(),
            const SizedBox(height: 16),
            // Liste des sessions.
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  return _SessionCard(session: sessions[index]);
                },
              ),
            ),
          ],
        ),
      ),
      // Bouton d'action flottant pour l'export.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fonctionnalité pas encore implémentée.')),
          );
        },
        backgroundColor: const Color(0xFF13EC37),
        icon: const Icon(Icons.download, color: Colors.black),
        label: Text(
          'Exporter l\'Historique',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Construit la barre de recherche.
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher par date ou ID...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.tune),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// Widget pour afficher une seule carte de session.
class _SessionCard extends StatelessWidget {
  final MillingSession session;

  const _SessionCard({required this.session});

  // Détermine le style (icône et couleur) en fonction du statut.
  Map<String, dynamic> _getStatusStyle() {
    switch (session.status) {
      case 'Completed':
        return {'icon': Icons.check_circle, 'color': Colors.green};
      case 'Anomaly':
        return {'icon': Icons.warning, 'color': Colors.amber};
      case 'Failed':
        return {'icon': Icons.cancel, 'color': Colors.red};
      default:
        return {'icon': Icons.help, 'color': Colors.grey};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: statusStyle['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(statusStyle['icon'], color: statusStyle['color']),
        ),
        title: Text(
          'Session ID: ${session.id}',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(session.details),
            Text(session.date, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Naviguer vers les détails de la session.
        },
      ),
    );
  }
}
