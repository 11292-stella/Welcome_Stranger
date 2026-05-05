import 'package:flutter/material.dart';

class CreazioneProgetto extends StatelessWidget {
  final String titoloLezione;

  const CreazioneProgetto({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. COMANDI DA TERMINALE ─────────────────────────────────────
            _cardLezione(
              titolo: '1. Terminale e Setup',
              colore: Colors.blueGrey.shade700,
              icona: Icons.terminal_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il terminale è il modo più veloce e sicuro per gestire i tuoi progetti Flutter. Evita bug legati all\'interfaccia dell\'IDE.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '# Crea un nuovo progetto\n'
                    'flutter create nome_app\n\n'
                    '# Entra nella cartella\n'
                    'cd nome_app\n\n'
                    '# Avvia l\'app (assicurati di avere un simulatore aperto)\n'
                    'flutter run',
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Analisi',
                    'Usa `flutter doctor` per verificare che tutto sia installato correttamente.',
                  ),
                  _elementoLista(
                    'Pulizia',
                    'Usa `flutter clean` se l\'app ha comportamenti strani dopo un aggiornamento.',
                  ),
                ],
              ),
            ),

            // ─── 2. PULIZIA E BOILERPLATE ────────────────────────────────────
            _cardLezione(
              titolo: '2. Pulizia: Il Punto Zero',
              colore: Colors.indigo.shade700,
              icona: Icons.cleaning_services_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appena creato, Flutter ti dà un\'app "contatore" piena di commenti. La prima cosa da fare è cancellare tutto in `lib/main.dart` e incollare lo scheletro minimo:',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'import \'package:flutter/material.dart\';\n\n'
                    'void main() => runApp(const MyApp());\n\n'
                    'class MyApp extends StatelessWidget {\n'
                    '  const MyApp({super.key});\n\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    return const MaterialApp(\n'
                    '      debugShowCheckedModeBanner: false,\n'
                    '      home: Scaffold(\n'
                    '        body: Center(child: Text(\'Pronti a partire!\')),\n'
                    '      ),\n'
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
              colore: Colors.blue.shade800,
              icona: Icons.folder_shared_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _elementoLista(
                    'lib/',
                    'Qui vive tutto il tuo codice Dart (99% del lavoro).',
                  ),
                  _elementoLista(
                    'pubspec.yaml',
                    'Il file di configurazione per immagini, font e pacchetti esterni.',
                  ),
                  _elementoLista(
                    'assets/',
                    'Cartella da creare per salvare immagini e file JSON.',
                  ),
                  _elementoLista(
                    'android/ios/',
                    'Codice nativo: lo toccherai raramente per configurare permessi o icone app.',
                  ),
                ],
              ),
            ),

            // ─── CONSIGLIO VELOCITÀ ──────────────────────────────────────────
            _suggerimentoCreativo(
              '⚡ TRUCCO VS CODE: Non scrivere mai i widget a mano! \n'
              'Digita "stless" per generare un widget senza stato, o "stful" per uno con stato. Premi INVIO e scrivi il nome. Risparmierai ore di lavoro.',
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  //─── COMPONENTI GRAFICI DI SUPPORTO  ──────────────────

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colore.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    titolo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: colore,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(22), child: corpo),
        ],
      ),
    );
  }

  Widget _boxCodice(String codice) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF232931),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepOrange.shade200.withOpacity(0.3)),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.deepOrange.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.deepOrange.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.deepOrange.shade900,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Color(0xFF37474F), fontSize: 15, height: 1.7);

  // Questo mancava ed è fondamentale per i titoli in grassetto colorati
  Widget _testoBold(String testo, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        testo,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colore,
          fontSize: 16,
        ),
      ),
    );
  }

  // Questo mancava: serve per creare i punti elenco con termine e descrizione
  Widget _elementoLista(String termine, String descrizione) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: _stileTestoBase(),
          children: [
            TextSpan(
              text: '• $termine: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextSpan(text: descrizione),
          ],
        ),
      ),
    );
  }

  // Questo serve per evidenziare il codice inline tipo `setState`
  TextSpan _testoCodiceInline(String testo) {
    return TextSpan(
      text: ' `$testo` ',
      style: TextStyle(
        fontFamily: 'monospace',
        color: Colors.pink.shade700,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }
}
