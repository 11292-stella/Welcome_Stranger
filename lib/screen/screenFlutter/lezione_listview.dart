import 'package:flutter/material.dart';

class LezioneListView extends StatelessWidget {
  final String titoloLezione;

  const LezioneListView({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color poisonGreen = Color(0xFFB2FF59);
    const Color alertRed = Color(0xFFFF5252);
    const Color techPurple = Color(0xFFBB86FC);
    const Color darkBackground = Color(0xFF000000);
    const Color surfaceGrey = Color(0xFF121212);

    return Scaffold(
      backgroundColor: darkBackground,
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
        backgroundColor: surfaceGrey,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: techPurple),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: techPurple.withOpacity(0.3), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: IL PROBLEMA DELL'OVERFLOW ────────────────────────
            _cardLezione(
              titolo: '1. Anomalie Spaziali: L\'Overflow',
              colore: alertRed,
              icona: Icons.warning_amber_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Inserire entità multiple in una '),
                    _testoBold('Column', alertRed),
                    const TextSpan(
                      text:
                          ' satura la memoria visiva. Al superamento dei confini, il sistema genera l\'errore critico delle ',
                    ),
                    _testoBold(
                      'strisce gialle e nere',
                      Colors.black,
                      fondo: Colors.yellow,
                    ),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(text: 'La '),
                    _testoBold('ListView', poisonGreen),
                    const TextSpan(
                      text: ' agisce come un portale: rende lo spazio ',
                    ),
                    _testoBold('infinito e scorrevole', poisonGreen),
                    const TextSpan(
                      text:
                          '. Gestisce il rendering dinamico evitando il collasso della UI.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: LISTVIEW VS BUILDER ──────────────────────────────
            _cardLezione(
              titolo: '2. Protocolli di Rendering',
              colore: techPurple,
              icona: Icons.settings_input_component_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    _sottoTitolo(
                      '━━ ListView Statica (Carico Totale) ━━',
                      techPurple,
                    ),
                    const TextSpan(
                      text:
                          'Carica tutti i figli simultaneamente. Ideale per configurazioni brevi o interfacce fisse.\n\n',
                    ),
                    _sottoTitolo(
                      '━━ ListView.builder (Rendering On-Demand) ━━',
                      techPurple,
                    ),
                    const TextSpan(text: 'Protocollo '),
                    _testoBold('Ottimizzato', poisonGreen),
                    const TextSpan(text: '. Genera in memoria '),
                    _testoBold('solo i frammenti visibili', Colors.white),
                    const TextSpan(
                      text:
                          '. Mentre scorri, ricicla i widget distrutti per crearne di nuovi.\n\n',
                    ),
                    _elementoLista(
                      'itemCount',
                      'Definisce il limite del loop.\n',
                      techPurple,
                    ),
                    _elementoLista(
                      'itemBuilder',
                      'Algoritmo di generazione delle righe.',
                      techPurple,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'ListView.builder(\n'
              '  itemCount: 50, // Limite entità\n'
              '  itemBuilder: (context, index) {\n'
              '    return ListTile(\n'
              '      title: Text("Soggetto #\$index"),\n'
              '    );\n'
              '  },\n'
              ')',
            ),

            const SizedBox(height: 30),

            // ─── SEZIONE 3: LISTTILE ─────────────────────────────────────────
            _cardLezione(
              titolo: '3. ListTile: Anatomia della Riga',
              colore: Colors.blueAccent,
              icona: Icons.reorder_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Evita la costruzione manuale di strutture complesse. Il modulo ',
                    ),
                    _testoBold('ListTile', Colors.blueAccent),
                    const TextSpan(
                      text:
                          ' implementa lo standard industriale per la navigazione lineare.\n\n',
                    ),
                    _elementoLista(
                      'leading',
                      'Settore sinistro (Icona/Avatar).\n',
                      Colors.blueAccent,
                    ),
                    _elementoLista(
                      'title',
                      'Label principale ad alto contrasto.\n',
                      Colors.blueAccent,
                    ),
                    _elementoLista(
                      'subtitle',
                      'Dati secondari di supporto.\n',
                      Colors.blueAccent,
                    ),
                    _elementoLista(
                      'trailing',
                      'Settore destro (Azione/Stato).',
                      Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'ListTile(\n'
              '  leading: Icon(Icons.security),\n'
              '  title: Text("Stato Sistema"),\n'
              '  subtitle: Text("Operativo..."),\n'
              '  trailing: Icon(Icons.chevron_right),\n'
              '  onTap: () => _accessGranted(),\n'
              ')',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🛠️ OTTIMIZZAZIONE: Per liste con separatori fisici, usa "ListView.separated". '
              'Ti permette di iniettare un Divider o un widget di spazio tra ogni elemento del builder.',
            ),

            const SizedBox(height: 50),
            // ─── SEZIONE 4: TEMPLATE COMPLETO LISTVIEW ───────────
            _cardLezione(
              titolo: '4. Template: ListView Completa',
              colore: techPurple,
              icona: Icons.architecture_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Template pronto all\'uso per una lista dinamica con ListTile. Sostituisci la lista dati e il contenuto del ListTile.\n\n',
                    ),
                    _elementoLista(
                      'Step 1',
                      'Definisci la lista di dati da visualizzare.\n',
                      techPurple,
                    ),
                    _elementoLista(
                      'Step 2',
                      'Scegli il tipo di ListView in base alla quantità di elementi.\n',
                      techPurple,
                    ),
                    _elementoLista(
                      'Step 3',
                      'Costruisci ogni riga con ListTile e i suoi quattro settori.\n',
                      techPurple,
                    ),
                    _elementoLista(
                      'Step 4',
                      'Aggiungi separatori se necessario con ListView.separated.',
                      techPurple,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              '// ── STEP 1: I tuoi dati ──────────────────────────────\n'
              'final List<String> elementi = [\n'
              '  "Elemento A",\n'
              '  "Elemento B",\n'
              '  "Elemento C",\n'
              '];\n\n'
              '// ── STEP 2: Scegli il tipo ───────────────────────────\n'
              '// ListView        → lista corta e statica\n'
              '// ListView.builder   → lista lunga o dinamica (consigliato)\n'
              '// ListView.separated → lista con divisori tra gli elementi\n\n'
              'ListView.builder(\n'
              '  itemCount: elementi.length,  // lunghezza della lista\n'
              '  itemBuilder: (context, index) {\n\n'
              '    // ── STEP 3: Costruisci la riga ─────────────────\n'
              '    return ListTile(\n'
              '      leading: Icon(Icons.circle),    // settore sinistro\n'
              '      title: Text(elementi[index]),   // testo principale\n'
              '      subtitle: Text("Dettaglio"),    // testo secondario\n'
              '      trailing: Icon(Icons.chevron_right), // settore destro\n'
              '      onTap: () {\n'
              '        // azione al tap sulla riga\n'
              '      },\n'
              '    );\n'
              '  },\n'
              ')\n\n'
              '// ── STEP 4: Variante con separatori ──────────────────\n'
              'ListView.separated(\n'
              '  itemCount: elementi.length,\n'
              '  separatorBuilder: (context, index) => const Divider(),\n'
              '  itemBuilder: (context, index) {\n'
              '    return ListTile(title: Text(elementi[index]));\n'
              '  },\n'
              ')',
            ),

            _suggerimentoCreativo(
              'Se la ListView è dentro una Column, ricordati di avvolgerla in un '
              'Expanded — altrimenti Flutter non sa quanto spazio assegnarle '
              'e genera un errore di overflow.',
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
          const Icon(Icons.biotech_rounded, color: Colors.cyanAccent, size: 20),
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

  TextSpan _testoBold(String testo, Color colore, {Color? fondo}) {
    return TextSpan(
      text: testo,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: colore,
        backgroundColor: fondo,
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
