import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Fondamentale!
import 'package:nuova_app/theme/horror_theme.dart';

class LezioneRiverpodPilastri extends ConsumerWidget {
  final String titoloLezione;
  const LezioneRiverpodPilastri({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horror = Theme.of(context).extension<HorrorTheme>()!;
    final neonRed = horror.bloodRed!;
    final neonGreen = horror.moldGreen!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: horror.horrorTitle?.copyWith(fontSize: 20),
        ),
        backgroundColor: const Color(0xFF0A0A0A),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ─── 1. STATE PROVIDER (Il più semplice) ────────────────────────
            _cardLezione(
              titolo: '1. StateProvider: Il Re del Variabile',
              colore: neonRed,
              icona: Icons.ads_click,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Si usa per dati primitivi (int, bool, String) che cambiano nel tempo. Pensa a lui come a una variabile globale "reattiva": quando il suo valore cambia, tutti i widget che lo ascoltano si ricostruiscono automaticamente. Perfetto per un contatore, un toggle on/off, o un testo modificabile.',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    '// Dichiarazione\n'
                    'final counterProvider = StateProvider<int>((ref) => 0);\n\n'
                    '// Modifica (dentro un pulsante)\n'
                    'ref.read(counterProvider.notifier).state++;',
                  ),
                ],
              ),
            ),

            // ─── 2. STATE NOTIFIER PROVIDER (La Logica Complessa) ───────────
            _cardLezione(
              titolo: '2. StateNotifier: La Mente',
              colore: neonGreen,
              icona: Icons.psychology,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quando lo stato non è più un singolo valore ma un oggetto complesso (una lista, un form, un carrello), hai bisogno di una classe dedicata che contenga tutta la logica. StateNotifier separa la "Mente" (la classe con i metodi) dal "Dato" (lo stato che osservi). La regola fondamentale: non modifichi mai lo stato direttamente, ma lo sostituisci sempre con una copia aggiornata — per questo nel codice vedi [...state, task] invece di state.add(task).',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    'class TaskNotifier extends StateNotifier<List<String>> {\n'
                    '  TaskNotifier(): super([]); // Stato iniziale vuoto\n\n'
                    '  void addTask(String task) => state = [...state, task];\n'
                    '}\n\n'
                    'final taskProvider = StateNotifierProvider<TaskNotifier, List<String>>((ref) {\n'
                    '  return TaskNotifier();\n'
                    '});',
                  ),
                ],
              ),
            ),

            // ─── 3. FUTURE PROVIDER (Dati dal Web) ──────────────────────────
            _cardLezione(
              titolo: '3. FutureProvider: L\'Inviato',
              colore: Colors.cyanAccent,
              icona: Icons.cloud_download,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Si usa ogni volta che devi aspettare qualcosa di asincrono: una chiamata API, una query al database, la lettura di un file. Il punto forte è che trasforma automaticamente il Future in tre stati distinti — loading, error, data — senza che tu scriva un singolo if. Nel widget usi ref.watch(...).when(...) e gestisci i tre casi in modo pulito e dichiarativo.',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    'final userProvider = FutureProvider((ref) async {\n'
                    '  return await fetchUserData(); // Una funzione async\n'
                    '});',
                  ),
                ],
              ),
            ),

            // ─── TEMPLATE: I TRE PILASTRI RIVERPOD ───────────────
            _cardLezione(
              titolo: 'Template: I Tre Provider in Pratica',
              colore: Colors.cyanAccent,
              icona: Icons.architecture,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scegli il provider giusto in base a cosa devi gestire — ognuno ha il suo caso d\'uso preciso.',
                    style: _stileTestoAcademy(),
                  ),
                  _boxCodice(
                    '// ── QUANDO USARE QUALE ───────────────────────────────\n'
                    '// StateProvider    → un valore solo (int, bool, String)\n'
                    '// StateNotifier    → logica complessa (lista, oggetto)\n'
                    '// FutureProvider   → dati asincroni (API, database)\n\n'
                    '// ── STATEPROVIDER: valore singolo ────────────────────\n'
                    'final isDarkProvider = StateProvider<bool>((ref) => false);\n'
                    'final paginaProvider = StateProvider<int>((ref) => 0);\n\n'
                    '// lettura nel build:\n'
                    'final isDark = ref.watch(isDarkProvider);\n\n'
                    '// modifica in un bottone:\n'
                    'ref.read(isDarkProvider.notifier).state = !isDark;\n\n'
                    '// ── STATENOTIFIER: logica complessa ──────────────────\n'
                    'class CarrelloNotifier extends StateNotifier<List<String>> {\n'
                    '  CarrelloNotifier() : super([]);\n\n'
                    '  void aggiungi(String item) =>\n'
                    '      state = [...state, item];   // sempre copia, mai mutare\n\n'
                    '  void rimuovi(String item) =>\n'
                    '      state = state.where((e) => e != item).toList();\n\n'
                    '  void svuota() => state = [];\n'
                    '}\n\n'
                    'final carrelloProvider =\n'
                    '    StateNotifierProvider<CarrelloNotifier, List<String>>(\n'
                    '        (ref) => CarrelloNotifier());\n\n'
                    '// lettura nel build:\n'
                    'final carrello = ref.watch(carrelloProvider);\n\n'
                    '// azione in un bottone:\n'
                    'ref.read(carrelloProvider.notifier).aggiungi("Scarpe");\n\n'
                    '// ── FUTUREPROVIDER: dati dal web ──────────────────────\n'
                    'final prodottiProvider = FutureProvider<List<String>>((ref) async {\n'
                    '  return await fetchProdotti(); // la tua funzione async\n'
                    '});\n\n'
                    '// nel widget gestisci i tre stati con .when():\n'
                    'ref.watch(prodottiProvider).when(\n'
                    '  loading: () => const CircularProgressIndicator(),\n'
                    '  error: (err, stack) => Text("Errore: \$err"),\n'
                    '  data: (prodotti) => ListView(\n'
                    '    children: prodotti.map((p) => Text(p)).toList(),\n'
                    '  ),\n'
                    ')',
                  ),
                ],
              ),
            ),

            _suggerimentoCreativo(
              '🔥 Pro-Tip: Usa sempre ref.watch(provider) per visualizzare i dati. '
              'Riverpod ricostruirà solo il widget necessario, risparmiando preziose risorse di calcolo!',
            ),

            const SizedBox(height: 20),

            _suggerimentoCreativo(
              '🔥 Regola pratica: inizia sempre con StateProvider. '
              'Solo quando ti accorgi che hai bisogno di più metodi o logica '
              'passa a StateNotifier. FutureProvider invece è sempre la scelta '
              'giusta appena c\'è una parola chiave async in mezzo.',
            ),
          ],
        ),
      ),
    );
  }

  // --- STILI E WIDGET DI SUPPORTO CON EFFETTO GLOW ---

  TextStyle _stileTestoAcademy() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);

  Widget _cardLezione({
    required String titolo,
    required Color colore,
    required IconData icona,
    required Widget corpo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colore.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: colore.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icona,
                  color: colore,
                  shadows: [Shadow(color: colore, blurRadius: 10)],
                ),
                const SizedBox(width: 12),
                Text(
                  titolo,
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
        ),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepOrange.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
