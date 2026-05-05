import 'package:flutter/material.dart';

class LezioneAnatomia extends StatelessWidget {
  final String titoloLezione;

  const LezioneAnatomia({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titoloLezione), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SEZIONE 1: LA CLASSE ───────────────────────────────────────
            _paragrafo(
              '1. Definizione della Classe',
              'In Flutter, tutto è organizzato in classi. Una classe è come uno stampo: '
                  'definisce la forma e il comportamento di un oggetto.\n\n'
                  'Quando scrivi "class MiaPagina extends StatelessWidget", stai facendo tre cose insieme:\n\n'
                  '• class MiaPagina → crei un nuovo tipo di widget con nome univoco (sempre maiuscola iniziale: è una regola di Dart)\n\n'
                  '• extends → significa "eredita da". MiaPagina prende tutto ciò che StatelessWidget sa già fare, senza doverlo riscrivere\n\n'
                  '• StatelessWidget → è la classe "genitore" di Flutter che fornisce tutta la struttura base\n\n'
                  '💡 Analogia: pensa a StatelessWidget come al progetto base di una casa. '
                  'Con extends dici: "voglio quella struttura, ma ci aggiungo le mie stanze".',
            ),

            // ─── SEZIONE 2: STATELESS VS STATEFUL ──────────────────────────
            _paragrafo(
              '2. Stateless vs Stateful — La Scelta più Importante',
              'Questa è la decisione fondamentale che prendi per ogni widget.\n\n'
                  '━StatelessWidget Il Cartello Stradale ━\n'
                  'È immutabile dopo la creazione. Riceve dati dall\'esterno tramite il costruttore, '
                  'li mostra, e non li cambierà mai da solo. Flutter lo costruisce una volta sola.\n\n'
                  'Usalo quando: mostri testi, immagini, card con dati fissi, layout statici.\n\n'
                  '━━ StatefulWidget — Il Semaforo ━━\n'
                  'Ha una memoria interna chiamata State. Può cambiare aspetto in risposta a eventi '
                  '(tap, timer, dati dal server). Quando lo stato cambia, Flutter ridisegna '
                  'automaticamente solo quel widget.\n\n'
                  'Usalo quando: hai un contatore, un toggle on/off, un campo di testo, animazioni.\n\n'
                  '⚠️ Regola d\'oro: inizia SEMPRE con StatelessWidget. Passa a StatefulWidget '
                  'solo quando hai bisogno di memoria interna. Meno stato = app più veloce.',
            ),
            _esempioCodice(
              '// StatelessWidget — nessuna memoria interna\n'
              'class CardProdotto extends StatelessWidget {\n'
              '  final String nome;\n'
              '  final double prezzo;\n\n'
              '  const CardProdotto({\n'
              '    super.key,\n'
              '    required this.nome,\n'
              '    required this.prezzo,\n'
              '  });\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Text(\'\$nome — \$prezzo€\');\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 16),
            _esempioCodice(
              '// StatefulWidget — con memoria interna\n'
              'class Contatore extends StatefulWidget {\n'
              '  @override\n'
              '  State<Contatore> createState() => _ContatoreState();\n'
              '}\n\n'
              'class _ContatoreState extends State<Contatore> {\n'
              '  int _valore = 0; // questa è la "memoria"\n\n'
              '  void _incrementa() {\n'
              '    setState(() {   // dice a Flutter: "ridisegnami!"\n'
              '      _valore++;\n'
              '    });\n'
              '  }\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Text(\'\$_valore\');\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 25),

            // ─── SEZIONE 3: COSTRUTTORE, FINAL, CONST ──────────────────────
            _paragrafo(
              '3. Il Costruttore, "final" e "const"',
              'Il costruttore è il cancello d\'ingresso del widget: è lì che passano tutti i dati di cui ha bisogno.\n\n'
                  '━━ final — Dati in Sola Lettura ━━\n'
                  'Dichiarare una variabile final significa: "questo valore viene assegnato una volta '
                  'sola alla costruzione e non può più cambiare". Previene modifiche accidentali '
                  'e comunica chiaramente l\'intento al lettore del codice.\n\n'
                  '━━ const — Ottimizzazione di Performance ━━\n'
                  'Se aggiungi const al costruttore, dici a Flutter: "questo widget sarà sempre '
                  'identico, puoi riutilizzare la stessa istanza in memoria". È una '
                  'micro-ottimizzazione importante nei widget che si ripetono molto.\n\n'
                  '━━ required vs parametri opzionali ━━\n'
                  '• required this.titolo → obbligatorio, il codice non compila senza\n'
                  '• this.colore = Colors.blue → opzionale con valore di default\n'
                  '• this.sottotitolo → opzionale nullable (può essere null)',
            ),
            _esempioCodice(
              'class MioWidget extends StatelessWidget {\n'
              '  final String titolo;           // obbligatorio\n'
              '  final Color colore;            // obbligatorio\n'
              '  final String? sottotitolo;     // opzionale, può essere null\n\n'
              '  const MioWidget({\n'
              '    super.key,\n'
              '    required this.titolo,\n'
              '    required this.colore,\n'
              '    this.sottotitolo,             // non required = opzionale\n'
              '  });\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return Text(titolo);\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 25),

            // ─── SEZIONE 4: BUILDCONTEXT ────────────────────────────────────
            _paragrafo(
              '4. BuildContext — Il GPS del Widget',
              'Flutter costruisce la tua app come un albero di widget. '
                  'Ogni widget ha una posizione precisa in questo albero. '
                  'Il BuildContext è un riferimento a quella posizione.\n\n'
                  '━━ A cosa serve concretamente? ━━\n\n'
                  '• Navigazione tra pagine:\n'
                  '  Navigator.of(context).push(...)\n'
                  '  → context sa da dove stai navigando\n\n'
                  '• Accedere al tema dell\'app:\n'
                  '  Theme.of(context).colorScheme.primary\n'
                  '  → senza context non potresti sapere qual è il tema attivo\n\n'
                  '• Mostrare SnackBar, Dialog, BottomSheet:\n'
                  '  ScaffoldMessenger.of(context).showSnackBar(...)\n'
                  '  → Flutter usa context per trovare lo Scaffold più vicino nell\'albero\n\n'
                  '⚠️ L\'errore più comune: usare context in un metodo asincrono dopo un await. '
                  'Il widget potrebbe essere stato rimosso dall\'albero nel frattempo! '
                  'Controlla sempre "if (mounted)" prima di usare context dopo un\'operazione asincrona.',
            ),
            _esempioCodice(
              '// ❌ PERICOLOSO: context dopo await\n'
              'Future<void> caricaDati() async {\n'
              '  await Future.delayed(Duration(seconds: 2));\n'
              '  Navigator.of(context).push(...); // context potrebbe essere invalido!\n'
              '}\n\n'
              '// ✅ CORRETTO: controlla mounted prima\n'
              'Future<void> caricaDati() async {\n'
              '  await Future.delayed(Duration(seconds: 2));\n'
              '  if (!mounted) return; // il widget esiste ancora?\n'
              '  Navigator.of(context).push(...);\n'
              '}',
            ),
            const SizedBox(height: 25),

            // ─── SEZIONE 5: NESTING ─────────────────────────────────────────
            _paragrafo(
              '5. La Logica del Nesting — Scatole Cinesi',
              'Flutter non usa XML o HTML. Tutto è codice Dart annidato: ogni widget '
                  'contiene altri widget tramite child (un figlio solo) o children (lista di figli).\n\n'
                  '━━ Come leggere il codice Flutter ━━\n'
                  'Leggi dall\'esterno verso l\'interno. Il widget più esterno è il contenitore '
                  'principale, quelli interni sono i dettagli.\n\n'
                  '  Scaffold              → struttura della pagina\n'
                  '    └── Center          → centra il contenuto\n'
                  '         └── Padding    → aggiunge spazio interno\n'
                  '              └── Column → dispone in verticale\n'
                  '                   ├── Text("Titolo")\n'
                  '                   ├── SizedBox(height: 8)\n'
                  '                   └── Text("Sottotitolo")\n\n'
                  '━━ child vs children ━━\n'
                  '• child → 1 solo figlio (Center, Padding, Container, Expanded...)\n'
                  '• children → lista [] di figli (Column, Row, Stack, ListView...)\n\n'
                  '━━ I widget di layout essenziali ━━\n'
                  '• Column → dispone i figli in verticale ↕\n'
                  '• Row → dispone i figli in orizzontale ↔\n'
                  '• Stack → sovrappone i figli (come i layer di Photoshop)\n'
                  '• Expanded → occupa tutto lo spazio disponibile\n'
                  '• SizedBox → spazio vuoto di dimensioni precise\n'
                  '• Padding → margine interno\n'
                  '• Container → il widget tuttofare: colore, bordo, padding, dimensioni',
            ),
            _esempioCodice(
              'Scaffold(\n'
              '  body: Center(                    // 📍 centra\n'
              '    child: Padding(                // 📦 spazio interno\n'
              '      padding: EdgeInsets.all(16),\n'
              '      child: Column(               // 📋 verticale\n'
              '        children: [\n'
              '          Text(\'Titolo\'),          // 📝 testo 1\n'
              '          SizedBox(height: 8),     // ↕  spazio\n'
              '          Text(\'Sottotitolo\'),     // 📝 testo 2\n'
              '          ElevatedButton(\n'
              '            onPressed: () {},\n'
              '            child: Text(\'Clicca\'), // 🔘 bottone\n'
              '          ),\n'
              '        ],\n'
              '      ),\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),
            const SizedBox(height: 25),

            // ─── SEZIONE 6: SETSTATE ────────────────────────────────────────
            _paragrafo(
              '6. setState — Come Flutter "Ricorda" i Cambiamenti',
              'setState è il meccanismo con cui dici a Flutter: "qualcosa è cambiato, '
                  'ridisegna questo widget".\n\n'
                  '━━ Come funziona internamente? ━━\n'
                  'Quando chiami setState, Flutter mette il widget in una lista di widget '
                  '"sporchi" (dirty). Al prossimo frame (circa ogni 16ms a 60fps), Flutter '
                  'richiama il metodo build() solo per quei widget, generando una nuova '
                  'versione dell\'interfaccia.\n\n'
                  '━━ Regole fondamentali di setState ━━\n'
                  '• Modifica SEMPRE le variabili DENTRO la callback di setState, mai fuori\n'
                  '• Non chiamare setState dentro il metodo build (loop infinito!)\n'
                  '• Non usarlo per operazioni pesanti: setState deve essere velocissimo\n'
                  '• Chiama setState solo se lo stato è effettivamente cambiato\n\n'
                  '━━ Pattern corretto ━━\n'
                  'Separa sempre la logica dalla UI: scrivi metodi privati (con _ davanti '
                  'al nome) che gestiscono il cambiamento di stato, poi chiamali dall\'UI.',
            ),
            _esempioCodice(
              'class _MioState extends State<MioWidget> {\n'
              '  bool _isLoading = false;\n'
              '  List<String> _elementi = [];\n\n'
              '  // ✅ metodo separato che gestisce lo stato\n'
              '  Future<void> _caricaElementi() async {\n'
              '    setState(() => _isLoading = true);  // mostra spinner\n\n'
              '    final risultati = await miaApi.fetch();\n\n'
              '    setState(() {\n'
              '      _elementi = risultati;   // aggiorna dati\n'
              '      _isLoading = false;      // nasconde spinner\n'
              '    });\n'
              '  }\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    // ❌ MAI: setState(() {...}) dentro build!\n'
              '    return _isLoading\n'
              '        ? CircularProgressIndicator()\n'
              '        : ListView(children: _elementi.map(Text.new).toList());\n'
              '  }\n'
              '}',
            ),
            const SizedBox(height: 25),

            // ─── SEZIONE 7: WIDGET TREE ─────────────────────────────────────
            _paragrafo(
              '7. Il Widget Tree — L\'Albero della Vita di Flutter',
              'Flutter rappresenta tutta la tua app come un albero di widget. '
                  'Capire questa struttura è la chiave per debuggare e ottimizzare.\n\n'
                  '━━ I tre alberi di Flutter ━━\n'
                  'Flutter usa internamente tre alberi paralleli:\n\n'
                  '• Widget Tree → il "progetto" (quello che scrivi tu nel codice)\n'
                  '• Element Tree → il "cantiere" (Flutter tiene traccia di cosa esiste)\n'
                  '• Render Tree → il "risultato" (i pixel sullo schermo)\n\n'
                  'Come sviluppatore, lavori quasi sempre solo con il Widget Tree. '
                  'Gli altri due Flutter li gestisce da solo.\n\n'
                  '━━ Perché è importante? ━━\n'
                  'Flutter non ridisegna tutto lo schermo ad ogni setState. Confronta '
                  'il vecchio Widget Tree con il nuovo e ridisegna SOLO le parti cambiate. '
                  'Questo è perché Flutter è così performante.\n\n'
                  '━━ Come esplorarlo? ━━\n'
                  'Avvia l\'app con "flutter run", premi "D" nel terminale per aprire '
                  'DevTools, poi vai su "Widget Inspector". Vedrai il tuo albero in '
                  'tempo reale e potrai cliccare su ogni widget per vederne le proprietà.',
            ),
            _esempioCodice(
              '// Albero visuale di questa struttura:\n'
              '//\n'
              '// MaterialApp\n'
              '// └── Scaffold\n'
              '//     ├── AppBar\n'
              '//     │   └── Text("Titolo")\n'
              '//     └── Body: Column\n'
              '//         ├── Image.network(...)\n'
              '//         ├── Text("Descrizione")\n'
              '//         └── Row\n'
              '//             ├── ElevatedButton → Text("Annulla")\n'
              '//             └── ElevatedButton → Text("Conferma")\n\n'
              'MaterialApp(\n'
              '  home: Scaffold(\n'
              '    appBar: AppBar(title: Text(\'Titolo\')),\n'
              '    body: Column(\n'
              '      children: [\n'
              '        Image.network(\'https://esempio.com/img.jpg\'),\n'
              '        Text(\'Descrizione\'),\n'
              '        Row(\n'
              '          children: [\n'
              '            ElevatedButton(onPressed: () {}, child: Text(\'Annulla\')),\n'
              '            ElevatedButton(onPressed: () {}, child: Text(\'Conferma\')),\n'
              '          ],\n'
              '        ),\n'
              '      ],\n'
              '    ),\n'
              '  ),\n'
              ')',
            ),
            const SizedBox(height: 20),

            _alertSuggerimento(
              '🏋️ Esercizio: prendi qualsiasi pagina Flutter e disegnala su carta come albero. '
              'Parti dal widget più esterno e scendi verso l\'interno. '
              'Questo esercizio ti farà capire il codice degli altri 10 volte più velocemente!',
            ),
            const SizedBox(height: 16),
            _alertSuggerimento(
              '📁 Consiglio Pro: non scrivere tutto il codice in un unico file. '
              'Se una classe diventa troppo lunga (oltre ~150 righe), estrai i widget '
              'riutilizzabili nella cartella lib/widgets/. Un file = un\'unica responsabilità.',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI ──────────────────────────────────────────────────────

  // ─── COMPONENTI GRAFICI POTENZIATI ──────────────────────────────────────────

  Widget _paragrafo(String titolo, String testo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.teal.shade700,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  titolo.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            testo,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _esempioCodice(String codice) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Colore tipico di VS Code
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _cerchietto(Colors.red.shade400),
              const SizedBox(width: 6),
              _cerchietto(Colors.amber.shade400),
              const SizedBox(width: 6),
              _cerchietto(Colors.green.shade400),
              const Expanded(child: SizedBox()),
              const Icon(Icons.copy, color: Colors.grey, size: 16),
            ],
          ),
          const Divider(color: Colors.white10, height: 20),
          Text(
            codice,
            style: const TextStyle(
              color: Color(0xFF9CDCFE), // Colore azzurro variabili
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_rounded, color: Colors.amber.shade800, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
                height: 1.5,
                color: Colors.amber.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Piccolo aiuto grafico per l'header del codice
  Widget _cerchietto(Color colore) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: colore, shape: BoxShape.circle),
    );
  }
}
