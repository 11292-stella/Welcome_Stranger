import 'package:flutter/material.dart';

class LezioneRiverpodIntro extends StatelessWidget {
  final String titoloLezione;

  const LezioneRiverpodIntro({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    // Palette Riverpod: Cyan & Deep Blue
    const Color riverpodCyan = Color(0xFF00ACC1);
    const Color riverpodDark = Color(0xFF006064);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E12), // Dark Mode professionale
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 13,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: riverpodDark,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── IL CAMBIO DI PARADIGMA ─────────────────────────────────────
            _cardLezione(
              titolo: 'Oltre i limiti del Context',
              colore: riverpodCyan,
              icona: Icons.hub_outlined,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In Provider, l\'accesso ai dati falliva se cercavi di leggerli fuori dall\'albero dei widget. Riverpod rende i Provider indipendenti: puoi usarli ovunque.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildConfronto(
                    vecchio: 'Provider: Dipende dalla gerarchia dei widget.',
                    nuovo:
                        'Riverpod: Variabili globali ma gestite in modo sicuro.',
                  ),
                ],
              ),
            ),

            // ─── 1. IL CONTENITORE (PROVIDERSCOPE) ──────────────────────────
            _cardLezione(
              titolo: '1. ProviderScope: Il Grande Reset',
              colore: Colors.blueGrey,
              icona: Icons.blur_on_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A differenza di Provider, dove dovevi aggiungere decine di widget "Provider" uno sopra l\'altro, in Riverpod ne serve solo UNO alla radice.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'void main() {\n'
                    '  runApp(\n'
                    '    ProviderScope( // 👈 Memorizza tutti i Provider dell\'app\n'
                    '      child: MyApp(),\n'
                    '    ),\n'
                    '  );\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 2. DICHIARAZIONE GLOBALE ────────────────────────────────────
            _cardLezione(
              titolo: '2. Provider come Variabili Globali',
              colore: Colors.teal,
              icona: Icons.launch_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I provider si dichiarano fuori da ogni classe. Questo li rende accessibili da qualsiasi file, eliminando il bisogno di passarli nel costruttore.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '// Dichiarazione in cima al file (globale)\n'
                    'final themeProvider = Provider<bool>((ref) {\n'
                    '  return true; // Ritorna il tema scuro o chiaro\n'
                    '});',
                  ),
                  _alertSuggerimento(
                    'Non preoccuparti della parola "globale": Riverpod assicura che il dato rimanga privato e protetto dentro il ProviderScope.',
                  ),
                ],
              ),
            ),

            // ─── 3. IL NUOVO BUILD (CONSUMERWIDGET) ──────────────────────────
            _cardLezione(
              titolo: '3. ConsumerWidget e WidgetRef',
              colore: Colors.indigo,
              icona: Icons.switch_access_shortcut_add_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per interagire con i provider, i tuoi widget cambiano identità. Lo Stateless diventa ConsumerWidget e riceve il WidgetRef (chiamato solitamente "ref").',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 10),
                  _buildPuntoChiave(
                    titolo: 'WidgetRef ref',
                    desc:
                        'È il ponte tra il widget e i dati esterni. Senza "ref", il widget non può toccare i provider.',
                    colore: Colors.indigoAccent,
                  ),
                  _boxCodice(
                    'class HomeView extends ConsumerWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context, WidgetRef ref) {\n'
                    '    final isDark = ref.watch(themeProvider);\n'
                    '    return Scaffold( ... );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 4. WATCH VS READ ───────────────────────────────────────────
            _cardLezione(
              titolo: '4. ref.watch vs ref.read',
              colore: Colors.orange.shade800,
              icona: Icons.visibility_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegenda(
                    testo: 'ref.watch',
                    desc:
                        'Reattivo. Se il dato cambia, il widget si ridisegna. Si usa SOLO nel build.',
                    colore: Colors.greenAccent,
                  ),
                  const SizedBox(height: 8),
                  _buildLegenda(
                    testo: 'ref.read',
                    desc:
                        'Istantaneo. Legge il dato una volta sola. Si usa SOLO dentro i bottoni (onPressed).',
                    colore: Colors.orangeAccent,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ─── TEMPLATE: RIVERPOD COMPLETO ─────────────────────
            _cardLezione(
              titolo: 'Template: Riverpod Completo',
              colore: riverpodCyan,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Template pronto all\'uso. Quattro file, quattro responsabilità — ogni pezzo fa una cosa sola.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Step 1 — main.dart: ProviderScope',
                    desc:
                        'Un solo wrapper alla radice. Niente stack di provider come in Provider.',
                    colore: Colors.blueGrey,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 2 — provider file: dichiarazione globale',
                    desc:
                        'I provider vivono fuori da ogni classe, accessibili da qualsiasi file.',
                    colore: Colors.teal,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 3 — ConsumerWidget: lettura reattiva',
                    desc:
                        'ref.watch nel build() — il widget si aggiorna da solo quando il dato cambia.',
                    colore: Colors.indigo,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 4 — Bottone: azione puntuale',
                    desc:
                        'ref.read negli onPressed() — legge o chiama funzioni senza ricostruire il widget.',
                    colore: Colors.orange.shade800,
                  ),
                  _boxCodice(
                    '// ── STEP 1: main.dart ───────────────────────────────\n'
                    'void main() {\n'
                    '  runApp(\n'
                    '    ProviderScope(        // uno solo, alla radice\n'
                    '      child: MyApp(),\n'
                    '    ),\n'
                    '  );\n'
                    '}\n\n'
                    '// ── STEP 2: mio_provider.dart (file separato) ────────\n'
                    '// Provider semplice — valore fisso calcolato una volta\n'
                    'final salutoProvider = Provider<String>((ref) {\n'
                    '  return "Ciao, Mondo!";\n'
                    '});\n\n'
                    '// StateProvider — valore primitivo che può cambiare\n'
                    'final contatoreProvider = StateProvider<int>((ref) => 0);\n\n'
                    '// StateNotifierProvider — logica complessa\n'
                    'class MioNotifier extends StateNotifier<List<String>> {\n'
                    '  MioNotifier() : super([]);\n\n'
                    '  void aggiungi(String elemento) {\n'
                    '    state = [...state, elemento]; // immutabile: sempre copia\n'
                    '  }\n\n'
                    '  void rimuovi(String elemento) {\n'
                    '    state = state.where((e) => e != elemento).toList();\n'
                    '  }\n'
                    '}\n\n'
                    'final listaProvider =\n'
                    '    StateNotifierProvider<MioNotifier, List<String>>(\n'
                    '        (ref) => MioNotifier());\n\n'
                    '// ── STEP 3: Widget che legge ─────────────────────────\n'
                    'class MioWidget extends ConsumerWidget {\n'
                    '  const MioWidget({super.key});\n\n'
                    '  @override\n'
                    '  Widget build(BuildContext context, WidgetRef ref) {\n'
                    '    final saluto = ref.watch(salutoProvider);      // stringa fissa\n'
                    '    final contatore = ref.watch(contatoreProvider); // si aggiorna\n'
                    '    final lista = ref.watch(listaProvider);         // lista reattiva\n\n'
                    '    return Column(\n'
                    '      children: [\n'
                    '        Text(saluto),\n'
                    '        Text("Contatore: " + contatore.toString()),\n'
                    '        ...lista.map((e) => Text(e)),\n\n'
                    '        // ── STEP 4: Azioni con ref.read ────────────\n'
                    '        ElevatedButton(\n'
                    '          onPressed: () =>\n'
                    '            ref.read(contatoreProvider.notifier).state++,\n'
                    '          child: const Text("Incrementa"),\n'
                    '        ),\n'
                    '        ElevatedButton(\n'
                    '          onPressed: () =>\n'
                    '            ref.read(listaProvider.notifier).aggiungi("Nuovo"),\n'
                    '          child: const Text("Aggiungi"),\n'
                    '        ),\n'
                    '      ],\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            _buildConfronto(
              vecchio:
                  'ref.watch in un onPressed — ricostruisce il widget ad ogni tap inutilmente.',
              nuovo:
                  'ref.read in onPressed, ref.watch nel build — ognuno al suo posto.',
            ),
            const SizedBox(height: 30),
            _suggerimentoCreativo(
              '🌊 Pro-tip: Riverpod permette di creare provider che dipendono da altri provider (Provider Componibili) semplicemente usando ref.watch all\'interno della dichiarazione!',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI DI SUPPORTO ────────────────────────────────────────

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
        color: const Color(0xFF1E262C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colore.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 24),
                const SizedBox(width: 12),
                Text(
                  titolo.toUpperCase(),
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 0.5,
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

  Widget _buildPuntoChiave({
    required String titolo,
    required String desc,
    required Color colore,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titolo,
            style: TextStyle(
              color: colore,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            desc,
            style: const TextStyle(color: Colors.white60, fontSize: 12.5),
          ),
        ],
      ),
    );
  }

  Widget _buildConfronto({required String vecchio, required String nuovo}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '❌ $vecchio',
            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            '✅ $nuovo',
            style: const TextStyle(color: Colors.greenAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _boxCodice(String codice) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildLegenda({
    required String testo,
    required String desc,
    required Color colore,
  }) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13, color: Colors.white70),
        children: [
          TextSpan(
            text: '$testo: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: colore),
          ),
          TextSpan(text: desc),
        ],
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyan.shade900.withOpacity(0.3), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.cyanAccent,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);
}
