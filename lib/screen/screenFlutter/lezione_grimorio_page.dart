import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LezioneGrimorio extends StatefulWidget {
  final String titoloLezione;
  const LezioneGrimorio({super.key, required this.titoloLezione});

  @override
  State<LezioneGrimorio> createState() => _LezioneGrimorioState();
}

class _LezioneGrimorioState extends State<LezioneGrimorio> {
  // ─── PALETTE ──────────────────────────────────────────────────────────────
  static const Color neonPurple = Color(0xFFD500F9);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonGreen = Color(0xFFC6FF00);
  static const Color neonOrange = Color(0xFFFF6D00);
  static const Color darkBg = Color(0xFF0A0E12);
  static const Color cardBg = Color(0xFF1E262C);

  final TextEditingController _controller = TextEditingController();
  String _datoSalvato = 'Nessun segreto custodito';

  @override
  void initState() {
    super.initState();
    _caricaDato();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ─── SCRITTURA ─────────────────────────────────────────────────────────────
  Future<void> _salvaDato() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('segreto_arcano', _controller.text);
    await _caricaDato();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('📜 Inciso nel Grimorio!')));
    }
  }

  // ─── LETTURA ───────────────────────────────────────────────────────────────
  Future<void> _caricaDato() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _datoSalvato =
            prefs.getString('segreto_arcano') ?? 'Il Grimorio è vuoto';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color(0xFF311B92),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. COS'È SHARED PREFERENCES ──────────────────────────────
            _cardLezione(
              titolo: 'Cos\'è SharedPreferences?',
              colore: neonPurple,
              icona: Icons.storage_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SharedPreferences è il sistema di storage locale più semplice di Flutter. '
                    'Salva coppie chiave-valore direttamente sul dispositivo, '
                    'e i dati sopravvivono alla chiusura dell\'app.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Quando usarlo',
                    desc:
                        'Impostazioni utente, tema scelto, token di login, flag "primo avvio", '
                        'piccoli dati di stato. NON usarlo per dati strutturati o grossi: usa SQLite o Hive.',
                    colore: neonPurple,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Dove sono salvati i dati?',
                    desc:
                        'Su Android: SharedPreferences XML nella sandbox dell\'app. '
                        'Su iOS: NSUserDefaults. Su Web: localStorage. '
                        'Tutto astratto dalla libreria.',
                    colore: neonCyan,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Tipi supportati',
                    desc:
                        'String, int, double, bool, List<String>. '
                        'Per oggetti complessi devi serializzare in JSON manualmente.',
                    colore: neonGreen,
                  ),
                ],
              ),
            ),

            // ─── 2. SETUP ─────────────────────────────────────────────────
            _cardLezione(
              titolo: 'Setup: pubspec.yaml',
              colore: neonCyan,
              icona: Icons.build_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prima di tutto aggiungi la dipendenza nel pubspec.yaml e fai flutter pub get.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '# pubspec.yaml\n'
                    'dependencies:\n'
                    '  flutter:\n'
                    '    sdk: flutter\n'
                    '  shared_preferences: ^2.3.5 # ← aggiungi questa riga',
                  ),
                  _alertSuggerimento(
                    '💡 Controlla sempre la versione più recente su pub.dev/packages/shared_preferences',
                  ),
                ],
              ),
            ),

            // ─── 3. COME È COSTRUITO QUESTO STORAGE ───────────────────────
            _cardLezione(
              titolo: 'Come è costruito questo Local Storage',
              colore: neonOrange,
              icona: Icons.build_circle_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Analizziamo ogni scelta di questa schermata passo dopo passo.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Passo 1 — getInstance() è asincrono',
                    desc:
                        'SharedPreferences.getInstance() restituisce un Future: '
                        'deve leggere il disco, quindi non è istantaneo. '
                        'Per questo TUTTE le funzioni che lo usano sono async/await.',
                    colore: neonOrange,
                  ),
                  _boxCodice(
                    '// ✅ Corretto: await\n'
                    'Future<void> _salvaDato() async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  await prefs.setString("chiave", valore);\n'
                    '}\n\n'
                    '// ❌ Sbagliato: senza await non hai ancora l\'istanza\n'
                    'void _salvaDato() {\n'
                    '  final prefs = SharedPreferences.getInstance(); // Future!\n'
                    '  prefs.setString("chiave", valore); // CRASH\n'
                    '}',
                  ),
                  _buildPuntoChiave(
                    titolo: 'Passo 2 — La chiave stringa',
                    desc:
                        'Ogni dato è identificato da una chiave stringa univoca '
                        '(es. "segreto_arcano"). Con quella stessa chiave lo leggi, '
                        'lo sovrascrivi e lo elimini. Se sbagli la chiave ottieni null.',
                    colore: neonOrange,
                  ),
                  _boxCodice(
                    'await prefs.setString("segreto_arcano", testo); // scrittura\n'
                    'prefs.getString("segreto_arcano");               // lettura\n'
                    'await prefs.remove("segreto_arcano");            // cancellazione',
                  ),
                  _buildPuntoChiave(
                    titolo: 'Passo 3 — L\'operatore ?? (null-coalescing)',
                    desc:
                        'getString() restituisce null se la chiave non esiste ancora '
                        '(primo avvio). L\'operatore ?? fornisce un valore di default '
                        'sicuro al posto di null.',
                    colore: neonOrange,
                  ),
                  _boxCodice(
                    '// Se "segreto_arcano" non esiste → restituisce null\n'
                    '// ?? "Il Grimorio è vuoto" → usa questo al suo posto\n'
                    '_datoSalvato =\n'
                    '    prefs.getString("segreto_arcano") ?? "Il Grimorio è vuoto";',
                  ),
                  _buildPuntoChiave(
                    titolo: 'Passo 4 — _caricaDato() in initState',
                    desc:
                        'Chiamiamo _caricaDato() dentro initState() così appena '
                        'l\'utente apre la schermata vede subito il dato salvato '
                        'dalla sessione precedente, senza premere nulla.',
                    colore: neonOrange,
                  ),
                  _boxCodice(
                    '@override\n'
                    'void initState() {\n'
                    '  super.initState();\n'
                    '  _caricaDato(); // carica subito al primo build\n'
                    '}',
                  ),
                  _buildPuntoChiave(
                    titolo: 'Passo 5 — setState dentro _caricaDato',
                    desc:
                        'Dopo aver letto il valore dal disco, chiamiamo setState() '
                        'per aggiornare la UI. Senza setState la variabile cambia '
                        'ma Flutter non ridisegna il widget.',
                    colore: neonOrange,
                  ),
                  _boxCodice(
                    'Future<void> _caricaDato() async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  if (mounted) {           // widget ancora vivo?\n'
                    '    setState(() {           // ← aggiorna la UI\n'
                    '      _datoSalvato = prefs.getString("segreto_arcano")\n'
                    '          ?? "Il Grimorio è vuoto";\n'
                    '    });\n'
                    '  }\n'
                    '}',
                  ),
                  _buildPuntoChiave(
                    titolo: 'Passo 6 — Il check mounted',
                    desc:
                        'Dopo ogni await il widget potrebbe essere già stato '
                        'rimosso dall\'albero (utente è tornato indietro). '
                        'if (mounted) evita di chiamare setState su un widget '
                        'morto, che causerebbe un\'eccezione.',
                    colore: neonOrange,
                  ),
                  _alertSuggerimento(
                    '🔁 Flusso completo:\n'
                    'App apre\n'
                    '  → initState() → _caricaDato()\n'
                    '  → getInstance() legge dal disco\n'
                    '  → setState() aggiorna la UI\n\n'
                    'Utente scrive e preme "Salva"\n'
                    '  → _salvaDato() → getInstance()\n'
                    '  → setString() scrive sul disco\n'
                    '  → _caricaDato() → setState() aggiorna UI\n'
                    '  → SnackBar di conferma',
                  ),
                ],
              ),
            ),

            // ─── 4. DEMO INTERATTIVA ───────────────────────────────────────
            _cardLezione(
              titolo: 'Demo — Il Grimorio',
              colore: neonGreen,
              icona: Icons.auto_stories_rounded,
              corpo: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: neonPurple.withOpacity(0.4)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'DATO ATTUALMENTE PERSISTENTE',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _datoSalvato,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Scrivi un segreto...',
                      labelStyle: TextStyle(color: neonGreen.withOpacity(0.8)),
                      filled: true,
                      fillColor: Colors.black26,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: neonGreen.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: neonGreen),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _salvaDato,
                      icon: const Icon(Icons.auto_stories),
                      label: const Text(
                        'SALVA PER SEMPRE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: neonGreen,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─── 5. TEMPLATE ──────────────────────────────────────────────
            _cardLezione(
              titolo: 'Template — Local Storage Completo',
              colore: neonCyan,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Template pronto all\'uso con le 4 operazioni fondamentali: '
                    'leggi, scrivi, elimina una chiave, svuota tutto.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Step 1 — Variabili di stato',
                    desc:
                        'Una variabile per ogni dato che vuoi mostrare in UI. '
                        'Vengono aggiornate tramite setState dopo ogni lettura.',
                    colore: neonCyan,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 2 — Carica in initState',
                    desc:
                        'Chiama sempre il metodo di lettura in initState '
                        'così la UI è subito aggiornata all\'apertura.',
                    colore: neonGreen,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 3 — CRUD completo',
                    desc:
                        'setString/getInt/setBool per scrivere, '
                        'getString/getInt/getBool per leggere, '
                        'remove() per una chiave, clear() per tutto.',
                    colore: neonOrange,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 4 — mounted prima di setState',
                    desc:
                        'Dopo ogni await controlla if (mounted) prima di '
                        'chiamare setState o usare il context.',
                    colore: neonPurple,
                  ),
                  _boxCodice(
                    '// ── STEP 1: Stato ────────────────────────────────────\n'
                    'String _testo = "";\n'
                    'int _contatore = 0;\n'
                    'bool _darkMode = false;\n\n'
                    '// ── STEP 2: Carica all\'avvio ─────────────────────────\n'
                    '@override\n'
                    'void initState() {\n'
                    '  super.initState();\n'
                    '  _caricaTutto();\n'
                    '}\n\n'
                    '// ── STEP 3: CRUD ─────────────────────────────────────\n'
                    'Future<void> _caricaTutto() async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  if (mounted) {\n'
                    '    setState(() {\n'
                    '      _testo     = prefs.getString("testo")   ?? "";\n'
                    '      _contatore = prefs.getInt("contatore")  ?? 0;\n'
                    '      _darkMode  = prefs.getBool("dark_mode") ?? false;\n'
                    '    });\n'
                    '  }\n'
                    '}\n\n'
                    'Future<void> _salvaStringa(String valore) async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  await prefs.setString("testo", valore);\n'
                    '  await _caricaTutto(); // aggiorna UI\n'
                    '}\n\n'
                    'Future<void> _salvaIntero(int valore) async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  await prefs.setInt("contatore", valore);\n'
                    '  await _caricaTutto();\n'
                    '}\n\n'
                    'Future<void> _salvaBool(bool valore) async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  await prefs.setBool("dark_mode", valore);\n'
                    '  await _caricaTutto();\n'
                    '}\n\n'
                    'Future<void> _eliminaChiave() async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  await prefs.remove("testo"); // rimuove solo questa\n'
                    '  await _caricaTutto();\n'
                    '}\n\n'
                    'Future<void> _svuotaTutto() async {\n'
                    '  final prefs = await SharedPreferences.getInstance();\n'
                    '  await prefs.clear(); // cancella TUTTO lo storage\n'
                    '  await _caricaTutto();\n'
                    '}',
                  ),
                  _alertSuggerimento(
                    '⚠️ SharedPreferences NON è cifrato. Non salvare mai password, '
                    'token sensibili o dati privati. Per quelli usa flutter_secure_storage.',
                  ),
                  _alertSuggerimento(
                    '⚠️ SharedPreferences NON è un database. Per liste, relazioni '
                    'o query complesse usa Hive, Isar o sqflite.',
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

  // ─── COMPONENTI DI SUPPORTO ───────────────────────────────────────────────

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
                Expanded(
                  child: Text(
                    titolo.toUpperCase(),
                    style: TextStyle(
                      color: colore,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.8,
                    ),
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

  Widget _alertSuggerimento(String testo) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(color: Colors.amber, fontSize: 12, height: 1.5),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);
}
