import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:nuova_app/theme/horror_theme.dart'; // Assicurati che il percorso sia corretto

class LezioneStruttura extends StatelessWidget {
  final String titoloLezione;

  const LezioneStruttura({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    // Recupero il tema horror esteso se presente, altrimenti uso fallback
    final horror = Theme.of(context).extension<HorrorTheme>();
    final neonIndigo = const Color(0xFF6366F1);
    final neonCyan = const Color(0xFF00E5FF);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style:
              horror?.horrorTitle?.copyWith(fontSize: 20) ??
              const TextStyle(
                color: Color(0xFF00E5FF),
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. MATERIALAPP ─────────────────────────────────────────────
            _cardLezione(
              titolo: '1. MaterialApp: La Fondamenta',
              colore: neonIndigo,
              icona: Icons.home_work_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'È la coscienza centrale della tua app. Senza di essa, i tuoi widget vagano nel vuoto senza regole.',
                    style: _stileTestoAcademy(),
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Ruolo',
                    'Gestisce il tema globale e le rotte della navigazione.',
                    neonIndigo,
                  ),
                  _elementoLista(
                    'Metafora',
                    'Immaginala come l\'intero sistema nervoso di una casa.',
                    neonIndigo,
                  ),
                ],
              ),
            ),

            // ─── 2. SCAFFOLD ────────────────────────────────────────────────
            _cardLezione(
              titolo: '2. Scaffold: L\'Impalcatura',
              colore: Colors.blueAccent,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ogni nuova dimensione (pagina) richiede uno Scaffold. È la struttura che impedisce al codice di collassare su se stesso.',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    'return Scaffold(\n'
                    '  appBar: AppBar(title: Text("Rituale")),\n'
                    '  body: Center(child: Text("Contenuto")),\n'
                    '  floatingActionButton: FloatingActionButton(...),\n'
                    ');',
                  ),
                  _alertSuggerimento(
                    '⚠ AVVERTENZA: Senza lo Scaffold, i tuoi widget di testo appariranno come spettri rossi e gialli senza stile.',
                  ),
                ],
              ),
            ),

            // ─── 3. ORGANIZZAZIONE CARTELLE ─────────────────────────────────
            _cardLezione(
              titolo: '3. Modularità: lib/ directory',
              colore: Colors.tealAccent,
              icona: Icons.folder_copy_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dividere il codice non è un optional. È l\'unico modo per non perdersi nei labirinti di file da 2000 righe.',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    'lib/\n'
                    ' ├── main.dart       # Il Cuore\n'
                    ' ├── screens/        # Le Dimensioni (Pagine)\n'
                    ' ├── widgets/        # Le Parti (Componenti)\n'
                    ' └── models/         # I Dati (Anima)',
                  ),
                ],
              ),
            ),

            // ─── 4. ROW & COLUMN ────────────────────────────────────────────
            _cardLezione(
              titolo: '4. Layout: Row e Column',
              colore: Colors.deepPurpleAccent,
              icona: Icons.view_quilt_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I contenitori multi-figlio governano lo spazio. Decidono come le entità grafiche devono allinearsi.',
                    style: _stileTestoAcademy(),
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Column',
                    'Dispone i widget verticalmente.',
                    Colors.deepPurpleAccent,
                  ),
                  _elementoLista(
                    'Row',
                    'Dispone i widget orizzontalmente.',
                    Colors.deepPurpleAccent,
                  ),

                  const SizedBox(height: 15),
                  _testoBold('Dimostrazione Row:', Colors.white),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepPurpleAccent.withOpacity(0.3),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.visibility, color: Colors.deepPurpleAccent),
                        Text(
                          'Widget A',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Icon(Icons.visibility, color: Colors.deepPurpleAccent),
                        Text(
                          'Widget B',
                          style: TextStyle(color: Colors.white70),
                        ),
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

  //─── COMPONENTI GRAFICI HORROR ──────────────────

  TextStyle _stileTestoAcademy() =>
      const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6);

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
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colore.withOpacity(0.4)),
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
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icona,
                  color: colore,
                  size: 24,
                  shadows: [Shadow(color: colore, blurRadius: 10)],
                ),
                const SizedBox(width: 15),
                Text(
                  titolo,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: colore,
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
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _elementoLista(String termine, String descrizione, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: colore, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: _stileTestoAcademy(),
                children: [
                  TextSpan(
                    text: '$termine: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colore.withOpacity(0.8),
                    ),
                  ),
                  TextSpan(text: descrizione),
                ],
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
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.redAccent,
          fontStyle: FontStyle.italic,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _testoBold(String testo, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
}
