import 'package:flutter/material.dart';

class LezioneProvider extends StatelessWidget {
  final String titoloLezione;

  const LezioneProvider({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor:
            Colors.indigo.shade900, // Colore "Enterprise" per State Management
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRODUZIONE ──────────────────────────────────────────────
            _cardLezione(
              titolo: '🏢 Il Magazzino Centrale',
              colore: Colors.indigo.shade800,
              icona: Icons.hub_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fino ad ora abbiamo passato i dati come un "passaparola": da padre a figlio, a nipote. Con Provider cambiamo tutto.\n',
                    style: _stileTestoBase(),
                  ),
                  Text(
                    'Immagina un magazzino centrale esterno all\'albero dei widget. Ogni widget, non importa quanto sia profondo, può "collegarsi" direttamente al magazzino per prendere o cambiare i dati, senza disturbare i genitori.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 1: I 3 PILASTRI ─────────────────────────────────────
            _cardLezione(
              titolo: '1. I Tre Protagonisti',
              colore: Colors.deepPurple.shade700,
              icona: Icons.groups_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _elementoLista(
                    'ChangeNotifier',
                    'La classe che contiene i dati e avvisa quando cambiano (usa `notifyListeners()`).',
                  ),
                  _elementoLista(
                    'ChangeNotifierProvider',
                    'Il widget "distributore" che mette il magazzino a disposizione di una parte dell\'app.',
                  ),
                  _elementoLista(
                    'Consumer / context.watch',
                    'I widget "clienti" che leggono i dati e si ricostruiscono quando il magazzino li avvisa.',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 2: CREARE IL MAGAZZINO ──────────────────────────────
            _cardLezione(
              titolo: '2. Definire il Dato (ChangeNotifier)',
              colore: Colors.blue.shade800,
              icona: Icons.inventory_2_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creiamo una classe che estende `ChangeNotifier`. Qui dentro mettiamo la logica che prima stava nel setState.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'class CounterProvider extends ChangeNotifier {\n'
                    '  int _count = 0;\n'
                    '  int get count => _count;\n\n'
                    '  void incrementa() {\n'
                    '    _count++;\n'
                    '    notifyListeners(); // 📢 "Ehi widget, aggiornatevi!"\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 3: CONSUMARE I DATI ────────────────────────────────
            _cardLezione(
              titolo: '3. Leggere i Dati (Consumer)',
              colore: Colors.green.shade800,
              icona: Icons.visibility_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per usare i dati, non passiamo più nulla nel costruttore. Usiamo `context.watch` per restare in ascolto o `context.read` per chiamare funzioni.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '// In qualunque widget profondo:\n'
                    'final counter = context.watch<CounterProvider>();\n\n'
                    'return Text("Valore: \${counter.count}");',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'In questo modo, solo il widget che "guarda" il dato si ricostruirà. Il resto dell\'app rimane fermo, risparmiando energia e memoria.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 4: PERCHÉ È FONDAMENTALE? ──────────────────────────
            _cardLezione(
              titolo: '4. Smettere di Impazzire',
              colore: Colors.orange.shade900,
              icona: Icons.auto_awesome_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Con Provider eliminiamo il codice inutile:\n',
                    style: _stileTestoBase(),
                  ),
                  _elementoLista(
                    'Basta costruttori infiniti',
                    'I widget intermedi non devono più trasportare dati che non usano.',
                  ),
                  _elementoLista(
                    'Logica separata',
                    'I calcoli stanno nel Provider, il widget si occupa solo della grafica.',
                  ),
                  _elementoLista(
                    'Performance',
                    'Aggiornamenti mirati solo dove serve.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _suggerimentoCreativo(
              '🧭 Prossima fermata: Riverpod. È basato sugli stessi concetti di Provider, '
              'ma risolve alcuni limiti tecnici rendendo l\'app ancora più sicura e facile da testare.',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI DI SUPPORTO (COPIA TUTTO QUESTO) ──────────────────

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
