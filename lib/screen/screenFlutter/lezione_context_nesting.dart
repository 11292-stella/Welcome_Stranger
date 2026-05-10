import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:nuova_app/theme/horror_theme.dart'; // Mantieni il riferimento al tuo tema custom

class LezioneContextNesting extends StatelessWidget {
  final String titoloLezione;

  const LezioneContextNesting({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    final horror = Theme.of(context).extension<HorrorTheme>();
    final neonCyan = const Color(0xFF00E5FF);
    final neonGreen = const Color(0xFF76FF03);
    final deepBackground = const Color(0xFF0A0A0A);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style:
              horror?.horrorTitle?.copyWith(fontSize: 18) ??
              const TextStyle(color: Colors.white, letterSpacing: 1.2),
        ),
        backgroundColor: deepBackground,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: BUILDCONTEXT (IL GPS) ───────────────────────────
            _cardLezione(
              titolo: '1. BuildContext: Il Radar del Widget',
              colore: neonCyan,
              icona: Icons.radar_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoAcademy(),
                  children: [
                    const TextSpan(
                      text: 'Ogni widget ha una posizione nel sistema. Il ',
                    ),
                    _testoBold('BuildContext', neonCyan),
                    const TextSpan(
                      text:
                          ' è il radar che permette al widget di sapere dove si trova.\n\n',
                    ),
                    const TextSpan(text: 'Immaginalo come un '),
                    _testoBold('segnale di localizzazione', Colors.white),
                    const TextSpan(
                      text:
                          ': senza di esso, il widget sarebbe perso e non saprebbe come parlare con il resto dell\'app.\n\n',
                    ),
                    _sottoTitolo('━━ Funzioni Radar ━━', neonCyan),
                    _elementoLista(
                      'Temi',
                      'Trova i colori e i font globali.\n',
                      neonCyan,
                    ),
                    _elementoLista(
                      'Navigazione',
                      'Capisce come passare alla schermata successiva.\n',
                      neonCyan,
                    ),
                    _elementoLista(
                      'Dimensioni',
                      'Rileva quanto spazio ha a disposizione sullo schermo.',
                      neonCyan,
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: NESTING (SCATOLE CINESI) ─────────────────────────
            _cardLezione(
              titolo: '2. Nesting: Strutture Annidate',
              colore: neonGreen,
              icona: Icons.account_tree_outlined,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoAcademy(),
                  children: [
                    const TextSpan(text: 'In Flutter tutto si incastra. Il '),
                    _testoBold('Nesting', neonGreen),
                    const TextSpan(
                      text:
                          ' è l\'arte di inserire widget dentro altri widget.\n\n',
                    ),
                    const TextSpan(
                      text:
                          'La gerarchia si legge dall\'alto (il Genitore) verso il basso (i Figli):\n\n',
                    ),
                    _elementoLista(
                      'Scaffold',
                      'Il perimetro della tua area operativa.\n',
                      neonGreen,
                    ),
                    _elementoLista(
                      'Center',
                      'Il modulo di centraggio dei dati.\n',
                      neonGreen,
                    ),
                    _elementoLista(
                      'Column',
                      'L\'allineamento verticale dei componenti.\n\n',
                      neonGreen,
                    ),
                    const TextSpan(text: '💡 '),
                    _testoBold('Codice Pulito:', Colors.orangeAccent),
                    const TextSpan(
                      text:
                          ' Metti sempre la virgola dopo l\'ultima parentesi. Flutter formatterà il nesting in verticale rendendolo leggibile.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: CHILD VS CHILDREN ──────────────────────────────
            _cardLezione(
              titolo: '3. Protocolli: Child vs Children',
              colore: Colors.amberAccent,
              icona: Icons.mediation_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoAcademy(),
                  children: [
                    const TextSpan(
                      text: 'È una questione di capacità di contenimento:\n\n',
                    ),
                    _elementoLista(
                      'child',
                      'Singolo slot. Accetta un solo widget (es. Container, Padding).\n',
                      Colors.amberAccent,
                    ),
                    _elementoLista(
                      'children',
                      'Array di slot. Accetta una lista di widget [ ] (es. Row, Column).\n\n',
                      Colors.amberAccent,
                    ),
                    const TextSpan(text: '⚠️ '),
                    _testoBold('Errore Critico:', Colors.redAccent),
                    const TextSpan(
                      text:
                          ' Se provi a forzare una lista in un "child", il compilatore interromperà il processo immediatamente.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Scaffold(\n'
              '  body: Center( // child: 1 slot\n'
              '    child: Column( // children: array\n'
              '      children: [\n'
              '        Text("Modulo A"),\n'
              '        Text("Modulo B"),\n'
              '        Icon(Icons.terminal),\n'
              '      ],\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🛠️ PROTOCOLLO REFACTOR: Usa (Cmd+.) su Mac o (Alt+Invio) su Windows mentre sei su un widget. '
              'Il sistema ti permetterà di avvolgerlo (Wrap) in un nuovo contenitore istantaneamente.',
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI HORROR ──────────────────────────────────────────

  TextStyle _stileTestoAcademy() =>
      const TextStyle(color: Colors.white70, fontSize: 15, height: 1.7);

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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colore.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icona,
                  color: colore,
                  size: 26,
                  shadows: [Shadow(color: colore, blurRadius: 10)],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    titolo.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
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
        color: const Color(0xFF001A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyan.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.psychology_outlined, color: Colors.cyanAccent),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  TextSpan _sottoTitolo(String testo, Color colore) {
    return TextSpan(
      text: '\n$testo\n',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: colore,
        fontSize: 12,
        height: 2.5,
      ),
    );
  }

  TextSpan _elementoLista(String termine, String descrizione, Color colore) {
    return TextSpan(
      children: [
        TextSpan(
          text: '• $termine: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colore.withOpacity(0.8),
          ),
        ),
        TextSpan(text: descrizione),
      ],
    );
  }
}
