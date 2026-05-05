import 'package:flutter/material.dart';

class LezioneDebugTree extends StatelessWidget {
  final String titoloLezione;

  const LezioneDebugTree({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: I TRE ALBERI ────────────────────────────────────
            _cardLezione(
              titolo: '1. I Tre Alberi di Flutter',
              colore: Colors.red.shade700,
              icona: Icons.account_tree_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Flutter non ha solo l\'albero che scrivi tu. Ne gestisce tre in parallelo per essere velocissimo:\n\n',
                    ),
                    _elementoLista(
                      'Widget Tree',
                      'Il tuo progetto (es. "Voglio un testo blu"). È leggero e viene ricreato spesso.\n',
                    ),
                    _elementoLista(
                      'Element Tree',
                      'Il manager. Collega il tuo codice ai pezzi veri e propri sullo schermo.\n',
                    ),
                    _elementoLista(
                      'Render Tree',
                      'L\'operaio. Calcola le dimensioni esatte e disegna i pixel.\n\n',
                    ),
                    const TextSpan(text: '💡 '),
                    _testoBold('Perché è importante?', Colors.black),
                    const TextSpan(
                      text:
                          ' Flutter confronta il vecchio Widget Tree con quello nuovo e cambia solo i pixel necessari. È questo il segreto della sua fluidità!',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: IL WIDGET INSPECTOR ──────────────────────────────
            _cardLezione(
              titolo: '2. Usare il Widget Inspector',
              colore: Colors.blueGrey.shade800,
              icona: Icons.search_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Il '),
                    _testoBold('Widget Inspector', Colors.blueGrey.shade900),
                    const TextSpan(
                      text:
                          ' è il tuo migliore amico durante il debug. Ti permette di:\n\n',
                    ),
                    _elementoLista(
                      'Selezionare i Widget',
                      'Clicca su un elemento nel telefono e il codice salterà al punto giusto.\n',
                    ),
                    _elementoLista(
                      'Debug Paint',
                      'Mostra i bordi e i margini di ogni widget per capire perché qualcosa è fuori posto.\n',
                    ),
                    _elementoLista(
                      'Rallentare le animazioni',
                      'Per vedere se un effetto grafico è fluido come desideri.\n\n',
                    ),
                    const TextSpan(text: 'Lo trovi nel pannello '),
                    _testoBold('DevTools', Colors.black),
                    const TextSpan(
                      text: ' del tuo editor (VS Code o Android Studio).',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: OTTIMIZZAZIONE ──────────────────────────────────
            _cardLezione(
              titolo: '3. Regole per un Albero Pulito',
              colore: Colors.green.shade800,
              icona: Icons.cleaning_services_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Per non appesantire l\'albero dei widget, segui queste regole:\n\n',
                    ),
                    _elementoLista(
                      'Estrai i Widget',
                      'Se una classe supera le 100-150 righe, crea un nuovo file.\n',
                    ),
                    _elementoLista(
                      'Usa const',
                      'Ogni volta che puoi. Aiuta Flutter a saltare il ridisegno di parti che non cambiano.\n',
                    ),
                    _elementoLista(
                      'Evita il Nesting profondo',
                      'Se hai 10 widget annidati, forse puoi usare uno Stack o una ListView per semplificare.\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Un albero pulito significa un\'app che non scatta mai.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              '// ✅ Ottimo: widget piccolo e riutilizzabile\n'
              'class TitoloSezione extends StatelessWidget {\n'
              '  final String testo;\n'
              '  const TitoloSezione(this.testo, {super.key});\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Padding(\n'
              '      padding: const EdgeInsets.all(8.0),\n'
              '      child: Text(testo, style: TextStyle(fontSize: 24)),\n'
              '    );\n'
              '  }\n'
              '}',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🚀 Sfida: Apri l\'Inspector sulla tua app e prova ad attivare "Show Guidelines". '
              'Vedrai come Flutter calcola le distanze tra le card che abbiamo creato!',
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI DI SUPPORTO ──────────────────────────────────────────

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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF232931),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200.withOpacity(0.3)),
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
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.bug_report_rounded, color: Colors.red.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.red.shade900,
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

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Color(0xFF37474F), fontSize: 15, height: 1.7);

  TextSpan _testoBold(String testo, Color colore) {
    return TextSpan(
      text: testo,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: colore,
        fontSize: 16,
      ),
    );
  }

  TextSpan _elementoLista(String termine, String descrizione) {
    return TextSpan(
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
    );
  }
}
