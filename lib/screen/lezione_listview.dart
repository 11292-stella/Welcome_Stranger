import 'package:flutter/material.dart';

class LezioneListView extends StatelessWidget {
  final String titoloLezione;

  const LezioneListView({super.key, required this.titoloLezione});

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
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: IL PROBLEMA DELL'OVERFLOW ────────────────────────
            _cardLezione(
              titolo: '1. Perché usare ListView?',
              colore: Colors.red.shade700,
              icona: Icons.warning_amber_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Se metti 20 bottoni dentro una '),
                    _testoBold('Column', Colors.red.shade900),
                    const TextSpan(
                      text:
                          ', Flutter proverà a disegnarli tutti. Quando superano il bordo dello schermo, apparirà l\'errore delle ',
                    ),
                    _testoBold(
                      'strisce gialle e nere (Overflow)',
                      Colors.black,
                    ),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(text: 'La '),
                    _testoBold('ListView', Colors.green.shade800),
                    const TextSpan(
                      text: ' è la soluzione: rende l\'area immediatamente ',
                    ),
                    _testoBold(
                      'scorrevole (scrollable)',
                      Colors.green.shade800,
                    ),
                    const TextSpan(
                      text:
                          '. È un contenitore intelligente che gestisce lo spazio infinito.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: LISTVIEW VS LISTVIEW.BUILDER ─────────────────────
            _cardLezione(
              titolo: '2. ListView vs ListView.builder',
              colore: Colors.purple.shade700,
              icona: Icons.bolt_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    _sottoTitolo('━━ ListView Classica (Statica) ━━'),
                    const TextSpan(
                      text:
                          'La usi quando hai pochi elementi (es. una pagina di impostazioni). Flutter carica tutti i figli in memoria contemporaneamente.\n\n',
                    ),
                    _sottoTitolo('━━ ListView.builder (Dinamica/PRO) ━━'),
                    const TextSpan(text: 'È il modo '),
                    _testoBold('professionale', Colors.purple.shade900),
                    const TextSpan(
                      text:
                          ' di gestire liste lunghe o infinite. Questa versione carica in memoria ',
                    ),
                    _testoBold('solo quello che vedi', Colors.black),
                    const TextSpan(
                      text:
                          ' sullo schermo. Mentre scorri, distrugge i widget vecchi e crea quelli nuovi al volo.\n\n',
                    ),
                    const TextSpan(
                      text: 'Richiede due parametri fondamentali:\n',
                    ),
                    _elementoLista(
                      'itemCount',
                      'quanti elementi ci sono in totale.\n',
                    ),
                    _elementoLista(
                      'itemBuilder',
                      'la funzione che "disegna" ogni singola riga.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'ListView.builder(\n'
              '  itemCount: 50, // 50 elementi\n'
              '  itemBuilder: (context, index) {\n'
              '    return ListTile(\n'
              '      title: Text("Elemento numero \$index"),\n'
              '    );\n'
              '  },\n'
              ')',
            ),

            const SizedBox(height: 30),

            // ─── SEZIONE 3: IL WIDGET LISTTILE ──────────────────────────────
            _cardLezione(
              titolo: '3. ListTile: La riga perfetta',
              colore: Colors.blue.shade700,
              icona: Icons.view_list_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Non c\'è bisogno di creare una Row complessa per ogni riga. Flutter ci regala ',
                    ),
                    _testoBold('ListTile', Colors.blue.shade900),
                    const TextSpan(
                      text:
                          ', un widget pre-impostato che segue le linee guida del Material Design.\n\n',
                    ),
                    _elementoLista(
                      'leading',
                      'spazio a sinistra (es. icona o avatar).\n',
                    ),
                    _elementoLista('title', 'testo principale in grassetto.\n'),
                    _elementoLista(
                      'subtitle',
                      'testo secondario più piccolo.\n',
                    ),
                    _elementoLista(
                      'trailing',
                      'spazio a destra (es. freccetta o checkbox).\n',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'ListTile(\n'
              '  leading: CircleAvatar(child: Text("A")),\n'
              '  title: Text("Contatto Nome"),\n'
              '  subtitle: Text("Ultimo messaggio ricevuto..."),\n'
              '  trailing: Icon(Icons.chevron_right),\n'
              '  onTap: () { print("Hai cliccato!"); },\n'
              ')',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '💡 Idea: Se vuoi aggiungere dei separatori tra un elemento e l\'altro senza fatica, '
              'usa ListView.separated invece di .builder. Ti permette di aggiungere un widget (come un Divider) tra ogni riga!',
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
        border: Border.all(color: Colors.purple.shade200.withOpacity(0.3)),
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.tips_and_updates_rounded, color: Colors.purple.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.purple.shade900,
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
