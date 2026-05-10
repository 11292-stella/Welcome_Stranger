import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuova_app/theme/horror_theme.dart'; // Assicurati che il percorso sia corretto

class CreazioneProgetto extends ConsumerWidget {
  final String titoloLezione;

  const CreazioneProgetto({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horror = Theme.of(context).extension<HorrorTheme>()!;
    final neonCyan = const Color(0xFF00E5FF);
    final neonOrange = Colors.deepOrangeAccent;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: horror.horrorTitle?.copyWith(fontSize: 20),
        ),
        backgroundColor: const Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. TERMINALE E SETUP ─────────────────────────────────────
            _cardLezione(
              titolo: '1. Terminale e Setup',
              colore: neonCyan,
              icona: Icons.terminal_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il terminale è il portale oscuro per gestire i tuoi progetti. Evita le ombre dei bug legati all\'interfaccia dell\'IDE.',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    '# Crea un nuovo progetto\n'
                    'flutter create nome_app\n\n'
                    '# Entra nella cartella\n'
                    'cd nome_app\n\n'
                    '# Avvia l\'app\n'
                    'flutter run',
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Analisi',
                    'Usa `flutter doctor` per scovare errori di installazione.',
                    neonCyan,
                  ),
                  _elementoLista(
                    'Pulizia',
                    'Usa `flutter clean` se l\'app ha comportamenti paranormali.',
                    neonCyan,
                  ),
                ],
              ),
            ),

            // ─── 2. PULIZIA E BOILERPLATE ────────────────────────────────────
            _cardLezione(
              titolo: '2. Pulizia: Il Punto Zero',
              colore: neonOrange,
              icona: Icons.cleaning_services_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'L\'app contatore di default è piena di rumore. Esegui un esorcismo del codice in `lib/main.dart` e parti da questo scheletro:',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    'void main() => runApp(const ProviderScope(child: MyApp()));\n\n'
                    'class MyApp extends StatelessWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    return MaterialApp(\n'
                    '      home: Scaffold(body: Center(child: Text("Void"))),\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 3. STRUTTURA DELLE CARTELLE ────────────────────────────────
            _cardLezione(
              titolo: '3. Anatomia del Progetto',
              colore: Colors.purpleAccent,
              icona: Icons.folder_shared_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _elementoLista(
                    'lib/',
                    'Il cuore pulsante dove vive il tuo codice Dart.',
                    Colors.purpleAccent,
                  ),
                  _elementoLista(
                    'pubspec.yaml',
                    'Il grimorio delle dipendenze e degli asset.',
                    Colors.purpleAccent,
                  ),
                  _elementoLista(
                    'assets/',
                    'Dove riporre le immagini e i file arcani.',
                    Colors.purpleAccent,
                  ),
                ],
              ),
            ),

            // ─── CONSIGLIO VELOCITÀ ──────────────────────────────────────────
            _suggerimentoCreativo(
              '⚡ TRUCCO VS CODE: Non scrivere mai i widget a mano! \n'
              'Digita "stless" o "stful" per evocare istantaneamente la struttura di un widget. Risparmierai ore di agonia.',
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  //─── COMPONENTI GRAFICI HORROR ──────────────────

  TextStyle _stileTestoAcademy() =>
      const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6);

  Widget _cardLezione({
    required String titolo,
    required Color colore,
    required IconData icona,
    required Widget corpo,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colore.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: colore.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icona,
                  color: colore,
                  size: 24,
                  shadows: [Shadow(color: colore, blurRadius: 8)],
                ),
                const SizedBox(width: 15),
                Text(
                  titolo,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: colore,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(20), child: corpo),
        ],
      ),
    );
  }

  Widget _boxCodice(String codice) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _elementoLista(String termine, String descrizione, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: colore, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: _stileTestoAcademy(),
                children: [
                  TextSpan(
                    text: '$termine: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colore.withOpacity(0.9),
                    ),
                  ),
                  TextSpan(text: descrizione),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrange.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Colors.orangeAccent),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
