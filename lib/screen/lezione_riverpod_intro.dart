import 'package:flutter/material.dart';

class LezioneRiverpodIntro extends StatelessWidget {
  final String titoloLezione;

  const LezioneRiverpodIntro({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor: Colors.cyan.shade900, // Colore distintivo per Riverpod
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRODUZIONE: PERCHÉ RIVERPOD? ─────────────────────────────
            _cardLezione(
              titolo: '🌊 Oltre il Provider',
              colore: Colors.cyan.shade800,
              icona: Icons.waves_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Riverpod è scritto dallo stesso autore di Provider, ma risolve tutti i suoi limiti. La parola stessa è l\'anagramma di "Provider".\n',
                    style: _stileTestoBase(),
                  ),
                  _elementoLista(
                    'Niente Context',
                    'Puoi accedere ai dati anche fuori dai widget (es. in una classe di logica).',
                  ),
                  _elementoLista(
                    'Sicurezza',
                    'Gli errori vengono scoperti mentre scrivi il codice, non mentre l\'app gira.',
                  ),
                  _elementoLista(
                    'Globale ma Protetto',
                    'I dati sono dichiarati globalmente, ma sono accessibili solo a chi ha il "permesso".',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 1: IL PUNTO DI PARTENZA ─────────────────────────────
            _cardLezione(
              titolo: '1. ProviderScope: La Sorgente',
              colore: Colors.blueGrey.shade700,
              icona: Icons.settings_input_antenna_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prima di tutto, dobbiamo "immergere" tutta la nostra app in un `ProviderScope`. È lui che gestisce lo stato di tutti i nostri dati.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'void main() {\n'
                    '  runApp(\n'
                    '    ProviderScope( // 👈 Fondamentale!\n'
                    '      child: MyApp(),\n'
                    '    ),\n'
                    '  );\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 2: DICHIARARE UN PROVIDER ───────────────────────────
            _cardLezione(
              titolo: '2. Creare un Provider',
              colore: Colors.teal.shade700,
              icona: Icons.add_box_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In Riverpod, i Provider sono variabili **final** e **globali**. Non aver paura: non sporcano il codice perché sono immutabili.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '// Un semplice provider di sola lettura\n'
                    'final salutoProvider = Provider((ref) {\n'
                    '  return "Ciao da Riverpod!";\n'
                    '});',
                  ),
                  _testoBold('\nCos\'è quel "ref"?', Colors.teal.shade900),
                  Text(
                    'È la tua "chiave inglese". Serve per parlare con gli altri provider. Se un provider ha bisogno di un altro dato, usa `ref.watch`.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 3: CONSUMERWIDGET ──────────────────────────────────
            _cardLezione(
              titolo: '3. Leggere i Dati (ConsumerWidget)',
              colore: Colors.indigo.shade700,
              icona: Icons.auto_fix_high_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per leggere i dati, il tuo widget non deve più estendere `StatelessWidget`, ma `ConsumerWidget`. Questo ti regala un nuovo parametro nel build: il `WidgetRef`.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'class MioWidget extends ConsumerWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context, WidgetRef ref) {\n'
                    '    // 🎯 Leggiamo il dato\n'
                    '    final messaggio = ref.watch(salutoProvider);\n\n'
                    '    return Text(messaggio);\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 4: REGOLE D'ORO ─────────────────────────────────────
            _cardLezione(
              titolo: '4. ref.watch vs ref.read',
              colore: Colors.orange.shade800,
              icona: Icons.rule_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _elementoLista(
                    'ref.watch',
                    'Si usa nel build. Se il dato cambia, il widget si ricostruisce. È quello che userai nel 90% dei casi.',
                  ),
                  _elementoLista(
                    'ref.read',
                    'Si usa dentro le funzioni (es. `onPressed`). Serve per "eseguire un\'azione" senza stare a guardare se il dato cambia.',
                  ),
                  _alertSuggerimento(
                    '💡 Regola: Non usare mai ref.watch dentro un pulsante e non usare mai ref.read dentro il build!',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _suggerimentoCreativo(
              '🧠 Ricorda: Riverpod non è magia, è solo un modo per dire a Flutter: '
              '"Tieni questo dato lì fuori, e avvisami solo quando quel pezzetto specifico cambia".',
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
