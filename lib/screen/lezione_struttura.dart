import 'package:flutter/material.dart';

class LezioneStruttura extends StatelessWidget {
  final String titoloLezione;

  const LezioneStruttura({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. MATERIALAPP ─────────────────────────────────────────────
            _cardLezione(
              titolo: '1. MaterialApp: La Fondamenta',
              colore: Colors.indigo.shade700,
              icona: Icons.home_work_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'È il widget radice della tua app. Si configura una sola volta nel main.dart.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Ruolo',
                    'Gestisce il tema globale (colori, font) e le rotte (navigazione).',
                  ),
                  _elementoLista(
                    'Metafora',
                    'Immaginala come l\'intero sistema elettrico e idraulico di una casa.',
                  ),
                ],
              ),
            ),

            // ─── 2. SCAFFOLD ────────────────────────────────────────────────
            _cardLezione(
              titolo: '2. Scaffold: L\'Impalcatura',
              colore: Colors.blue.shade700,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ogni nuova pagina che crei deve poggiare su uno Scaffold. Ti fornisce la struttura standard delle app moderne.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'return Scaffold(\n'
                    '  appBar: AppBar(title: Text("Titolo")),\n'
                    '  body: Center(child: Text("Contenuto")),\n'
                    '  floatingActionButton: FloatingActionButton(...),\n'
                    ');',
                  ),
                  _alertSuggerimento(
                    'Regola d\'oro: Senza lo Scaffold, i widget di testo apparirebbero brutti, senza stile e con linee rosse sotto.',
                  ),
                ],
              ),
            ),

            // ─── 3. ORGANIZZAZIONE CARTELLE ─────────────────────────────────
            _cardLezione(
              titolo: '3. Modularità: lib/ directory',
              colore: Colors.teal.shade700,
              icona: Icons.folder_copy_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perché dividere il codice? Per trovare le cose in 2 secondi invece di scorrere 2000 righe di file.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'lib/\n'
                    ' ├── main.dart       # Punto di ingresso\n'
                    ' ├── screens/        # Pagine intere (Scaffold)\n'
                    ' ├── widgets/        # Pezzi riutilizzabili\n'
                    ' └── models/         # Classi per i dati',
                  ),
                  _suggerimentoCreativo(
                    'Se un pezzo di codice lo usi in più di due posti, portalo nella cartella widgets/.',
                  ),
                ],
              ),
            ),

            // ─── 4. ROW & COLUMN ────────────────────────────────────────────
            _cardLezione(
              titolo: '4. Layout: Row e Column',
              colore: Colors.deepPurple.shade700,
              icona: Icons.view_quilt_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il body dello Scaffold accetta un solo figlio. Per metterne più di uno, devi usare dei contenitori multi-figlio.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Column',
                    'Dispone i widget dall\'alto verso il basso (verticale).',
                  ),
                  _elementoLista(
                    'Row',
                    'Dispone i widget da sinistra a destra (orizzontale).',
                  ),

                  // Esempio Visivo Row
                  const SizedBox(height: 15),
                  _testoBold('Esempio Row visiva:', Colors.black87),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple.shade100),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text('Widget 1'),
                        Icon(Icons.star, color: Colors.amber),
                        Text('Widget 2'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  //─── COMPONENTI GRAFICI DI SUPPORTO  ──────────────────

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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF232931),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepOrange.shade200.withOpacity(0.3)),
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
        color: Colors.deepOrange.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.deepOrange.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.deepOrange.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.deepOrange.shade900,
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

  Widget _alertSuggerimento(String testo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Color(0xFF37474F), fontSize: 15, height: 1.7);

  // Questo mancava ed è fondamentale per i titoli in grassetto colorati
  Widget _testoBold(String testo, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        testo,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colore,
          fontSize: 16,
        ),
      ),
    );
  }

  // Questo mancava: serve per creare i punti elenco con termine e descrizione
  Widget _elementoLista(String termine, String descrizione) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: _stileTestoBase(),
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
        ),
      ),
    );
  }

  // Questo serve per evidenziare il codice inline tipo `setState`
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
}
