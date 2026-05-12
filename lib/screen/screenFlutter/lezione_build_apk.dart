import 'package:flutter/material.dart';

class LezioneBuildAPK extends StatelessWidget {
  const LezioneBuildAPK({super.key});

  static const Color neonPurple = Color(0xFFD500F9);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonGreen = Color(0xFFC6FF00);
  static const Color neonOrange = Color(0xFFFF6D00);
  static const Color darkBg = Color(0xFF0A0E12);
  static const Color cardBg = Color(0xFF1E262C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: const Text(
          'RITO DELL\'EVOCAZIONE APK',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF311B92),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCard(
              titolo: '1. PURIFICAZIONE',
              colore: neonPurple,
              icona: Icons.auto_delete,
              desc: 'Pulisce la cache e i residui di vecchie compilazioni.',
              comando: 'flutter clean\nflutter pub get',
            ),
            _buildCard(
              titolo: '2. COMPILAZIONE OTTIMIZZATA',
              colore: neonCyan,
              icona: Icons.bolt,
              desc: 'Crea APK separati per ogni architettura (più leggeri).',
              comando: 'flutter build apk --split-per-abi',
            ),
            _buildCard(
              titolo: '3. IL SENTIERO OSCURO',
              colore: neonOrange,
              icona: Icons.folder_open,
              desc: 'Dove trovare il tuo tesoro una volta finito.',
              comando: 'build\\app\\outputs\\flutter-apk\\',
            ),
            _buildCard(
              titolo: '4. IL PRESCELTO (ARM64)',
              colore: neonGreen,
              icona: Icons.phone_android,
              desc:
                  'Il file app-arm64-v8a-release.apk è quello perfetto per il tuo smartphone moderno.',
              comando: '// Invia al cel e installa! ',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String titolo,
    required Color colore,
    required IconData icona,
    required String desc,
    required String comando,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colore.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore),
                const SizedBox(width: 10),
                Text(
                  titolo,
                  style: TextStyle(color: colore, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    comando,
                    style: const TextStyle(
                      color: Color(0xFF76FF03),
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
