import 'package:flutter/material.dart';

class LezioneNascitaWidget extends StatelessWidget {
  final String titoloLezione;

  const LezioneNascitaWidget({super.key, required this.titoloLezione});

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
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
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
              colore: Colors.blue.shade700,
              icona: Icons.category_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'In Flutter, ogni elemento dell\'interfaccia è una ',
                    ),
                    _testoBold('Classe', Colors.blue.shade900),
                    const TextSpan(text: '. Immagina la classe come lo '),
                    _testoBold('stampo per i biscotti', Colors.black),
                    const TextSpan(
                      text:
                          ': definisce la forma (le proprietà) e cosa succede quando lo usi (il metodo build).\n\n',
                    ),
                    _testoCodiceInline(
                      'class MioWidget extends StatelessWidget',
                    ),
                    const TextSpan(
                      text:
                          '\n\nCon questa riga dici a Dart: "Voglio creare un nuovo pezzetto di interfaccia che si comporta come un widget standard di Flutter".',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: ERIDITARIETÀ (EXTENDS) ──────────────────────────
            _cardLezione(
              titolo: '2. Perché usiamo "extends"?',
              colore: Colors.indigo.shade700,
              icona: Icons.account_tree_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Usando '),
                    _testoBold('extends', Colors.indigo.shade900),
                    const TextSpan(
                      text:
                          ', il tuo widget eredita "superpoteri" da Flutter senza che tu debba scriverli da zero.\n\n',
                    ),
                    _elementoLista(
                      'StatelessWidget',
                      'Fornisce la struttura base per apparire sullo schermo.\n',
                    ),
                    _elementoLista(
                      '@override',
                      'Indica che stai personalizzando il metodo "build" che Flutter ti mette a disposizione.\n\n',
                    ),
                    const TextSpan(text: '💡 '),
                    _testoBold('Analogia:', Colors.orange.shade900),
                    const TextSpan(
                      text:
                          ' È come avere il telaio di una macchina già pronto: tu devi solo decidere il colore della carrozzeria e il tipo di sedili.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 3: IL COSTRUTTORE E I DATI ────────────────────────
            _cardLezione(
              titolo: '3. Costruttore: Passare Dati',
              colore: Colors.deepPurple.shade700,
              icona: Icons.input_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Il costruttore è il '),
                    _testoBold(
                      'cancello d\'ingresso',
                      Colors.deepPurple.shade900,
                    ),
                    const TextSpan(
                      text:
                          '. Se il tuo widget deve mostrare un nome, quel nome deve entrare dal costruttore.\n\n',
                    ),
                    _sottoTitolo('━━ final: Sola Lettura ━━'),
                    const TextSpan(
                      text:
                          'Le variabili in uno StatelessWidget devono essere sempre ',
                    ),
                    _testoCodiceInline('final'),
                    const TextSpan(
                      text:
                          '. Significa: "una volta ricevuto il valore, questo widget non lo cambierà più".\n\n',
                    ),
                    _sottoTitolo('━━ required: Obbligo ━━'),
                    const TextSpan(text: 'Usando '),
                    _testoCodiceInline('required this.dato'),
                    const TextSpan(
                      text:
                          ', il compilatore ti bloccherà se provi a usare il widget senza passargli le informazioni necessarie.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'class CardUtente extends StatelessWidget {\n'
              '  final String nome; // Dato in sola lettura\n\n'
              '  // Il costruttore riceve il nome\n'
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
              '🚀 Ricorda: Il parametro "super.key" serve a Flutter per identificare il widget in modo univoco nell\'albero. '
              'Non cancellarlo mai, serve per rendere l\'app più fluida!',
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
        border: Border.all(color: Colors.blue.shade200.withOpacity(0.3)),
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: Colors.blue.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.blue.shade900,
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

  TextSpan _sottoTitolo(String testo) {
    return TextSpan(
      text: '\n$testo\n',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: Colors.blueGrey.shade900,
        fontSize: 13,
        height: 2.5,
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
