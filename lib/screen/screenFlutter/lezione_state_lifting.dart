import 'package:flutter/material.dart';

class LezioneStateLifting extends StatelessWidget {
  final String titoloLezione;

  const LezioneStateLifting({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    // Palette Colori State Management
    const Color liftOrange = Color.fromARGB(255, 130, 37, 9);
    const Color callbackBlue = Color(0xFF2196F3);
    const Color stateTeal = Color(0xFF009688);
    const Color warningAmber = Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: liftOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. IL CONCETTO: CHI COMANDA? ────────────────────────────────
            _cardLezione(
              titolo: 'La Memoria dell\'App',
              colore: stateTeal,
              icona: Icons.psychology_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lo Stato è un dato che cambia (es: un contatore). In Flutter, i dati scorrono come un fiume: solo dall\'alto verso il basso.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildStatusRow(
                    Icons.location_on,
                    'Stato Locale',
                    'Vive in un widget (es. un interruttore).',
                    stateTeal,
                  ),
                  _buildStatusRow(
                    Icons.share,
                    'Stato Condiviso',
                    'Serve a più widget (es. il Carrello).',
                    liftOrange,
                  ),
                ],
              ),
            ),

            // ─── 2. IL PROBLEMA DEI FRATELLI ───────────────────────────────
            _cardLezione(
              titolo: 'Il Muro tra Fratelli',
              colore: Colors.redAccent,
              icona: Icons.block_flipped,
              corpo: Column(
                children: [
                  Text(
                    'Due widget "fratelli" non possono parlarsi direttamente. Se il Widget A ha un dato, il Widget B è cieco.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 10),
                  _alertSuggerimento(
                    'Soluzione: Sposta il dato nel Padre Comune!',
                  ),
                ],
              ),
            ),

            // ─── 3. COME FUNZIONA IL SOLLEVAMENTO ───────────────────────────
            _cardLezione(
              titolo: 'Flow: Dati e Callback',
              colore: callbackBlue,
              icona: Icons.unfold_less_double_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _elementoLista(
                    'Dati (Giù)',
                    'Il Padre passa variabili ai figli tramite i costruttori.',
                    callbackBlue,
                  ),
                  _elementoLista(
                    'Callback (Su)',
                    'Il Figlio "suona il campanello" per avvisare il Padre che deve cambiare qualcosa.',
                    callbackBlue,
                  ),
                ],
              ),
            ),

            _boxCodice(
              '// 1. Nel Padre gestisci lo stato\n'
              'int _contatore = 0;\n\n'
              '// 2. Passi il dato al Figlio A\n'
              'ContatoreDisplay(valore: _contatore),\n\n'
              '// 3. Passi la funzione al Figlio B\n'
              'BottoneIncrementa(onTap: () => setState(() => _contatore++)),',
            ),

            const SizedBox(height: 40),
            // ─── TEMPLATE: STATE LIFTING COMPLETO ───────────────
            _cardLezione(
              titolo: 'Template: State Lifting Completo',
              colore: callbackBlue,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Template pronto all\'uso. Il Padre gestisce lo stato, i Figli ricevono dati o callback secondo il loro ruolo.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _elementoLista(
                    'Step 1',
                    'Dichiara la variabile di stato nel Padre con setState.',
                    callbackBlue,
                  ),
                  _elementoLista(
                    'Step 2',
                    'Passa il valore al Figlio che deve solo mostrarlo.',
                    callbackBlue,
                  ),
                  _elementoLista(
                    'Step 3',
                    'Passa la funzione al Figlio che deve modificarlo.',
                    callbackBlue,
                  ),
                  _elementoLista(
                    'Step 4',
                    'Se il dato deve attraversare più di 3 livelli, passa a Riverpod.',
                    callbackBlue,
                  ),
                ],
              ),
            ),

            _boxCodice(
              '// ── IL PADRE (StatefulWidget) ───────────────────────\n'
              'class PadreWidget extends StatefulWidget {\n'
              '  const PadreWidget({super.key});\n'
              '  @override\n'
              '  State<PadreWidget> createState() => _PadreWidgetState();\n'
              '}\n\n'
              'class _PadreWidgetState extends State<PadreWidget> {\n\n'
              '  // ── STEP 1: Stato centralizzato nel Padre ─────────\n'
              '  int _contatore = 0;           // il dato vive qui\n'
              '  String _testo = "Vuoto";      // aggiungi tutti i campi che ti servono\n\n'
              '  void _incrementa() {          // la logica vive qui, non nei figli\n'
              '    setState(() => _contatore++);\n'
              '  }\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Column(\n'
              '      children: [\n\n'
              '        // ── STEP 2: Figlio che mostra il dato ────────\n'
              '        FiglioDisplay(\n'
              '          valore: _contatore,   // riceve solo dati, non tocca lo stato\n'
              '          testo: _testo,\n'
              '        ),\n\n'
              '        // ── STEP 3: Figlio che modifica il dato ──────\n'
              '        FiglioBottone(\n'
              '          onTap: _incrementa,   // riceve la funzione, non lo stato\n'
              '        ),\n'
              '      ],\n'
              '    );\n'
              '  }\n'
              '}\n\n'
              '// ── FIGLIO A: solo visualizza ─────────────────────────\n'
              'class FiglioDisplay extends StatelessWidget {\n'
              '  final int valore;\n'
              '  final String testo;\n'
              '  const FiglioDisplay({super.key, required this.valore, required this.testo});\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Text("\$testo: \$valore");\n'
              '  }\n'
              '}\n\n'
              '// ── FIGLIO B: solo aziona ─────────────────────────────\n'
              'class FiglioBottone extends StatelessWidget {\n'
              '  final VoidCallback onTap;     // non sa cosa fa, chiama e basta\n'
              '  const FiglioBottone({super.key, required this.onTap});\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return ElevatedButton(\n'
              '      onPressed: onTap,\n'
              '      child: const Text("Incrementa"),\n'
              '    );\n'
              '  }\n'
              '}',
            ),

            _alertSuggerimento(
              '⚠️ PROP DRILLING: se ti ritrovi a passare la stessa variabile '
              'attraverso 3 o più costruttori solo per farla arrivare in fondo, '
              'è il segnale che serve Riverpod — il Padre sta diventando un postino.',
            ),
          ],
        ),
      ),
    );
  }

  // ─── METODI DI SUPPORTO GRAFICO ──────────────────────────────────────────

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
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colore.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 22),
                const SizedBox(width: 12),
                Text(
                  titolo.toUpperCase(),
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1,
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

  Widget _buildStatusRow(
    IconData icon,
    String label,
    String desc,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                  TextSpan(
                    text: desc,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _elementoLista(String termine, String descrizione, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• $termine',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colore,
              fontSize: 14,
            ),
          ),
          Text(
            descrizione,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _boxCodice(String codice) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 11,
          height: 1.4,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5);
}
