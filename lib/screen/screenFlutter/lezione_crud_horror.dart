import 'package:flutter/material.dart';

class LezioneCRUDHorror extends StatelessWidget {
  final String titoloLezione;

  const LezioneCRUDHorror({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color neonGreen = Color(0xFF39FF14); // CREATE
    const Color soulBlue = Color(0xFF00B0FF); // READ
    const Color warningOrange = Color(0xFFFF6D00); // UPDATE
    const Color deathRed = Color(0xFFFF1744); // DELETE

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: deathRed,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSezione("IL RITUALE DELLE 4 OPERAZIONI"),

            // ─── CREATE (POST) ──────────────────────────────────────────────
            _cardCRUD(
              fase: 'C - CREATE',
              metodo: 'POST',
              colore: neonGreen,
              desc:
                  'Inietti nuova vita nel database. Stai creando un record dove prima c\'era solo il vuoto.',
              codice:
                  'await http.post(\n  url,\n  body: jsonEncode({"name": "Nuova Entità"}),\n);',
            ),

            // ─── READ (GET) ────────────────────────────────────────────────
            _cardCRUD(
              fase: 'R - READ',
              metodo: 'GET',
              colore: soulBlue,
              desc:
                  'Osservi nell\'abisso. Chiedi al server di mostrarti ciò che custodisce.',
              codice:
                  'final response = await http.get(url);\nif (response.statusCode == 200) {\n  // Dati estratti con successo\n}',
            ),

            // ─── UPDATE (PUT/PATCH) ────────────────────────────────────────
            _cardCRUD(
              fase: 'U - UPDATE',
              metodo: 'PUT / PATCH',
              colore: warningOrange,
              desc:
                  'Modifichi l\'esistente. Cambi i connotati a un dato già presente. È una mutazione genetica.',
              codice:
                  'await http.put(\n  url,\n  body: jsonEncode({"status": "corrotto"}),\n);',
            ),

            // ─── DELETE (DELETE) ───────────────────────────────────────────
            _cardCRUD(
              fase: 'D - DELETE',
              metodo: 'DELETE',
              colore: deathRed,
              desc:
                  'L\'esecuzione finale. Rimuovi ogni traccia dell\'entità dal database. Non si torna indietro.',
              codice: 'await http.delete(url); // Addio per sempre.',
            ),

            const SizedBox(height: 30),
            _warningPanel(
              '⚠️ ATTENZIONE: Ogni operazione CRUD restituisce un "Codice di Stato". '
              '201 significa "Creato", 200 "OK", ma se vedi un 500... il server è esploso.',
            ),
            const SizedBox(height: 30),

            // ─── TEMPLATE: CRUD COMPLETO ──────────────────────────
            _headerSezione("TEMPLATE: CRUD COMPLETO CON GESTIONE ERRORI"),

            _cardCRUD(
              fase: 'C - CREATE (POST)',
              metodo: 'POST',
              colore: neonGreen,
              desc:
                  'Invia un nuovo oggetto al server. Il body deve essere jsonEncode di una Map. Il server risponde con 201 se il record è stato creato.',
              codice:
                  'Future<void> creaProdotto(String nome, double prezzo) async {\n'
                  '  try {\n'
                  '    final res = await http.post(\n'
                  '      Uri.parse("https://api.esempio.com/prodotti"),\n'
                  '      headers: {"Content-Type": "application/json"},\n'
                  '      body: jsonEncode({"nome": nome, "prezzo": prezzo}),\n'
                  '    );\n'
                  '    if (res.statusCode == 201) {\n'
                  '      print("Creato: \${res.body}");\n'
                  '    } else {\n'
                  '      throw Exception("Errore \${res.statusCode}");\n'
                  '    }\n'
                  '  } catch (e) {\n'
                  '    throw Exception("POST fallito: \$e");\n'
                  '  }\n'
                  '}',
            ),

            _cardCRUD(
              fase: 'R - READ (GET)',
              metodo: 'GET',
              colore: soulBlue,
              desc:
                  'Legge i dati dal server. Non ha body. Il server risponde con 200 e i dati in formato JSON da decodificare con jsonDecode.',
              codice:
                  'Future<List<Map<String, dynamic>>> leggiProdotti() async {\n'
                  '  try {\n'
                  '    final res = await http.get(\n'
                  '      Uri.parse("https://api.esempio.com/prodotti"),\n'
                  '    );\n'
                  '    if (res.statusCode == 200) {\n'
                  '      final List<dynamic> lista = jsonDecode(res.body);\n'
                  '      return lista.cast<Map<String, dynamic>>();\n'
                  '    } else {\n'
                  '      throw Exception("Errore \${res.statusCode}");\n'
                  '    }\n'
                  '  } catch (e) {\n'
                  '    throw Exception("GET fallito: \$e");\n'
                  '  }\n'
                  '}',
            ),

            _cardCRUD(
              fase: 'U - UPDATE (PUT / PATCH)',
              metodo: 'PUT / PATCH',
              colore: warningOrange,
              desc:
                  'PUT sostituisce l\'intero oggetto, PATCH modifica solo i campi che passi. L\'ID del record da modificare va nell\'URL, non nel body.',
              codice:
                  'Future<void> aggiornaProdotto(String id, String nuovoNome) async {\n'
                  '  try {\n'
                  '    // PUT: sostituisce tutto\n'
                  '    final resPut = await http.put(\n'
                  '      Uri.parse("https://api.esempio.com/prodotti/\$id"),\n'
                  '      headers: {"Content-Type": "application/json"},\n'
                  '      body: jsonEncode({"nome": nuovoNome, "prezzo": 99.9}),\n'
                  '    );\n\n'
                  '    // PATCH: modifica solo il campo nome\n'
                  '    final resPatch = await http.patch(\n'
                  '      Uri.parse("https://api.esempio.com/prodotti/\$id"),\n'
                  '      headers: {"Content-Type": "application/json"},\n'
                  '      body: jsonEncode({"nome": nuovoNome}), // solo il campo cambiato\n'
                  '    );\n\n'
                  '    if (resPatch.statusCode != 200) {\n'
                  '      throw Exception("Errore \${resPatch.statusCode}");\n'
                  '    }\n'
                  '  } catch (e) {\n'
                  '    throw Exception("UPDATE fallito: \$e");\n'
                  '  }\n'
                  '}',
            ),

            _cardCRUD(
              fase: 'D - DELETE',
              metodo: 'DELETE',
              colore: deathRed,
              desc:
                  'Elimina il record dal server. L\'ID va nell\'URL. Non ha body. Il server risponde con 200 o 204 (No Content) se l\'eliminazione è andata a buon fine.',
              codice:
                  'Future<void> eliminaProdotto(String id) async {\n'
                  '  try {\n'
                  '    final res = await http.delete(\n'
                  '      Uri.parse("https://api.esempio.com/prodotti/\$id"),\n'
                  '    );\n'
                  '    // 200 = OK con body, 204 = OK senza body\n'
                  '    if (res.statusCode != 200 && res.statusCode != 204) {\n'
                  '      throw Exception("Errore \${res.statusCode}");\n'
                  '    }\n'
                  '  } catch (e) {\n'
                  '    throw Exception("DELETE fallito: \$e");\n'
                  '  }\n'
                  '}',
            ),

            _warningPanel(
              '⚠️ REGOLA D\'ORO: l\'ID del record va SEMPRE nell\'URL (/prodotti/123), '
              'mai nel body. Il body serve solo per i dati da creare o modificare. '
              'Confondere i due è la causa numero uno di errori 404 e 400.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSezione(String testo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 12,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _cardCRUD({
    required String fase,
    required String metodo,
    required Color colore,
    required String desc,
    required String codice,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        border: Border(left: BorderSide(color: colore, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fase,
                  style: TextStyle(
                    color: colore,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colore.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    metodo,
                    style: TextStyle(
                      color: colore,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              desc,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          _boxCodice(codice),
        ],
      ),
    );
  }

  Widget _boxCodice(String codice) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFF00FF41),
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _warningPanel(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withOpacity(0.5)),
        gradient: LinearGradient(
          colors: [Colors.red.withOpacity(0.1), Colors.transparent],
        ),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Color(0xFFFF8A80),
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
