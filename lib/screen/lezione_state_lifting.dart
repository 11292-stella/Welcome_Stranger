import 'package:flutter/material.dart';

class LezioneStateLifting extends StatelessWidget {
  final String titoloLezione;

  const LezioneStateLifting({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor: Colors.deepOrange.shade900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRODUZIONE COMPLETA ──────────────────────────────────────
            _cardLezione(
              titolo: '🧠 Di cosa si tratta?',
              colore: Colors.blueGrey.shade800,
              icona: Icons.psychology_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lo stato (State) è la "memoria viva" della tua app. È qualsiasi dato che può cambiare nel tempo e che, quando cambia, deve aggiornare l\'interfaccia.\n',
                    style: _stileTestoBase(),
                  ),
                  _elementoLista(
                    'Esempi reali',
                    'Il numero di like, un checkbox spuntato, il testo digitato, il carrello della spesa o un indicatore di caricamento.',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Il "sollevamento dello stato" (State Lifting) è la tecnica con cui gestisci lo stato quando più widget separati devono condividere o modificare gli stessi dati.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 1: STATO LOCALE VS CONDIVISO ────────────────────────
            _cardLezione(
              titolo: '1. I Due Tipi di Stato',
              colore: Colors.teal.shade700,
              icona: Icons.account_tree_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _testoBold('━━ Stato Locale ━━\n', Colors.teal.shade900),
                  Text(
                    'Vive DENTRO un singolo widget. Nessun altro widget ne sa nulla. Si usa un StatefulWidget e setState. Esempi: un\'animazione interna, se un menu a tendina è aperto o chiuso.\n',
                    style: _stileTestoBase(),
                  ),
                  _testoBold('━━ Stato Condiviso ━━\n', Colors.teal.shade900),
                  Text(
                    'Deve essere accessibile a più widget, spesso in punti diversi dell\'albero. Qui entra in gioco il State Lifting. Esempi: l\'utente loggato, il tema (dark/light), i prodotti nel carrello.\n',
                    style: _stileTestoBase(),
                  ),
                  _suggerimentoCreativo(
                    '💡 Regola: tieni lo stato il più vicino possibile ai widget che lo usano. Sollevalo SOLO quando necessario.',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 2: IL PROBLEMA DEI FRATELLI ────────────────────────
            _cardLezione(
              titolo: '2. Il Problema: Widget Fratelli',
              colore: Colors.red.shade800,
              icona: Icons.error_outline_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Immagina: \n• Widget A (ha un bottone +)\n• WidgetB (mostra il totale)\n\n'
                    'WidgetA e WidgetB sono fratelli. In Flutter i dati scorrono solo dall\'alto verso il basso (genitore -> figli). '
                    'I fratelli non possono parlarsi lateralmente. Se il contatore è dentro WidgetA, WidgetB è cieco.\n',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '// WidgetB non saprà mai cosa succede in WidgetA!',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 3: LA SOLUZIONE TECNICA ────────────────────────────
            _cardLezione(
              titolo: '3. La Soluzione: Sollevare lo Stato',
              colore: Colors.green.shade800,
              icona: Icons.unfold_less_double_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spostiamo la variabile nel genitore comune (es. Pagina). Il flusso diventa:\n',
                    style: _stileTestoBase(),
                  ),
                  _elementoLista(
                    'Il Genitore',
                    'mantiene la variabile e la funzione setState.',
                  ),
                  _elementoLista(
                    'WidgetA (Figlio)',
                    'riceve dal padre una "Callback" (una funzione) per incrementare.',
                  ),
                  _elementoLista(
                    'WidgetB (Figlio)',
                    'riceve dal padre il valore corrente da mostrare.',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'I figli diventano StatelessWidget: non pensano più, ricevono solo dati e istruzioni dal padre.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            _boxCodice(
              '// Il genitore passa la funzione al figlio\n'
              'WidgetA(onIncrementa: () => setState(() => _cont++)),\n'
              '// Il genitore passa il valore al figlio\n'
              'WidgetB(contatore: _cont),',
            ),

            // ─── SEZIONE 4: CALLBACK E CAMPANELLI ───────────────────────────
            _cardLezione(
              titolo: '4. Callback: Parlare verso l\'alto',
              colore: Colors.blue.shade800,
              icona: Icons.call_made_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'È come un campanello: il genitore installa il campanello (funzione), il figlio lo suona. Il genitore decide cosa fare al suono.\n',
                    style: _stileTestoBase(),
                  ),
                  _testoBold('Tipi di Callback:\n', Colors.blue.shade900),
                  _elementoLista('VoidCallback', 'Niente dati (es. un click).'),
                  _elementoLista(
                    'ValueChanged<T>',
                    'Passa un dato (es. il testo di un TextField).',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 5: IL PERICOLO PROP DRILLING ───────────────────────
            _cardLezione(
              titolo: '5. Il Problema del Prop Drilling',
              colore: Colors.orange.shade800,
              icona: Icons.warning_amber_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Se l\'albero è profondo (Padre -> Figlio -> Nipote -> Pronipote), passare dati a mano attraverso tutti i livelli intermedi che NON li usano è un errore chiamato "Prop Drilling".\n',
                    style: _stileTestoBase(),
                  ),
                  Text(
                    'Quando senti la fatica di passare un dato per 4 o 5 costruttori, è il segnale che devi usare Provider, Riverpod o Bloc.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            // ─── ESEMPIO REALE CARRELLO ─────────────────────────────────────
            _cardLezione(
              titolo: '6. Esempio: Carrello Spesa',
              colore: Colors.purple.shade800,
              icona: Icons.shopping_cart_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Il Padre gestisce la List carrello.\n'
                    '2. Il Figlio "Lista" mostra i prodotti.\n'
                    '3. Il Figlio "IconaCarrello" mostra il numero (carrello.length).\n'
                    '4. Al click su "Aggiungi", la lista chiama la funzione del padre, il padre aggiorna la lista e l\'icona si aggiorna automaticamente.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _alertSuggerimento(
              '🔑 Regola d\'oro: "Chi possiede i dati, possiede lo stato."',
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
