import 'package:flutter/material.dart';

class LezioneProvider extends StatelessWidget {
  final String titoloLezione;

  const LezioneProvider({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color providerIndigo = Color(0xFF3F51B5);
    const Color logicPurple = Color(0xFF673AB7);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Dark mode per concentrarsi
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: providerIndigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── IL CONCETTO: ADDIO AL PASSAPAROLA ──────────────────────────
            _cardLezione(
              titolo: 'Il Problema che Provider risolve',
              colore: providerIndigo,
              icona: Icons.alt_route_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Senza Provider, se l\'ultimo widget in fondo alla pagina ha bisogno di un dato che sta in cima, devi passarlo tramite tutti i widget intermedi, anche se a loro non serve.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _alertSuggerimento(
                    'Provider permette a un widget di "saltare la fila" e chiedere il dato direttamente alla sorgente usando il context.',
                  ),
                ],
              ),
            ),

            // ─── PILASTRO 1: LA CLASSE DATI ─────────────────────────────────
            _cardLezione(
              titolo: '1. Il Magazziniere (ChangeNotifier)',
              colore: logicPurple,
              icona: Icons.psychology_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'È una classe normale che contiene i tuoi dati e le funzioni per modificarli. La "magia" è il comando notifyListeners().',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'class UserProvider extends ChangeNotifier {\n'
                    '  String name = "Ospite";\n\n'
                    '  void login(String newName) {\n'
                    '    name = newName;\n'
                    '    notifyListeners(); // 📢 Grida: "I DATI SONO CAMBIATI!"\n'
                    '  }\n'
                    '}',
                  ),
                  Text(
                    'Senza notifyListeners(), i widget non sapranno mai che devono ridisegnare lo schermo.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            // ─── PILASTRO 2: L'INIEZIONE ────────────────────────────────────
            _cardLezione(
              titolo: '2.(ChangeNotifierProvider)',
              colore: Colors.blue,
              icona: Icons.settings_input_antenna_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Devi "iniettare" il provider in cima al tuo albero. Solitamente si fa nel main.dart sopra il widget MaterialApp.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'void main() {\n'
                    '  runApp(\n'
                    '    ChangeNotifierProvider(\n'
                    '      create: (context) => UserProvider(),\n'
                    '      child: const MyApp(),\n'
                    '    ),\n'
                    '  );\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── PILASTRO 3: L'ASCOLTO ──────────────────────────────────────
            _cardLezione(
              titolo: '3. Il Cliente (watch vs read)',
              colore: Colors.green,
              icona: Icons.hearing_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ci sono due modi per interagire con il magazzino dati dall\'interno di un widget:',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    titolo: 'context.watch<T>()',
                    desc:
                        'Usalo per LEGGERE i dati. Se il dato cambia, il widget si ricostruisce in automatico.',
                    colore: Colors.green,
                  ),
                  _buildPuntoChiave(
                    titolo: 'context.read<T>()',
                    desc:
                        'Usalo per chiamare FUNZIONI (es. dentro un bottone). Non fa ricostruire il widget.',
                    colore: Colors.orange,
                  ),
                  _boxCodice(
                    '// Esempio in un widget:\n'
                    'final user = context.watch<UserProvider>();\n'
                    'return Text("Ciao \${user.name}");',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ─── TEMPLATE: PROVIDER COMPLETO ─────────────────────
            _cardLezione(
              titolo: 'Template: Provider Completo',
              colore: logicPurple,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Template pronto all\'uso. Segui i 4 step in ordine — ogni pezzo ha il suo posto preciso.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Step 1 — Crea il ChangeNotifier',
                    desc:
                        'Una classe con i dati e le funzioni. Ogni modifica termina con notifyListeners().',
                    colore: logicPurple,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 2 — Inietta nel main.dart',
                    desc:
                        'Avvolgi MaterialApp con ChangeNotifierProvider così tutti i widget sotto possono accedervi.',
                    colore: Colors.blue,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 3 — Leggi con watch',
                    desc:
                        'Nei widget che mostrano dati usa context.watch — si aggiorna automaticamente.',
                    colore: Colors.green,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 4 — Agisci con read',
                    desc:
                        'Nei bottoni usa context.read — chiama funzioni senza innescare ricostruzioni inutili.',
                    colore: Colors.orange,
                  ),
                  _boxCodice(
                    '// ── STEP 1: Il tuo ChangeNotifier ───────────────────\n'
                    'class MioProvider extends ChangeNotifier {\n\n'
                    '  // i tuoi dati\n'
                    '  String _valore = "Iniziale";\n'
                    '  int _contatore = 0;\n\n'
                    '  // getter pubblici (read-only dall\'esterno)\n'
                    '  String get valore => _valore;\n'
                    '  int get contatore => _contatore;\n\n'
                    '  // funzioni che modificano i dati\n'
                    '  void aggiorna(String nuovoValore) {\n'
                    '    _valore = nuovoValore;\n'
                    '    notifyListeners(); // 👈 senza questo i widget non si aggiornano\n'
                    '  }\n\n'
                    '  void incrementa() {\n'
                    '    _contatore++;\n'
                    '    notifyListeners();\n'
                    '  }\n'
                    '}\n\n'
                    '// ── STEP 2: Iniezione nel main.dart ──────────────────\n'
                    'void main() {\n'
                    '  runApp(\n'
                    '    ChangeNotifierProvider(\n'
                    '      create: (context) => MioProvider(),\n'
                    '      child: const MyApp(),   // MaterialApp va dentro child\n'
                    '    ),\n'
                    '  );\n'
                    '}\n\n'
                    '// ── STEP 3: Widget che legge (si ricostruisce) ───────\n'
                    'class DisplayWidget extends StatelessWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    final provider = context.watch<MioProvider>(); // ascolta i cambiamenti\n'
                    '    return Column(\n'
                    '      children: [\n'
                    '        Text(provider.valore),\n'
                    '        Text("\${provider.contatore}"),\n'
                    '      ],\n'
                    '    );\n'
                    '  }\n'
                    '}\n\n'
                    '// ── STEP 4: Widget che agisce (non si ricostruisce) ──\n'
                    'class AzioneWidget extends StatelessWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    return Column(\n'
                    '      children: [\n'
                    '        ElevatedButton(\n'
                    '          onPressed: () =>\n'
                    '            context.read<MioProvider>().incrementa(), // solo azione\n'
                    '          child: const Text("Incrementa"),\n'
                    '        ),\n'
                    '        ElevatedButton(\n'
                    '          onPressed: () =>\n'
                    '            context.read<MioProvider>().aggiorna("Nuovo"),\n'
                    '          child: const Text("Aggiorna"),\n'
                    '        ),\n'
                    '      ],\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            _alertSuggerimento(
              '⚠️ Regola d\'oro: watch nei build() per leggere, read negli onPressed() per agire. '
              'Usare watch dentro un bottone causa ricostruzioni inutili ad ogni cambio di stato.',
            ),
            const SizedBox(height: 30),
            _suggerimentoCreativo(
              '💡 Ricorda: Usa Provider quando un dato deve essere condiviso tra più pagine o tra widget lontani tra loro. Se il dato serve solo a una piccola parte di un singolo widget, resta pure fedele a setState!',
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
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colore.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 22),
                const SizedBox(width: 12),
                Text(
                  titolo.toUpperCase(),
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.radio_button_checked, color: colore, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Colors.white70),
                children: [
                  TextSpan(
                    text: '$titolo: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colore,
                    ),
                  ),
                  TextSpan(text: desc),
                ],
              ),
            ),
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
          color: Color(0xFF76FF03),
          fontFamily: 'monospace',
          fontSize: 11,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(color: Colors.amber, fontSize: 12, height: 1.4),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);
}
