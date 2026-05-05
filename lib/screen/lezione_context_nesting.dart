import 'package:flutter/material.dart';

class LezioneContextNesting extends StatelessWidget {
  final String titoloLezione;

  const LezioneContextNesting({super.key, required this.titoloLezione});

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
        backgroundColor: Colors.teal.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: BUILDCONTEXT ────────────────────────────────────
            _cardLezione(
              titolo: '1. BuildContext: Il GPS del Widget',
              colore: Colors.teal.shade700,
              icona: Icons.explore_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Ogni widget in Flutter ha una posizione precisa nell\'albero dei widget. Il ',
                    ),
                    _testoBold('BuildContext', Colors.teal.shade900),
                    const TextSpan(
                      text: ' è il riferimento a quella posizione.\n\n',
                    ),
                    const TextSpan(text: 'Immaginalo come un '),
                    _testoBold('documento d\'identità', Colors.black),
                    const TextSpan(
                      text:
                          ' che il widget mostra a Flutter per dire: "Io sono qui, e questi sono i miei vicini".\n\n',
                    ),
                    _testoBold('A cosa serve?', Colors.black),
                    const TextSpan(
                      text:
                          ' Serve per trovare il tema dell\'app, per cambiare pagina (Navigazione) o per mostrare messaggi (SnackBar).',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: LA LOGICA DEL NESTING ───────────────────────────
            _cardLezione(
              titolo: '2. Nesting: Scatole Cinesi',
              colore: Colors.indigo.shade700,
              icona: Icons.layers_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text: 'In Flutter non si usa HTML o XML. Si usa il ',
                    ),
                    _testoBold('Nesting', Colors.indigo.shade900),
                    const TextSpan(
                      text:
                          ': ogni widget ne contiene altri al suo interno.\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Questa struttura a "scatole cinesi" si legge sempre dall\'esterno verso l\'interno:\n\n',
                    ),
                    _elementoLista(
                      'Scaffold',
                      'La scatola grande (la pagina).\n',
                    ),
                    _elementoLista(
                      'Center',
                      'La scatola che centra il contenuto.\n',
                    ),
                    _elementoLista(
                      'Column',
                      'La scatola che mette gli elementi in riga.\n\n',
                    ),
                    const TextSpan(text: '💡 '),
                    _testoBold('Consiglio:', Colors.orange.shade900),
                    const TextSpan(
                      text:
                          ' Se vedi troppe parentesi alla fine, usa la virgola dopo ogni widget: Flutter formatterà il codice in modo leggibile!',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: CHILD VS CHILDREN ──────────────────────────────
            _cardLezione(
              titolo: '3. Child vs Children',
              colore: Colors.blue.shade800,
              icona: Icons.reorder_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'È la distinzione più semplice ma più importante:\n\n',
                    ),
                    _elementoLista(
                      'child',
                      'Il widget accetta un solo figlio (es. Center, Padding, Container).\n',
                    ),
                    _elementoLista(
                      'children',
                      'Il widget accetta una lista di figli tra parentesi quadre [ ] (es. Column, Row, ListView).\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Se provi a mettere una lista in un "child", Flutter ti darà errore prima ancora di far partire l\'app!',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Scaffold(\n'
              '  body: Center( // child: un solo figlio\n'
              '    child: Column( // children: lista di figli\n'
              '      children: [\n'
              '        Text("Titolo"),\n'
              '        Text("Sottotitolo"),\n'
              '        Icon(Icons.star),\n'
              '      ],\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🚀 Trucco: Usa il comando "Refactor" (Cmd+. o Alt+Invio) sul tuo editor per avvolgere '
              'automaticamente un widget dentro un altro senza dover riscrivere le parentesi a mano!',
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
        border: Border.all(color: Colors.teal.shade200.withOpacity(0.3)),
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
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_fix_high_rounded, color: Colors.teal.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.teal.shade900,
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
