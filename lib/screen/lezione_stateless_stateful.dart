import 'package:flutter/material.dart';

class LezioneStatelessStateful extends StatelessWidget {
  final String titoloLezione;

  const LezioneStatelessStateful({super.key, required this.titoloLezione});

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
        backgroundColor: Colors.orange.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: STATELESSWIDGET ───────────────────────────────
            _cardLezione(
              titolo: '1. StatelessWidget: Il Cartello',
              colore: Colors.blueGrey.shade800,
              icona: Icons.location_on_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Uno '),
                    _testoBold('StatelessWidget', Colors.blueGrey.shade900),
                    const TextSpan(
                      text:
                          ' è come un cartello stradale. Una volta stampato e piantato, non cambia più.\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Riceve i dati dal costruttore, li "disegna" sullo schermo e basta. Se i dati cambiano all\'esterno, Flutter deve distruggere il vecchio widget e crearne uno nuovo da zero.\n\n',
                    ),
                    _testoBold('Usalo per:', Colors.black),
                    const TextSpan(
                      text:
                          ' Testi fissi, icone, sfondi, card informative che non hanno animazioni o interazioni interne.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: STATEFULWIDGET ────────────────────────────────
            _cardLezione(
              titolo: '2. StatefulWidget: Il Semaforo',
              colore: Colors.orange.shade800,
              icona: Icons.traffic_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Uno '),
                    _testoBold('StatefulWidget', Colors.orange.shade900),
                    const TextSpan(text: ' ha una "memoria interna" chiamata '),
                    _testoBold('State', Colors.black),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(
                      text:
                          'È in grado di ricordarsi se un bottone è stato premuto, se un timer sta correndo o se un utente sta scrivendo in un campo di testo.\n\n',
                    ),
                    _testoBold('Come funziona:', Colors.black),
                    const TextSpan(
                      text:
                          ' È diviso in due classi. La prima è il widget, la seconda è lo Stato che contiene i dati e la logica.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: SETSTATE ──────────────────────────────────────
            _cardLezione(
              titolo: '3. setState(): Il Grido di Aiuto',
              colore: Colors.green.shade800,
              icona: Icons.refresh_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'La funzione '),
                    _testoCodiceInline('setState(() {...})'),
                    const TextSpan(
                      text:
                          ' è il modo in cui dici a Flutter: "Ehi, qualcosa nella mia memoria è cambiato! Per favore, ridisegnami".\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Senza questa chiamata, tu potresti anche cambiare il valore di una variabile, ma lo schermo resterebbe identico a prima.\n\n',
                    ),
                    _testoBold('⚠️ Attenzione:', Colors.red.shade900),
                    const TextSpan(
                      text:
                          ' Non chiamare mai setState dentro il metodo build, o creerai un loop infinito che bloccherà l\'app!',
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
              '  int _numero = 0; // La memoria\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Column(\n'
              '      children: [\n'
              '        Text("Valore: \$_numero"),\n'
              '        ElevatedButton(\n'
              '          onPressed: () {\n'
              '            setState(() { _numero++; }); // Ridisegna!\n'
              '          },\n'
              '          child: Text("+1"),\n'
              '        ),\n'
              '      ],\n'
              '    );\n'
              '  }\n'
              '}',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🚀 Regola d\'oro: Inizia sempre con uno StatelessWidget. '
              'Passa allo StatefulWidget solo quando hai bisogno di cambiare qualcosa sullo schermo "dall\'interno" del widget stesso.',
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
        border: Border.all(color: Colors.orange.shade200.withOpacity(0.3)),
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
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.psychology_alt_rounded, color: Colors.orange.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.orange.shade900,
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
