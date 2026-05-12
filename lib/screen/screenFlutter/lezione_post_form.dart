import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ─── MODEL ───────────────────────────────────────────────────────────────────

class NuovoPost {
  final int id;
  final String title;
  final String body;

  const NuovoPost({required this.id, required this.title, required this.body});

  factory NuovoPost.fromJson(Map<String, dynamic> json) {
    return NuovoPost(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }
}

// ─── PROVIDER STATO INVIO ────────────────────────────────────────────────────

// Tiene traccia se la chiamata POST è in corso
final isLoadingProvider = StateProvider<bool>((ref) => false);

// ─── WIDGET PRINCIPALE ───────────────────────────────────────────────────────

class LezionePostForm extends ConsumerStatefulWidget {
  final String titoloLezione;
  const LezionePostForm({super.key, required this.titoloLezione});

  @override
  ConsumerState<LezionePostForm> createState() => _LezionePostFormState();
}

class _LezionePostFormState extends ConsumerState<LezionePostForm> {
  // Palette Gothic-Neon
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonGreen = Color(0xFFC6FF00);
  static const Color neonOrange = Color(0xFFFF6D00);
  static const Color neonRed = Color(0xFFFF1744);
  static const Color neonPurple = Color(0xFFD500F9);
  static const Color darkBg = Color(0xFF0A0E12);
  static const Color cardBg = Color(0xFF1E262C);

  // Controllers e FormKey
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titoloController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titoloController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    _titoloController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  // ─── FUNZIONE POST ──────────────────────────────────────────────────────────
  Future<void> _inviaPost() async {
    // 1. Validazione locale
    if (!_formKey.currentState!.validate()) return;

    // 2. Stato Loading ON
    ref.read(isLoadingProvider.notifier).state = true;

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': _titoloController.text,
          'body': _bodyController.text,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final nuovoPost = NuovoPost.fromJson(jsonDecode(response.body));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Post #${nuovoPost.id} creato con successo!'),
              backgroundColor: Colors.green.shade900,
            ),
          );
          _titoloController.clear();
          _bodyController.clear();
        }
      } else {
        throw Exception('Errore del server: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Invio fallito: $e'),
            backgroundColor: Colors.red.shade900,
          ),
        );
      }
    } finally {
      // 3. Stato Loading OFF (sempre eseguito)
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        title: Text(
          widget.titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 13,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF006064),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Form(
          key: _formKey, // Colleghiamo la chiave per la validazione
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // INTRO
              _cardLezione(
                titolo: 'Teoria: Il metodo POST',
                colore: neonCyan,
                icona: Icons.compare_arrows_rounded,
                corpo: Text(
                  'Mentre GET serve per "leggere", POST serve per "scrivere". '
                  'I dati viaggiano nel corpo (body) della richiesta in formato JSON.',
                  style: _stileTestoBase(),
                ),
              ),

              // FORM REALE
              _cardLezione(
                titolo: 'Area di Test — Crea Post',
                colore: neonGreen,
                icona: Icons.add_box_rounded,
                corpo: Column(
                  children: [
                    _buildTextFormField(
                      controller: _titoloController,
                      label: 'Titolo',
                      hint: 'Inserisci il titolo del post...',
                      color: neonCyan,
                      icon: Icons.title,
                    ),
                    const SizedBox(height: 15),
                    _buildTextFormField(
                      controller: _bodyController,
                      label: 'Contenuto',
                      hint: 'Cosa vuoi scrivere?',
                      color: neonPurple,
                      icon: Icons.message,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 25),

                    // BOTTONE
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLoading ? Colors.grey : neonGreen,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading ? null : _inviaPost,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                'INVIA DATI AL SERVER',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // ─── ANALISI COSTRUZIONE DEL FORM ───────────────────────────────────────────
              _cardLezione(
                titolo: 'Come è costruito questo Form: Analisi',
                colore: neonOrange,
                icona: Icons.build_circle_rounded,
                corpo: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analizziamo ogni scelta di questo form POST, passo dopo passo. Capisci il perché di ogni riga.',
                      style: _stileTestoBase(),
                    ),
                    const SizedBox(height: 18),

                    // ── PASSO 1 ──────────────────────────────────────────────────
                    _buildPuntoChiave(
                      titolo: 'Passo 1 — ConsumerStatefulWidget',
                      desc:
                          'Usiamo ConsumerStatefulWidget invece del classico StatefulWidget perché abbiamo bisogno sia di uno State (per i controller) sia di ref (per leggere/scrivere i provider Riverpod).',
                      colore: neonCyan,
                    ),
                    _boxCodice(
                      '// StatefulWidget  → solo setState, niente Riverpod\n'
                      '// ConsumerStatefulWidget → setState + ref.watch / ref.read\n\n'
                      'class LezionePostForm extends ConsumerStatefulWidget {\n'
                      '  @override\n'
                      '  ConsumerState<LezionePostForm> createState()\n'
                      '    => _LezionePostFormState();\n'
                      '}',
                    ),

                    // ── PASSO 2 ──────────────────────────────────────────────────
                    _buildPuntoChiave(
                      titolo: 'Passo 2 — isLoadingProvider',
                      desc:
                          'Uno StateProvider<bool> tiene traccia se la chiamata HTTP è in corso. Quando è true il bottone si disabilita e mostra uno spinner. Vive fuori dal widget per essere letto da qualunque punto dell\'albero.',
                      colore: neonCyan,
                    ),
                    _boxCodice(
                      'final isLoadingProvider = StateProvider<bool>((ref) => false);\n\n'
                      '// Nel widget:\n'
                      'final isLoading = ref.watch(isLoadingProvider); // legge\n'
                      'ref.read(isLoadingProvider.notifier).state = true; // scrive',
                    ),

                    // ── PASSO 3 ──────────────────────────────────────────────────
                    _buildPuntoChiave(
                      titolo: 'Passo 3 — GlobalKey + Controller',
                      desc:
                          'La GlobalKey<FormState> è il telecomando del Form: permette di chiamare validate() da fuori. I due controller gestiscono titolo e body. Tutti e tre dichiarati a livello di classe, mai dentro build().',
                      colore: neonCyan,
                    ),
                    _boxCodice(
                      'final _formKey = GlobalKey<FormState>(); // ← telecomando\n'
                      'late TextEditingController _titoloController;\n'
                      'late TextEditingController _bodyController;\n\n'
                      '@override\n'
                      'void initState() {\n'
                      '  super.initState();\n'
                      '  _titoloController = TextEditingController();\n'
                      '  _bodyController   = TextEditingController();\n'
                      '}\n\n'
                      '@override\n'
                      'void dispose() {\n'
                      '  _titoloController.dispose(); // libera memoria\n'
                      '  _bodyController.dispose();\n'
                      '  super.dispose();\n'
                      '}',
                    ),

                    // ── PASSO 4 ──────────────────────────────────────────────────
                    _buildPuntoChiave(
                      titolo: 'Passo 4 — La funzione _inviaPost()',
                      desc:
                          'È async e segue un ordine preciso: prima valida in locale, poi accende il loading, poi chiama l\'API. Il blocco try/catch/finally garantisce che il loading venga sempre spento, anche in caso di errore.',
                      colore: neonCyan,
                    ),
                    _boxCodice(
                      'Future<void> _inviaPost() async {\n\n'
                      '  // 1. Validazione locale (se fallisce, stop)\n'
                      '  if (!_formKey.currentState!.validate()) return;\n\n'
                      '  // 2. Accende lo spinner\n'
                      '  ref.read(isLoadingProvider.notifier).state = true;\n\n'
                      '  try {\n'
                      '    final response = await http.post(\n'
                      '      Uri.parse("https://jsonplaceholder.typicode.com/posts"),\n'
                      '      headers: {"Content-Type": "application/json"},\n'
                      '      body: jsonEncode({\n'
                      '        "title": _titoloController.text,\n'
                      '        "body":  _bodyController.text,\n'
                      '        "userId": 1,\n'
                      '      }),\n'
                      '    );\n\n'
                      '    if (response.statusCode == 201) {\n'
                      '      final post = NuovoPost.fromJson(jsonDecode(response.body));\n'
                      '      // mostra SnackBar, svuota i campi...\n'
                      '    } else {\n'
                      '      throw Exception("Errore: \${response.statusCode}");\n'
                      '    }\n\n'
                      '  } catch (e) {\n'
                      '    // mostra SnackBar di errore\n'
                      '  } finally {\n'
                      '    // 3. Spegne spinner SEMPRE (anche se c\'è stato un crash)\n'
                      '    ref.read(isLoadingProvider.notifier).state = false;\n'
                      '  }\n'
                      '}',
                    ),

                    // ── PASSO 5 ──────────────────────────────────────────────────
                    _buildPuntoChiave(
                      titolo: 'Passo 5 — Il controllo mounted',
                      desc:
                          'Dopo un await il widget potrebbe essere già stato rimosso dall\'albero (es. utente naviga via). Il check if (mounted) evita di chiamare setState o showSnackBar su un widget morto, che causerebbe un crash.',
                      colore: neonCyan,
                    ),
                    _boxCodice(
                      '// ❌ Pericoloso: il widget potrebbe non esistere più\n'
                      'ScaffoldMessenger.of(context).showSnackBar(...);\n\n'
                      '// ✅ Sicuro: controlla prima\n'
                      'if (mounted) {\n'
                      '  ScaffoldMessenger.of(context).showSnackBar(...);\n'
                      '  _titoloController.clear();\n'
                      '}',
                    ),

                    // ── PASSO 6 ──────────────────────────────────────────────────
                    _buildPuntoChiave(
                      titolo: 'Passo 6 — Bottone reattivo',
                      desc:
                          'Il bottone legge isLoading dal provider. Quando è true: colore grigio, onPressed null (disabilitato), figlio CircularProgressIndicator. Un solo StateProvider controlla tutto.',
                      colore: neonCyan,
                    ),
                    _boxCodice(
                      'ElevatedButton(\n'
                      '  style: ElevatedButton.styleFrom(\n'
                      '    backgroundColor: isLoading ? Colors.grey : neonGreen,\n'
                      '  ),\n'
                      '  onPressed: isLoading ? null : _inviaPost, // null = disabilitato\n'
                      '  child: isLoading\n'
                      '    ? const CircularProgressIndicator(color: Colors.black)\n'
                      '    : const Text("INVIA DATI AL SERVER"),\n'
                      ')',
                    ),

                    // ── SCHEMA FLUSSO ─────────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(top: 8, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: neonOrange.withOpacity(0.25)),
                      ),
                      child: Text(
                        '🔁 Flusso completo:\n'
                        'Utente preme "Invia"\n'
                        '  → validate()  → campi vuoti? mostra errori, stop\n'
                        '  → isLoading = true  → bottone disabilitato\n'
                        '  → http.post()  → attende risposta dal server\n'
                        '  → 201 OK  → SnackBar verde + clear dei campi\n'
                        '  → errore  → SnackBar rossa\n'
                        '  → finally  → isLoading = false (sempre)',
                        style: TextStyle(
                          color: neonOrange.withOpacity(0.85),
                          fontSize: 12,
                          height: 1.6,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              _suggerimentoCreativo(
                'Tip: Usa jsonEncode() per trasformare la tua Map in una stringa leggibile dall\'API.',
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // ─── COMPONENTI DI SUPPORTO (UI) ──────────────────────────────────────────

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
          Icon(Icons.check_circle_outline, color: colore, size: 18),
          const SizedBox(width: 10),
          Expanded(
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
                  style: const TextStyle(color: Colors.white70, fontSize: 12.5),
                ),
              ],
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

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Color color,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: color),
        labelText: label,
        labelStyle: TextStyle(color: color.withOpacity(0.8)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 12),
        filled: true,
        fillColor: Colors.black26,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: neonRed),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (v) =>
          v == null || v.isEmpty ? 'Questo campo è obbligatorio' : null,
    );
  }

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
        color: cardBg,
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
                    fontSize: 12,
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
