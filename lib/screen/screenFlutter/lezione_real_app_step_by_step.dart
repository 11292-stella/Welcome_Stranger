import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ─── MODELLO E PROVIDER (fuori dalla classe, globali) ────────────────────────

class Post {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Senza titolo',
      body: json['body'] as String? ?? '',
    );
  }
}

final postsProvider = FutureProvider<List<Post>>((ref) async {
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> listaJson = jsonDecode(response.body);
      return listaJson.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Errore ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Connessione fallita: $e');
  }
});

// ─── LEZIONE UI ───────────────────────────────────────────────────────────────

class LezioneRealAppStepByStep extends ConsumerWidget {
  final String titoloLezione;
  const LezioneRealAppStepByStep({super.key, required this.titoloLezione});

  // Palette
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color neonGreen = Color(0xFFC6FF00);
  static const Color neonOrange = Color(0xFFFF6D00);
  static const Color neonRed = Color(0xFFFF1744);
  static const Color neonPurple = Color(0xFFD500F9);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E12),
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 13,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006064),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRO ────────────────────────────────────────────────────────
            _cardLezione(
              titolo: 'Il Piano: Cosa Costruiremo',
              colore: neonCyan,
              icona: Icons.map_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Costruiremo una app reale che legge post da un server vero (jsonplaceholder.typicode.com). È la API di test più usata al mondo — gratuita, sempre online, nessuna autenticazione.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildStep(
                    'Step 1',
                    'Data Model — definire la forma del dato.',
                    neonCyan,
                  ),
                  _buildStep(
                    'Step 2',
                    'FutureProvider — scaricare i dati dal server.',
                    neonGreen,
                  ),
                  _buildStep(
                    'Step 3',
                    'ConsumerWidget — collegare UI e dati.',
                    neonOrange,
                  ),
                  _buildStep(
                    'Step 4',
                    '.when() — gestire loading, errore e successo.',
                    neonPurple,
                  ),
                  _buildStep(
                    'Step 5',
                    'Card UI — mostrare i dati in modo leggibile.',
                    neonRed,
                  ),
                ],
              ),
            ),

            // ─── STEP 1: IL MODELLO ───────────────────────────────────────────
            _cardLezione(
              titolo: 'Step 1 — Data Model: La Forma del Dato',
              colore: neonCyan,
              icona: Icons.data_object_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prima di scrivere una sola riga di UI, definisci come appare il dato. Il server ti manda JSON grezzo — il Model lo trasforma in un oggetto Dart sicuro e tipizzato.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    'final sui campi',
                    'I dati non cambiano dopo la creazione — const garantisce immutabilità.',
                    neonCyan,
                  ),
                  _buildPuntoChiave(
                    'factory fromJson',
                    'Converte la Map grezza in un oggetto Post. Il ?? fornisce valori di fallback se il server manda null.',
                    neonCyan,
                  ),
                  _boxCodice(
                    'class Post {\n'
                    '  final int id;\n'
                    '  final String title;\n'
                    '  final String body;\n\n'
                    '  const Post({required this.id, required this.title, required this.body});\n\n'
                    '  factory Post.fromJson(Map<String, dynamic> json) {\n'
                    '    return Post(\n'
                    '      id: json[\'id\'] as int? ?? 0,\n'
                    '      title: json[\'title\'] as String? ?? \'Senza titolo\',\n'
                    '      body: json[\'body\'] as String? ?? \'\',\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── STEP 2: IL PROVIDER ──────────────────────────────────────────
            _cardLezione(
              titolo: 'Step 2 — FutureProvider: Scaricare i Dati',
              colore: neonGreen,
              icona: Icons.cloud_download_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il FutureProvider è una funzione async globale che Riverpod esegue una volta sola e memorizza. Gestisce da solo i tre stati: loading, error, data.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    'Dichiarazione globale',
                    'Va fuori da ogni classe — così qualsiasi widget può accedervi con ref.watch.',
                    neonGreen,
                  ),
                  _buildPuntoChiave(
                    'try/catch obbligatorio',
                    'La rete può sempre fallire. Senza try/catch un errore di connessione fa crashare l\'app.',
                    neonGreen,
                  ),
                  _buildPuntoChiave(
                    'map + fromJson',
                    'Trasforma ogni elemento della lista JSON in un oggetto Post usando il Model dello Step 1.',
                    neonGreen,
                  ),
                  _boxCodice(
                    '// Globale — fuori da ogni classe\n'
                    'final postsProvider = FutureProvider<List<Post>>((ref) async {\n'
                    '  try {\n'
                    '    final response = await http.get(\n'
                    '      Uri.parse(\'https://jsonplaceholder.typicode.com/posts\'),\n'
                    '    );\n'
                    '    if (response.statusCode == 200) {\n'
                    '      final List<dynamic> listaJson = jsonDecode(response.body);\n'
                    '      return listaJson.map((item) => Post.fromJson(item)).toList();\n'
                    '    } else {\n'
                    '      throw Exception(\'Errore \${response.statusCode}\');\n'
                    '    }\n'
                    '  } catch (e) {\n'
                    '    throw Exception(\'Connessione fallita: \$e\');\n'
                    '  }\n'
                    '});',
                  ),
                ],
              ),
            ),

            // ─── STEP 3: IL WIDGET ────────────────────────────────────────────
            _cardLezione(
              titolo: 'Step 3 — ConsumerWidget: Collegare UI e Dati',
              colore: neonOrange,
              icona: Icons.widgets_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per leggere un provider, il widget deve essere ConsumerWidget invece di StatelessWidget. Riceve un secondo parametro nel build: WidgetRef ref — il ponte verso i dati.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    'extends ConsumerWidget',
                    'Sostituisce StatelessWidget. Nient\'altro cambia nella struttura della classe.',
                    neonOrange,
                  ),
                  _buildPuntoChiave(
                    'WidgetRef ref',
                    'Secondo parametro del build(). Senza di lui non puoi toccare nessun provider.',
                    neonOrange,
                  ),
                  _buildPuntoChiave(
                    'ref.watch(postsProvider)',
                    'Ascolta il provider. Quando i dati arrivano, il widget si ricostruisce automaticamente.',
                    neonOrange,
                  ),
                  _boxCodice(
                    '//          ↓ ConsumerWidget, non StatelessWidget\n'
                    'class MiaApp extends ConsumerWidget {\n'
                    '  const MiaApp({super.key});\n\n'
                    '  @override\n'
                    '  //                             ↓ WidgetRef ref è il nuovo parametro\n'
                    '  Widget build(BuildContext context, WidgetRef ref) {\n'
                    '    // ref.watch ascolta il provider e restituisce AsyncValue<List<Post>>\n'
                    '    final asyncPosts = ref.watch(postsProvider);\n\n'
                    '    return Scaffold(\n'
                    '      body: asyncPosts.when( ... ), // Step 4\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── STEP 4: IL WHEN ──────────────────────────────────────────────
            _cardLezione(
              titolo: 'Step 4 — .when(): I Tre Stati',
              colore: neonPurple,
              icona: Icons.alt_route_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '.when() è il cuore del FutureProvider. Obbliga lo sviluppatore a gestire esplicitamente tutti e tre i casi — non puoi dimenticarne uno.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    'loading',
                    'I dati non sono ancora arrivati. Mostra uno spinner o uno scheletro.',
                    neonPurple,
                  ),
                  _buildPuntoChiave(
                    'error',
                    'Qualcosa è andato storto. Ricevi err e stack — mostra un messaggio leggibile.',
                    neonPurple,
                  ),
                  _buildPuntoChiave(
                    'data',
                    'I dati sono pronti. Ricevi direttamente la List<Post> già deserializzata.',
                    neonPurple,
                  ),
                  _boxCodice(
                    'body: asyncPosts.when(\n\n'
                    '  // STATO 1: ancora in attesa\n'
                    '  loading: () => const Center(\n'
                    '    child: CircularProgressIndicator(),\n'
                    '  ),\n\n'
                    '  // STATO 2: qualcosa è andato storto\n'
                    '  error: (err, stack) => Center(\n'
                    '    child: Text(\n'
                    '      \'Errore: \$err\',\n'
                    '      style: const TextStyle(color: Colors.red),\n'
                    '    ),\n'
                    '  ),\n\n'
                    '  // STATO 3: dati pronti — posts è List<Post>\n'
                    '  data: (posts) => ListView.builder(\n'
                    '    itemCount: posts.length,\n'
                    '    itemBuilder: (context, index) {\n'
                    '      final post = posts[index];\n'
                    '      return Text(post.title); // Step 5\n'
                    '    },\n'
                    '  ),\n'
                    ')',
                  ),
                ],
              ),
            ),

            // ─── STEP 5: LA CARD UI ───────────────────────────────────────────
            _cardLezione(
              titolo: 'Step 5 — Card UI: Mostrare i Dati',
              colore: neonRed,
              icona: Icons.style_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estrai la card in un metodo privato per tenere il build() pulito. Riceve un singolo Post e sa come mostrarlo — niente logica, solo UI.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    'Metodo privato _buildCard',
                    'Tiene il build() leggibile. Se la card diventa complessa, diventa un widget separato.',
                    neonRed,
                  ),
                  _buildPuntoChiave(
                    'CircleAvatar con ID',
                    'Mostra l\'ID del post come identificatore visivo rapido.',
                    neonRed,
                  ),
                  _boxCodice(
                    '// Metodo privato — riceve un Post, restituisce un Widget\n'
                    'Widget _buildCard(Post post) {\n'
                    '  return Container(\n'
                    '    margin: const EdgeInsets.only(bottom: 15),\n'
                    '    decoration: BoxDecoration(\n'
                    '      color: const Color(0xFF121212),\n'
                    '      border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),\n'
                    '      borderRadius: BorderRadius.circular(10),\n'
                    '    ),\n'
                    '    child: ListTile(\n'
                    '      leading: CircleAvatar(\n'
                    '        backgroundColor: Colors.greenAccent.withOpacity(0.1),\n'
                    '        child: Text(\n'
                    '          post.id.toString(),\n'
                    '          style: const TextStyle(color: Colors.greenAccent),\n'
                    '        ),\n'
                    '      ),\n'
                    '      title: Text(\n'
                    '        post.title,\n'
                    '        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),\n'
                    '      ),\n'
                    '      subtitle: Text(\n'
                    '        post.body,\n'
                    '        style: const TextStyle(color: Colors.white60, fontSize: 12),\n'
                    '      ),\n'
                    '    ),\n'
                    '  );\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── TEMPLATE FINALE ──────────────────────────────────────────────
            _cardLezione(
              titolo: 'Template: App Completa da Copiare',
              colore: neonCyan,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il codice completo e funzionante. Cambia solo l\'URL e i campi del Model — il resto della struttura rimane identica per qualsiasi API.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildPuntoChiave(
                    '1 — Model',
                    'Rinomina Post con il tuo dato. Aggiusta i campi fromJson.',
                    neonCyan,
                  ),
                  _buildPuntoChiave(
                    '2 — Provider',
                    'Cambia l\'URL. Tutto il resto rimane uguale.',
                    neonGreen,
                  ),
                  _buildPuntoChiave(
                    '3 — Widget',
                    'extends ConsumerWidget, ref.watch, .when().',
                    neonOrange,
                  ),
                  _buildPuntoChiave(
                    '4 — Card',
                    'Un metodo _buildCard(MioModello item) per ogni riga.',
                    neonRed,
                  ),
                  _boxCodice(
                    '// ════ 1. MODEL ══════════════════════════════════════════\n'
                    'class MioModello {\n'
                    '  final int id;\n'
                    '  final String nome;   // cambia con i tuoi campi\n\n'
                    '  const MioModello({required this.id, required this.nome});\n\n'
                    '  factory MioModello.fromJson(Map<String, dynamic> json) {\n'
                    '    return MioModello(\n'
                    '      id: json[\'id\'] as int? ?? 0,\n'
                    '      nome: json[\'name\'] as String? ?? \'\',  // chiave esatta del JSON\n'
                    '    );\n'
                    '  }\n'
                    '}\n\n'
                    '// ════ 2. PROVIDER ════════════════════════════════════════\n'
                    'final mioProvider = FutureProvider<List<MioModello>>((ref) async {\n'
                    '  try {\n'
                    '    final res = await http.get(Uri.parse(\'https://TUA-API.com/endpoint\'));\n'
                    '    if (res.statusCode == 200) {\n'
                    '      final List<dynamic> lista = jsonDecode(res.body);\n'
                    '      return lista.map((e) => MioModello.fromJson(e)).toList();\n'
                    '    } else {\n'
                    '      throw Exception(\'Errore \${res.statusCode}\');\n'
                    '    }\n'
                    '  } catch (e) {\n'
                    '    throw Exception(\'Fetch fallito: \$e\');\n'
                    '  }\n'
                    '});\n\n'
                    '// ════ 3. WIDGET ══════════════════════════════════════════\n'
                    'class MiaSchermata extends ConsumerWidget {\n'
                    '  const MiaSchermata({super.key});\n\n'
                    '  @override\n'
                    '  Widget build(BuildContext context, WidgetRef ref) {\n'
                    '    return Scaffold(\n'
                    '      body: ref.watch(mioProvider).when(\n'
                    '        loading: () => const Center(child: CircularProgressIndicator()),\n'
                    '        error: (err, _) => Center(child: Text(\'Errore: \$err\')),\n'
                    '        data: (lista) => ListView.builder(\n'
                    '          itemCount: lista.length,\n'
                    '          itemBuilder: (context, i) => _buildCard(lista[i]),\n'
                    '        ),\n'
                    '      ),\n'
                    '    );\n'
                    '  }\n\n'
                    '  // ════ 4. CARD ═══════════════════════════════════════════\n'
                    '  Widget _buildCard(MioModello item) {\n'
                    '    return ListTile(\n'
                    '      leading: CircleAvatar(child: Text(item.id.toString())),\n'
                    '      title: Text(item.nome),\n'
                    '      // aggiungi subtitle, trailing ecc.\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            _suggerimentoCreativo(
              '🎯 Per replicare questa struttura su qualsiasi API: '
              '1) Guarda il JSON che arriva (usa Postman o il browser), '
              '2) crea il Model con quei campi esatti, '
              '3) copia il Provider cambiando solo l\'URL, '
              '4) il widget e il .when() non cambiano mai.',
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
                Expanded(
                  child: Text(
                    titolo.toUpperCase(),
                    style: TextStyle(
                      color: colore,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.5,
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

  Widget _buildStep(String step, String desc, Color colore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              step,
              style: TextStyle(
                color: colore,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPuntoChiave(String titolo, String desc, Color colore) {
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
              fontSize: 13,
            ),
          ),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12.5,
              height: 1.4,
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
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.5,
        ),
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
          height: 1.5,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);
}
