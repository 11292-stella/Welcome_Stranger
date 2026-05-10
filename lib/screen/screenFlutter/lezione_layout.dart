import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class LezioneLayout extends StatelessWidget {
  final String titoloLezione;

  const LezioneLayout({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color electricIndigo = Color.fromARGB(
      255,
      59,
      3,
      128,
    ); // Viola profondo
    const Color neonViolet = Color(0xFFBB86FC);
    const Color darkSurface = Color(0xFF121212);
    const Color warningOrange = Color(0xFFFFAB40);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: darkSurface,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: neonViolet),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: neonViolet.withOpacity(0.3), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: ROW E COLUMN ──────────────────────
            _cardLezione(
              titolo: '1. Sistemi Flex: I Pilastri',
              colore: neonViolet,
              icona: Icons.grid_view_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'L\'architettura non usa coordinate fisse, ma moduli ',
                    ),
                    _testoBold('Flex', neonViolet),
                    const TextSpan(
                      text: '. I due vettori principali sono:\n\n',
                    ),
                    _elementoLista(
                      'Row (Orizzontale)',
                      'Allinea i moduli uno accanto all\'altro.\n\n',
                      neonViolet,
                    ),
                    _elementoLista(
                      'Column (Verticale)',
                      'Impila i moduli uno sotto l\'altro.\n\n',
                      neonViolet,
                    ),
                    const TextSpan(
                      text: 'Entrambi gestiscono un array di entità tramite ',
                    ),
                    _testoCodiceInline('children: []'),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: GLI ASSI ──────────────────────────
            _cardLezione(
              titolo: '2. Calibrazione Assi: Main & Cross',
              colore: Colors.cyanAccent,
              icona: Icons.unfold_more_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Ogni Row e Column ha due assi: il '),
                    _testoBold('MainAxis', Colors.white),
                    const TextSpan(
                      text:
                          ' (la direzione in cui scorre il widget: orizzontale per Row, verticale per Column) e il ',
                    ),
                    _testoBold('CrossAxis', Colors.white),
                    const TextSpan(
                      text:
                          ' (quello perpendicolare). I due parametri seguenti controllano come i figli vengono distribuiti su questi assi.\n\n',
                    ),
                    _sottoTitolo(
                      '━━ MainAxisAlignment (Distribuzione) ━━',
                      Colors.cyanAccent,
                    ),
                    _elementoLista(
                      'center',
                      'Raggruppa tutti i figli al centro dell\'asse principale.\n',
                      Colors.cyanAccent,
                    ),
                    _elementoLista(
                      'spaceBetween',
                      'Mette spazio uguale tra i figli, ma non ai bordi esterni.\n',
                      Colors.cyanAccent,
                    ),
                    _elementoLista(
                      'spaceEvenly',
                      'Distribuisce spazio uguale sia tra i figli che ai bordi.\n\n',
                      Colors.cyanAccent,
                    ),
                    _sottoTitolo(
                      '━━ CrossAxisAlignment (Perpendicolare) ━━',
                      Colors.cyanAccent,
                    ),
                    const TextSpan(
                      text:
                          'Controlla l\'allineamento sull\'asse opposto. In una ',
                    ),
                    _testoBold('Column', Colors.white),
                    const TextSpan(
                      text: ' il CrossAxis è orizzontale, quindi ',
                    ),
                    _testoBold('start', Colors.white),
                    const TextSpan(text: ' spinge i figli a sinistra, '),
                    _testoBold('center', Colors.white),
                    const TextSpan(text: ' li centra, e '),
                    _testoBold('stretch', Colors.white),
                    const TextSpan(
                      text:
                          ' li allarga fino a occupare tutta la larghezza disponibile. In una ',
                    ),
                    _testoBold('Row', Colors.white),
                    const TextSpan(
                      text:
                          ' vale il contrario: il CrossAxis diventa verticale.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Column(\n'
              '  mainAxisAlignment: MainAxisAlignment.center,\n'
              '  crossAxisAlignment: CrossAxisAlignment.start,\n'
              '  children: [\n'
              '    Text("Inizializzazione..."),\n'
              '    Icon(Icons.binary),\n'
              '  ],\n'
              ')',
            ),

            const SizedBox(height: 30),

            // ─── SEZIONE 3: EXPANDED ──────────────────────────
            _cardLezione(
              titolo: '3. Expanded: Occupazione Totale',
              colore: warningOrange,
              icona: Icons.open_in_full_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Quando un widget deve saturare lo spazio rimanente, si attiva ',
                    ),
                    _testoBold('Expanded', warningOrange),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(
                      text:
                          'Questo componente rende il widget "elastico", costringendolo a espandersi finché non incontra i confini del genitore.\n\n',
                    ),
                    _testoBold('Rapporto Flex:', Colors.white),
                    const TextSpan(text: ' Usa '),
                    _testoCodiceInline('flex: 2'),
                    const TextSpan(
                      text:
                          ' per raddoppiare la priorità di espansione rispetto ad altri moduli.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Row(\n'
              '  children: [\n'
              '    Icon(Icons.warning),\n'
              '    Expanded(\n'
              '      child: Text("Saturazione dello spazio in corso..."),\n'
              '    ),\n'
              '  ],\n'
              ')',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🛠️ LOGICA DI PROGETTAZIONE: Ogni interfaccia complessa è una nidificazione di Row e Column. '
              'Immagina la UI come un sistema di scatole che contengono altre scatole.',
            ),

            const SizedBox(height: 50),
            // ─── SEZIONE 4: TEMPLATE COMPLETO LAYOUT ─────────────
            _cardLezione(
              titolo: '4. Template: Struttura Layout Completa',
              colore: neonViolet,
              icona: Icons.architecture_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Un template pronto all\'uso. Ogni parametro è commentato — sostituisci i valori e hai una struttura funzionante.\n\n',
                    ),
                    _elementoLista(
                      'Step 1',
                      'Scegli il vettore principale: Row o Column.\n',
                      neonViolet,
                    ),
                    _elementoLista(
                      'Step 2',
                      'Calibra MainAxisAlignment per distribuire i figli.\n',
                      neonViolet,
                    ),
                    _elementoLista(
                      'Step 3',
                      'Calibra CrossAxisAlignment per allinearli sull\'asse opposto.\n',
                      neonViolet,
                    ),
                    _elementoLista(
                      'Step 4',
                      'Usa Expanded per i figli che devono saturare lo spazio rimanente.',
                      neonViolet,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              '// ── STEP 1: Scegli il vettore ────────────────────────\n'
              'Column(                          // oppure Row\n\n'
              '  // ── STEP 2: Asse principale ──────────────────────\n'
              '  mainAxisAlignment: MainAxisAlignment.center,\n'
              '  // .start      → tutto in cima (o a sinistra in Row)\n'
              '  // .center     → tutto al centro\n'
              '  // .end        → tutto in fondo (o a destra in Row)\n'
              '  // .spaceBetween → spazio tra i figli, non ai bordi\n'
              '  // .spaceEvenly  → spazio uguale ovunque, bordi inclusi\n\n'
              '  // ── STEP 3: Asse perpendicolare ──────────────────\n'
              '  crossAxisAlignment: CrossAxisAlignment.start,\n'
              '  // .start   → allinea a sinistra (o in cima in Row)\n'
              '  // .center  → centra sull\'asse trasversale\n'
              '  // .stretch → allarga i figli a tutta la larghezza\n\n'
              '  // ── STEP 4: Figli ────────────────────────────────\n'
              '  children: [\n'
              '    Text("Widget statico"),\n\n'
              '    Expanded(\n'
              '      flex: 1,           // peso relativo (default 1)\n'
              '      child: Container(\n'
              '        color: Colors.blue,\n'
              '        child: Text("Occupa tutto lo spazio rimanente"),\n'
              '      ),\n'
              '    ),\n\n'
              '    Expanded(\n'
              '      flex: 2,           // doppio spazio rispetto al precedente\n'
              '      child: Container(\n'
              '        color: Colors.purple,\n'
              '        child: Text("Occupa il doppio"),\n'
              '      ),\n'
              '    ),\n'
              '  ],\n'
              ')',
            ),

            _suggerimentoCreativo(
              'La regola dei flex: i valori non sono percentuali fisse ma rapporti. '
              'flex:1 e flex:2 significa che il secondo occupa 2/3 dello spazio totale '
              'e il primo 1/3 — indipendentemente dalla dimensione dello schermo.',
            ),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI SUPPORTO ──────────────────────────────────────────

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
        color: const Color(0xFF0D121F),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyan.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.architecture_rounded,
            color: Colors.cyanAccent,
            size: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Colors.cyanAccent,
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

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14, height: 1.6);

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

  TextSpan _sottoTitolo(String testo, Color colore) {
    return TextSpan(
      text: '\n$testo\n',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: colore,
        fontSize: 11,
        letterSpacing: 1.0,
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
            color: colore.withOpacity(0.7),
          ),
        ),
        TextSpan(text: descrizione),
      ],
    );
  }
}
