import 'package:flutter/material.dart';

class LezioneLayout extends StatelessWidget {
  final String titoloLezione;

  const LezioneLayout({super.key, required this.titoloLezione});

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
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: IL CONCETTO DI ROW E COLUMN ──────────────────────
            _cardLezione(
              titolo: '1. Row e Column: I Pilastri del Layout',
              colore: Colors.indigo,
              icona: Icons.grid_view_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'In Flutter, per disporre i widget non si usano coordinate fisse (X, Y), ma si usano i ',
                    ),
                    _testoBold('Flex Widget', Colors.indigo),
                    const TextSpan(text: '. I due più importanti sono:\n\n'),
                    _elementoLista(
                      'Row (Riga)',
                      'dispone i suoi figli in orizzontale, uno accanto all\'altro.\n\n',
                    ),
                    _elementoLista(
                      'Column (Colonna)',
                      'dispone i suoi figli in verticale, uno sotto l\'altro.\n\n',
                    ),
                    const TextSpan(
                      text:
                          'Entrambi accettano una lista di widget tramite la proprietà ',
                    ),
                    _testoCodiceInline('children: []'),
                    const TextSpan(
                      text:
                          ', a differenza di altri widget che accettano un solo ',
                    ),
                    _testoCodiceInline('child'),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 2: GLI ASSI (MAIN E CROSS) ──────────────────────────
            _cardLezione(
              titolo: '2. Gestire lo spazio: Main e Cross Axis',
              colore: Colors.teal.shade800,
              icona: Icons.unfold_more_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Per allineare gli elementi, devi capire il concetto di ',
                    ),
                    _testoBold('Asse Principale', Colors.black),
                    const TextSpan(text: ' e '),
                    _testoBold('Asse Trasversale', Colors.black),
                    const TextSpan(text: '.\n\n'),
                    _sottoTitolo('━━ MainAxisAlignment (Lungo l\'asse) ━━'),
                    const TextSpan(
                      text:
                          'Controlla come i widget sono distribuiti nella direzione principale.\n',
                    ),
                    _elementoLista('start', 'tutti all\'inizio.\n'),
                    _elementoLista('center', 'tutti al centro.\n'),
                    _elementoLista(
                      'spaceBetween',
                      'spazio massimo tra i widget.\n',
                    ),
                    _elementoLista('spaceEvenly', 'spazio uguale ovunque.\n\n'),
                    _sottoTitolo('━━ CrossAxisAlignment (Perpendicolare) ━━'),
                    const TextSpan(
                      text:
                          'Controlla l\'allineamento nell\'altra direzione. Ad esempio, in una ',
                    ),
                    _testoBold('Column', Colors.teal.shade900),
                    const TextSpan(
                      text:
                          ', il Cross Axis è l\'orizzontale. Se vuoi che tutto sia centrato orizzontalmente in una colonna, usi ',
                    ),
                    _testoCodiceInline('CrossAxisAlignment.center'),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Column(\n'
              '  mainAxisAlignment: MainAxisAlignment.spaceAround,\n'
              '  crossAxisAlignment: CrossAxisAlignment.start,\n'
              '  children: [\n'
              '    Text("Primo elemento"),\n'
              '    Icon(Icons.star),\n'
              '    ElevatedButton(onPressed: () {}, child: Text("Click")),\n'
              '  ],\n'
              ')',
            ),

            const SizedBox(height: 30),

            // ─── SEZIONE 3: EXPANDED E FLEXIBILE ──────────────────────────
            _cardLezione(
              titolo: '3. Expanded: Riempire lo spazio',
              colore: Colors.deepOrange.shade800,
              icona: Icons.open_in_full_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Cosa succede se vuoi che un widget occupi tutto lo spazio rimanente? Usi ',
                    ),
                    _testoBold('Expanded', Colors.deepOrange.shade900),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(
                      text:
                          'Se metti un widget dentro Expanded, quel widget diventerà "elastico" e spingerà gli altri finché non avrà occupato ogni pixel disponibile.\n\n',
                    ),
                    const TextSpan(text: '💡 '),
                    _testoBold('Trucco Flex:', Colors.black),
                    const TextSpan(
                      text:
                          ' Se hai due Expanded nella stessa Row, puoi usare la proprietà ',
                    ),
                    _testoCodiceInline('flex: 2'),
                    const TextSpan(
                      text:
                          ' per far sì che uno occupi il doppio dello spazio dell\'altro.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Row(\n'
              '  children: [\n'
              '    Icon(Icons.label),\n'
              '    Expanded(child: Text("Questo testo può essere lunghissimo e andrà a capo correttamente invece di dare errore")), \n'
              '  ],\n'
              ')',
            ),

            const SizedBox(height: 30),

            _suggerimentoCreativo(
              '🚀 Prova a pensare: una tipica "chat bubble" è spesso una Row con un CircleAvatar e una Column (per nome e messaggio). '
              'Imparare a nidificare Row e Column è il segreto per creare ogni app esistente!',
            ),

            const SizedBox(height: 50),
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
        border: Border.all(color: Colors.indigo.shade200.withOpacity(0.3)),
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
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, color: Colors.indigo.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.indigo.shade900,
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
