import 'package:flutter/material.dart';

class LezioneNetworkingIntro extends StatelessWidget {
  final String titoloLezione;

  const LezioneNetworkingIntro({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color acidGreen = Color(0xFFC6FF00); // Verde radioattivo per le API
    const Color bloodRed = Color(0xFFFF1744); // Rosso per gli errori/alert
    const Color cyberBlue = Color(0xFF00E5FF); // Cyan per il networking

    return Scaffold(
      backgroundColor: const Color(0xFF080808), // Nero profondo
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 3,
            color: acidGreen,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        shadowColor: acidGreen.withOpacity(0.5),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── IL CONCETTO: IL MESSAGGERO OSCURO ──────────────────────────
            _cardLezione(
              titolo: 'Le API: Il Messaggero del Vuoto',
              colore: acidGreen,
              icona: Icons.leak_add_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'La tua app è un guscio vuoto. Il Back-end è un cervello remoto immerso nell\'oscurità. Le API sono il cordone ombelicale che li unisce.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Request',
                    desc: 'Lanci un segnale nel vuoto chiedendo dati.',
                    colore: cyberBlue,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Response',
                    desc:
                        'Il server ti risponde. Se sei fortunato, avrai i dati. Se fallisci, avrai il silenzio (o un errore 404).',
                    colore: bloodRed,
                  ),
                ],
              ),
            ),

            // ─── IL LINGUAGGIO: JSON (IL CODICE CRIPTATO) ────────────────────
            _cardLezione(
              titolo: 'JSON: La Lingua delle Macchine',
              colore: const Color(0xFFFFD600),
              icona: Icons.terminal_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il server non parla Dart. Ti spedisce blocchi di testo chiamati JSON. Sembrano mappe, ma sono stringhe fredde che devi decifrare.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '{\n'
                    '  "status": "online",\n'
                    '  "payload": "Dati sensibili",\n'
                    '  "nodes": [102, 405, 909]\n'
                    '}',
                  ),
                  _alertSuggerimento(
                    'ATTENZIONE: Se dimentichi una virgola nel JSON, l\'intera comunicazione collasserà all\'istante.',
                  ),
                ],
              ),
            ),

            // ─── IL PACCHETTO HTTP: IL TUO RADAR ─────────────────────────────
            _cardLezione(
              titolo: 'Pacchetto HTTP: Navigare nel Buio',
              colore: cyberBlue,
              icona: Icons.settings_remote_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per inviare segnali usiamo la libreria `http`. È il tuo radar per intercettare risposte dai server remoti.',
                    style: _stileTestoBase(),
                  ),

                  _boxCodice(
                    '// Invocazione del demone remoto\n'
                    'final res = await http.get(Uri.parse(url));\n\n'
                    'if (res.statusCode == 200) {\n'
                    '  // Il server ha risposto... per ora.\n'
                    '  var data = jsonDecode(res.body);\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── CHIAMATA HTTP COMPLETA ───────────────────────────
            _cardLezione(
              titolo: 'Anatomia di una Chiamata Reale',
              colore: cyberBlue,
              icona: Icons.biotech_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Una chiamata HTTP non è solo una riga. Ha tre fasi: la preparazione, l\'attesa, e la gestione della risposta — inclusi i casi di errore.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 10),
                  _buildPuntoChiave(
                    titolo: 'Status 200',
                    desc:
                        'La richiesta è andata a buon fine. I dati sono nel body.',
                    colore: acidGreen,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Status 404',
                    desc:
                        'La risorsa non esiste sul server. URL sbagliato o dato eliminato.',
                    colore: bloodRed,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Status 500',
                    desc:
                        'Errore interno del server. Non dipende da te, ma devi gestirlo lo stesso.',
                    colore: Colors.orange,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Exception di rete',
                    desc:
                        'Nessuna connessione internet. Il Future lancia un\'eccezione — catturala sempre con try/catch.',
                    colore: Colors.amber,
                  ),
                ],
              ),
            ),

            _boxCodice(
              '// Aggiungi al pubspec.yaml:\n'
              '// dependencies:\n'
              '//   http: ^1.2.0\n\n'
              'import \'package:http/http.dart\' as http;\n'
              'import \'dart:convert\';\n\n'
              'Future<Map<String, dynamic>> fetchDati() async {\n'
              '  // try/catch obbligatorio: la rete può sempre fallire\n'
              '  try {\n'
              '    final response = await http.get(\n'
              '      Uri.parse("https://api.esempio.com/dati"),\n'
              '      headers: {"Content-Type": "application/json"},\n'
              '    );\n\n'
              '    if (response.statusCode == 200) {\n'
              '      // jsonDecode converte la stringa in una Map Dart\n'
              '      return jsonDecode(response.body);\n'
              '    } else {\n'
              '      // il server ha risposto ma con un errore\n'
              '      throw Exception("Errore \${response.statusCode}");\n'
              '    }\n'
              '  } catch (e) {\n'
              '    // nessuna connessione o timeout\n'
              '    throw Exception("Connessione fallita: \$e");\n'
              '  }\n'
              '}',
            ),

            const SizedBox(height: 20),

            _cardLezione(
              titolo: 'Template: Fetch con Riverpod',
              colore: acidGreen,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il pattern completo: un Data Model che protegge i dati, un FutureProvider che li carica, un widget che gestisce i tre stati.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 10),
                  _buildPuntoChiave(
                    titolo: 'Step 1',
                    desc:
                        'Definisci il Data Model con fromJson per proteggere i dati grezzi.',
                    colore: acidGreen,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 2',
                    desc: 'Crea la funzione async con http.get e try/catch.',
                    colore: cyberBlue,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 3',
                    desc: 'Dichiara un FutureProvider che chiama la funzione.',
                    colore: Colors.amber,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 4',
                    desc:
                        'Nel widget usa .when() per gestire loading, error e data.',
                    colore: bloodRed,
                  ),
                  _boxCodice(
                    '// ── STEP 1: Data Model ───────────────────────────────\n'
                    'class Prodotto {\n'
                    '  final String id;\n'
                    '  final String nome;\n'
                    '  final double prezzo;\n\n'
                    '  const Prodotto({required this.id, required this.nome, required this.prezzo});\n\n'
                    '  factory Prodotto.fromJson(Map<String, dynamic> json) {\n'
                    '    return Prodotto(\n'
                    '      id: json["id"]?.toString() ?? "0",\n'
                    '      nome: json["name"] as String? ?? "Sconosciuto",\n'
                    '      prezzo: (json["price"] as num?)?.toDouble() ?? 0.0,\n'
                    '    );\n'
                    '  }\n'
                    '}\n\n'
                    '// ── STEP 2: Funzione fetch ────────────────────────────\n'
                    'Future<List<Prodotto>> fetchProdotti() async {\n'
                    '  try {\n'
                    '    final res = await http.get(Uri.parse("https://api.esempio.com/prodotti"));\n'
                    '    if (res.statusCode == 200) {\n'
                    '      final List<dynamic> lista = jsonDecode(res.body);\n'
                    '      return lista.map((e) => Prodotto.fromJson(e)).toList();\n'
                    '    } else {\n'
                    '      throw Exception("Errore \${res.statusCode}");\n'
                    '    }\n'
                    '  } catch (e) {\n'
                    '    throw Exception("Connessione fallita: \$e");\n'
                    '  }\n'
                    '}\n\n'
                    '// ── STEP 3: FutureProvider ────────────────────────────\n'
                    'final prodottiProvider = FutureProvider<List<Prodotto>>((ref) {\n'
                    '  return fetchProdotti();\n'
                    '});\n\n'
                    '// ── STEP 4: Widget con .when() ────────────────────────\n'
                    'class ProdottiView extends ConsumerWidget {\n'
                    '  @override\n'
                    '  Widget build(BuildContext context, WidgetRef ref) {\n'
                    '    return ref.watch(prodottiProvider).when(\n'
                    '      loading: () => const CircularProgressIndicator(),\n'
                    '      error: (err, _) => Text("Errore: \$err"),\n'
                    '      data: (prodotti) => ListView.builder(\n'
                    '        itemCount: prodotti.length,\n'
                    '        itemBuilder: (context, i) => ListTile(\n'
                    '          title: Text(prodotti[i].nome),\n'
                    '          trailing: Text("\${prodotti[i].prezzo}€"),\n'
                    '        ),\n'
                    '      ),\n'
                    '    );\n'
                    '  }\n'
                    '}',
                  ),
                ],
              ),
            ),

            _alertSuggerimento(
              'ATTENZIONE: Non dimenticare di aggiungere il permesso internet nel file AndroidManifest.xml: '
              '<uses-permission android:name="android.permission.INTERNET" />. '
              'Senza questa riga tutte le chiamate falliranno in silenzio sul dispositivo fisico.',
            ),

            const SizedBox(height: 30),
            _suggerimentoCreativo(
              '💀 Warning: Il web è pieno di pericoli. Nella prossima lezione impareremo il CRUD: come creare, distruggere e manipolare i dati nel database remoto senza farsi bruciare.',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI HORROR-TECH ───────────────────────────────────────

  Widget _cardLezione({
    required String titolo,
    required Color colore,
    required IconData icona,
    required Widget corpo,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colore.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: colore.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
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
              border: Border(
                bottom: BorderSide(color: colore.withOpacity(0.3)),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 20),
                const SizedBox(width: 12),
                Text(
                  titolo.toUpperCase(),
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
          Text(
            '>',
            style: TextStyle(
              color: colore,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  height: 1.4,
                ),
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
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFF76FF03),
          fontFamily: 'monospace',
          fontSize: 11,
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
        border: Border(
          left: BorderSide(color: Colors.amber.shade900, width: 4),
        ),
        color: Colors.amber.withOpacity(0.05),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white60, fontSize: 14, height: 1.6);
}
