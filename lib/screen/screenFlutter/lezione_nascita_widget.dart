import 'package:flutter/material.dart';
import 'package:nuova_app/theme/horror_theme.dart'; // Assicurati che il percorso sia corretto

class LezioneNascitaWidget extends StatelessWidget {
  final String titoloLezione;

  const LezioneNascitaWidget({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    final horror = Theme.of(context).extension<HorrorTheme>();
    final neonBlue = const Color(0xFF2979FF);
    final neonPurple = const Color(0xFFD500F9);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style:
              horror?.horrorTitle?.copyWith(fontSize: 18) ??
              const TextStyle(color: Colors.white, letterSpacing: 1.2),
        ),
        backgroundColor: const Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: IL CONCETTO DI CLASSE ───────────────────────────
            _cardLezione(
              titolo: '1. La Classe come "Stampo"',
              colore: neonBlue,
              icona: Icons.category_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoAcademy(),
                  children: [
                    const TextSpan(
                      text:
                          'In Flutter, ogni elemento dell\'interfaccia è una ',
                    ),
                    _testoBold('Classe', neonBlue),
                    const TextSpan(text: '. Immagina la classe come lo '),
                    _testoBold('stampo per i biscotti', Colors.white),
                    const TextSpan(
                      text:
                          ': definisce la forma (le proprietà) e cosa succede quando lo usi (il metodo build).\n\n',
                    ),
                    _testoCodiceInline(
                      'class MioWidget extends StatelessWidget',
                    ),
                    const TextSpan(
                      text:
                          '\n\nCon questa riga dici a Dart: "Voglio creare un nuovo pezzetto di interfaccia che si comporta come un widget standard".',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: EREDITARIETÀ (EXTENDS) ──────────────────────────
            _cardLezione(
              titolo: '2. Perché usiamo "extends"?',
              colore: neonPurple,
              icona: Icons.account_tree_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoAcademy(),
                  children: [
                    const TextSpan(text: 'Usando '),
                    _testoBold('extends', neonPurple),
                    const TextSpan(
                      text:
                          ', il tuo widget eredita "superpoteri" da Flutter senza doverli riscrivere.\n\n',
                    ),
                    _elementoLista(
                      'StatelessWidget',
                      'La struttura base per apparire sullo schermo.\n',
                      neonPurple,
                    ),
                    _elementoLista(
                      '@override',
                      'Indica che stai personalizzando il metodo "build" di sistema.\n\n',
                      neonPurple,
                    ),
                    const TextSpan(text: '💡 '),
                    _testoBold('Analogia:', Colors.orangeAccent),
                    const TextSpan(
                      text:
                          ' È come avere il telaio di una macchina pronto: tu decidi solo il colore e i sedili.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: IL COSTRUTTORE E I DATI ────────────────────────
            _cardLezione(
              titolo: '3. Costruttore: Passare Dati',
              colore: Colors.cyanAccent,
              icona: Icons.input_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoAcademy(),
                  children: [
                    const TextSpan(text: 'Il costruttore è il '),
                    _testoBold('cancello d\'ingresso', Colors.cyanAccent),
                    const TextSpan(
                      text:
                          '. Se il widget deve mostrare un dato, deve entrare da qui.\n\n',
                    ),
                    _sottoTitolo(
                      '━━ final: Sola Lettura ━━',
                      Colors.cyanAccent,
                    ),
                    const TextSpan(
                      text: 'Le variabili negli StatelessWidget sono sempre ',
                    ),
                    _testoCodiceInline('final'),
                    const TextSpan(
                      text:
                          '. Ovvero: una volta ricevuto il valore, il widget non lo cambierà più.\n\n',
                    ),
                    _sottoTitolo('━━ required: Obbligo ━━', Colors.cyanAccent),
                    const TextSpan(text: 'Usando '),
                    _testoCodiceInline('required this.dato'),
                    const TextSpan(
                      text:
                          ', il compilatore ti bloccherà se dimentichi di passare le info.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'class CardUtente extends StatelessWidget {\n'
              '  final String nome; // Immutabile\n\n'
              '  const CardUtente({\n'
              '    super.key, \n'
              '    required this.nome\n'
              '  });\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Text(nome);\n'
              '  }\n'
              '}',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🚀 Ricorda: Il parametro "super.key" serve a Flutter per identificare il widget nell\'albero. '
              'È fondamentale per le performance, non lasciarlo mai indietro!',
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
        border: Border.all(color: colore.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: colore.withOpacity(0.05),
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
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icona,
                  color: colore,
                  size: 26,
                  shadows: [Shadow(color: colore, blurRadius: 8)],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    titolo,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: colore,
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
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.bolt_rounded, color: Colors.blueAccent),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Colors.blueAccent,
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

  TextSpan _testoCodiceInline(String testo) {
    return TextSpan(
      text: ' $testo ',
      style: const TextStyle(
        fontFamily: 'monospace',
        color: Colors.greenAccent,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.white10,
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
