import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LezioneStatelessStateful extends StatelessWidget {
  final String titoloLezione;

  const LezioneStatelessStateful({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color neonOrange = Color(0xFFFF6D00);
    const Color radioactiveGreen = Color(0xFFB2FF59);
    const Color darkSurface = Color(0xFF121212);
    const Color mutedText = Color(0xFFB0B0B0);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        backgroundColor: darkSurface,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: neonOrange),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: neonOrange.withOpacity(0.3), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: STATELESSWIDGET ───────────────────────────────
            _cardLezione(
              titolo: '1. StatelessWidget: Il Monolito',
              colore: Colors.blueGrey.shade400,
              icona: Icons.layers_clear_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(mutedText),
                  children: [
                    const TextSpan(text: 'Uno '),
                    _testoBold('StatelessWidget', Colors.white),
                    const TextSpan(
                      text:
                          ' è come una fotografia stampata. Una volta generato, non può cambiare le sue proprietà interne.\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Se i dati esterni cambiano, Flutter distrugge l\'istanza e ne crea una nuova. È leggero, veloce e privo di "memoria".\n\n',
                    ),
                    _testoBold('Protocolli d\'uso:', Colors.blueGrey.shade200),
                    const TextSpan(
                      text:
                          ' Ideale per icone, testi statici, loghi o decorazioni che non richiedono interazione dinamica.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: STATEFULWIDGET ────────────────────────────────
            _cardLezione(
              titolo: '2. StatefulWidget: L\'Entità Viva',
              colore: neonOrange,
              icona: Icons.loop_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(mutedText),
                  children: [
                    const TextSpan(text: 'Uno '),
                    _testoBold('StatefulWidget', neonOrange),
                    const TextSpan(
                      text: ' possiede un nucleo mutabile chiamato ',
                    ),
                    _testoBold('State', Colors.white),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(
                      text:
                          'Questa entità è in grado di evolversi: può ricordare input dell\'utente, animazioni in corso o dati scaricati dalla rete.\n\n',
                    ),
                    _testoBold('Architettura:', Colors.white),
                    const TextSpan(
                      text:
                          ' È diviso in due classi: il Widget (la struttura esterna) e lo Stato (la logica e i dati che persistono).',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: SETSTATE ──────────────────────────────────────
            _cardLezione(
              titolo: '3. setState(): L\'Impulso di Re-Build',
              colore: radioactiveGreen,
              icona: Icons.electric_bolt_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(mutedText),
                  children: [
                    const TextSpan(text: 'Il comando '),
                    _testoCodiceInline('setState(() {...})'),
                    const TextSpan(
                      text:
                          ' invia un segnale al framework: "Lo stato interno è mutato, aggiorna la proiezione video".\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Senza questo impulso, le variabili cambierebbero nella memoria ma l\'interfaccia resterebbe congelata.\n\n',
                    ),
                    _testoBold('⚠️ Warning:', Colors.redAccent),
                    const TextSpan(
                      text:
                          ' Non invocare mai setState direttamente nel metodo build. Genereresti un sovraccarico ricorsivo fatale per l\'app.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'class Contatore extends StatefulWidget {\n'
              '  @override\n'
              '  _ContatoreState createState() => _ContatoreState();\n'
              '}\n\n'
              'class _ContatoreState extends State<Contatore> {\n'
              '  int _count = 0; // Memoria persistente\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Column(\n'
              '      children: [\n'
              '        Text("Scan: \$_count"),\n'
              '        ElevatedButton(\n'
              '          onPressed: () {\n'
              '            setState(() { _count++; }); // Trigger Re-build\n'
              '          },\n'
              '          child: Text("INCREMENT"),\n'
              '        ),\n'
              '      ],\n'
              '    );\n'
              '  }\n'
              '}',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '💡 ANALISI TATTICA: Prediligi sempre lo StatelessWidget per massimizzare le performance. '
              'Eclissa la logica nello StatefulWidget solo quando la mutazione dei dati è strettamente locale al widget.',
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
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colore.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: colore.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 24),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    titolo.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colore,
                      letterSpacing: 0.5,
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
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1200),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.terminal_rounded,
            color: Colors.orangeAccent,
            size: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 13,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _stileTestoBase(Color colore) =>
      TextStyle(color: colore, fontSize: 14, height: 1.6);

  TextSpan _testoBold(String testo, Color colore) {
    return TextSpan(
      text: testo,
      style: TextStyle(fontWeight: FontWeight.bold, color: colore),
    );
  }

  TextSpan _testoCodiceInline(String testo) {
    return TextSpan(
      text: ' $testo ',
      style: const TextStyle(
        fontFamily: 'monospace',
        color: Color(0xFFB2FF59),
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.white10,
      ),
    );
  }
}
