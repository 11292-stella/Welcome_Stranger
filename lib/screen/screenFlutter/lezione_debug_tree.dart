import 'package:flutter/material.dart';

class LezioneDebugTree extends StatelessWidget {
  final String titoloLezione;

  const LezioneDebugTree({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    // Definizione Palette Debug
    const Color debugRed = Color(0xFFD32F2F);
    const Color elementBlue = Color(0xFF1976D2);
    const Color renderGreen = Color(0xFF388E3C);
    const Color debugPaintCyan = Color(0xFF00BCD4);
    const Color darkSurface = Color(0xFF1A1A1A);

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
        backgroundColor: debugRed,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
        shadowColor: debugRed.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: LA SPIEGAZIONE CONCETTUALE ──────────────────────
            _cardLezione(
              titolo: 'Perché Tre Alberi?',
              colore: debugRed,
              icona: Icons.layers_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Immagina di voler costruire una casa. In Flutter, questo processo non è diretto, ma diviso in tre fasi critiche:',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildTreeStep(
                    titolo: '1. Widget Tree (Il Progetto)',
                    desc:
                        'È il "disegno" della casa. Dice: "Voglio una finestra qui". È economico: se non ti piace, strappi il foglio e lo rifai (Rebuild).',
                    colore: Colors.orangeAccent,
                  ),
                  _buildTreeStep(
                    titolo: '2. Element Tree (Il Capocantiere)',
                    desc:
                        'È colui che tiene il progetto in mano. Non cambia mai se non è necessario. Se il progetto dice "Finestra", lui controlla se ne ha già una vecchia da riutilizzare.',
                    colore: elementBlue,
                  ),
                  _buildTreeStep(
                    titolo: '3. Render Tree (L\'Operaio)',
                    desc:
                        'È chi sporca le mani. Calcola i millimetri esatti e spruzza il colore. È la parte più pesante, per questo Flutter cerca di farlo lavorare il meno possibile.',
                    colore: renderGreen,
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 2: IL SEGRETO DELLA VELOCITÀ ────────────────────────
            _cardLezione(
              titolo: 'Il Segreto del Diffing',
              colore: elementBlue,
              icona: Icons.flash_on_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Quando chiami '),
                    _testoBold('setState()', Colors.orangeAccent),
                    const TextSpan(
                      text:
                          ', Flutter crea un nuovo Widget Tree. Ma attenzione: l\'\n\n',
                    ),
                    _testoBold('Element Tree ', elementBlue),
                    const TextSpan(
                      text:
                          'confronta il vecchio widget con il nuovo. Se il tipo è lo stesso (es. era un Text ed è ancora un Text), Flutter ',
                    ),
                    _testoBold('aggiorna solo i dati ', Colors.white),
                    const TextSpan(
                      text:
                          'senza distruggere e ricostruire l\'operaio (RenderObject). Ecco perché è fluido!',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: OTTIMIZZAZIONE PRATICA ──────────────────────────
            _cardLezione(
              titolo: 'Codice Pulito = Albero Leggero',
              colore: renderGreen,
              icona: Icons.speed_rounded,
              corpo: Column(
                children: [
                  RichText(
                    text: _elementoLista(
                      'Usa "const"',
                      'Evita che Flutter crei un nuovo pezzo di progetto inutilmente.\n',
                      renderGreen,
                    ),
                  ),
                  RichText(
                    text: _elementoLista(
                      'Scomponi',
                      'Widget piccoli = Elementi piccoli da controllare. Se aggiorni un bottone, non devi ricalcolare tutta la pagina.',
                      renderGreen,
                    ),
                  ),
                ],
              ),
            ),

            _boxCodice(
              '// ❌ MALE: Albero troppo profondo in un unico build\n'
              'Widget build(BuildContext context) {\n'
              '  return Column(children: [ \n'
              '     Container(child: Padding(child: Text("Troppo nesting!")))\n'
              '  ]);\n'
              '}\n\n'
              '// ✅ BENE: Estrai in widget costanti\n'
              'const MyTextWidget(text: "Ottimizzato!");',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              'Usa il "Debug Paint" dall\'Inspector: vedrai delle linee blu, verdi e gialle. '
              'Quelle linee sono la rappresentazione visiva del Render Tree (l\'operaio) al lavoro!',
            ),

            const SizedBox(height: 50),
            // ─── COME ATTIVARE IL DEBUG PAINT ───────────────────
            _cardLezione(
              titolo: 'Come Attivare il Debug Paint',
              colore: debugPaintCyan,
              icona: Icons.tune_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ci sono tre modi per attivarlo — dal più veloce al più preciso:',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildTreeStep(
                    titolo: 'Metodo 1: DevTools (consigliato)',
                    desc:
                        'Avvia l\'app in debug, apri DevTools dal tuo editor e clicca l\'icona del pennello in alto. Nessun codice da scrivere.',
                    colore: debugPaintCyan,
                  ),
                  _buildTreeStep(
                    titolo: 'Metodo 2: Da codice nel main()',
                    desc:
                        'Aggiungi debugPaintSizeEnabled = true; prima di runApp(). Ricordati di toglierlo prima di pubblicare.',
                    colore: Colors.orangeAccent,
                  ),
                  _buildTreeStep(
                    titolo: 'Metodo 3: Scorciatoia VS Code',
                    desc:
                        'Con l\'app in esecuzione apri la Command Palette (Ctrl+Shift+P) e cerca "Toggle Debug Paint".',
                    colore: elementBlue,
                  ),
                  const SizedBox(height: 10),
                  _alertSuggerimento(
                    '⚠️ Il Debug Paint funziona SOLO in modalità debug. Non appare mai nella build finale dell\'app.',
                  ),
                ],
              ),
            ),

            _boxCodice(
              '// Metodo 2: nel tuo main.dart\n'
              'import \'package:flutter/rendering.dart\'; // import necessario\n\n'
              'void main() {\n'
              '  debugPaintSizeEnabled = true;    // bordi di ogni widget\n'
              '  debugPaintBaselinesEnabled = true; // linee base del testo\n'
              '  debugPaintPointersEnabled = true;  // area cliccabile dei tap\n'
              '  runApp(const MiaApp());\n'
              '}',
            ),

            const SizedBox(height: 30),

            // ─── TEMPLATE: COME LEGGERE IL DEBUG PAINT ──────────
            _cardLezione(
              titolo: 'Template: Diagnosi di un Layout Rotto',
              colore: renderGreen,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quando qualcosa non si posiziona come vuoi, segui questo protocollo di diagnosi in ordine:',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildTreeStep(
                    titolo: 'Step 1 — Attiva il Debug Paint',
                    desc:
                        'Guarda i bordi blu: il widget occupa lo spazio che ti aspetti? Spesso un widget è più grande o più piccolo del previsto.',
                    colore: Colors.blue,
                  ),
                  _buildTreeStep(
                    titolo: 'Step 2 — Controlla il padding (ciano)',
                    desc:
                        'Le linee ciano mostrano lo spazio interno. Se c\'è troppo spazio intorno a un testo, probabilmente c\'è un padding nascosto da qualche parte.',
                    colore: Colors.cyan,
                  ),
                  _buildTreeStep(
                    titolo: 'Step 3 — Cerca le strisce giallo/nere',
                    desc:
                        'Overflow. Il widget è troppo grande per il suo genitore. Soluzione: avvolgi in un Expanded, aggiungi uno scroll, o riduci le dimensioni.',
                    colore: Colors.amber,
                  ),
                  _buildTreeStep(
                    titolo: 'Step 4 — Usa il Widget Inspector',
                    desc:
                        'Clicca direttamente sul widget problematico nel telefono — il cursore salterà esattamente alla riga di codice corrispondente.',
                    colore: renderGreen,
                  ),
                  const SizedBox(height: 10),
                  _alertSuggerimento(
                    '💡 Il 90% dei problemi di layout si risolve ai Step 1 e 3. '
                    'Se il widget non è dove ti aspetti: Step 1. '
                    'Se vedi strisce nere: Step 3.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI DI SUPPORTO ──────────────────────────────────────────

  Widget _buildTreeStep({
    required String titolo,
    required String desc,
    required Color colore,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: colore,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titolo,
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                  titolo,
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFF76FF03),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
      ),
      child: Text(
        "💡 $testo",
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);

  TextSpan _testoBold(String testo, Color colore) {
    return TextSpan(
      text: testo,
      style: TextStyle(fontWeight: FontWeight.bold, color: colore),
    );
  }

  TextSpan _elementoLista(String termine, String descrizione, Color colore) {
    return TextSpan(
      children: [
        TextSpan(
          text: '• $termine: ',
          style: TextStyle(fontWeight: FontWeight.bold, color: colore),
        ),
        TextSpan(
          text: descrizione,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
