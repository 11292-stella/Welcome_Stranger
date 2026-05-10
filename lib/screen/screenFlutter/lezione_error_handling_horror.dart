import 'package:flutter/material.dart';

class LezioneErrorHandlingHorror extends StatelessWidget {
  final String titoloLezione;

  const LezioneErrorHandlingHorror({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color ghostWhite = Color(0xFFF5F5F5);
    const Color poisonPurple = Color(0xFF9C27B0);
    const Color warningYellow = Color(0xFFFFEB3B);
    const Color errorRed = Color(0xFFD32F2F);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0202), // Nero sangue
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: poisonPurple,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titoloSezione("IL CODICE DEGLI SPIRITI (STATUS CODES)"),

            // ─── 2xx: IL SUCCESSO ──────────────────────────────────────────
            _cardStatus(
              codice: "200 - 201",
              titolo: "La Luce",
              desc:
                  "Il server ha accettato il tuo sacrificio. Tutto è andato bene.",
              colore: Colors.greenAccent,
            ),

            // ─── 4xx: IL TUO ERRORE ────────────────────────────────────────
            _cardStatus(
              codice: "401 - 403",
              titolo: "Accesso Negato",
              desc:
                  "Non hai i permessi per entrare qui. Lo spirito guardiano (Token) è assente o scaduto.",
              colore: warningYellow,
            ),
            _cardStatus(
              codice: "404",
              titolo: "Il Vuoto",
              desc:
                  "Hai cercato qualcosa che non esiste più. La risorsa è svanita.",
              colore: Colors.orange,
            ),

            // ─── 5xx: L'APOCALISSE ─────────────────────────────────────────
            _cardStatus(
              codice: "500",
              titolo: "Inferno Interno",
              desc:
                  "Il server è collassato su se stesso. Non è colpa tua, ma il sistema è in fiamme.",
              colore: errorRed,
            ),

            const SizedBox(height: 30),
            _titoloSezione("TRY-CATCH: LO SCUDO"),

            _boxCodice(
              'try {\n'
              '  final res = await http.get(url);\n'
              '  if (res.statusCode != 200) throw Exception("Sacrificio respinto");\n'
              '} catch (e) {\n'
              '  // Qui catturi il demone dell\'errore\n'
              '  mostraMessaggioSpaventoso(e.toString());\n'
              '}',
            ),

            const SizedBox(height: 20),
            _notaMacabra(
              "Ricorda: Un'app che non gestisce gli errori è un'app che muore in silenzio.",
            ),
            const SizedBox(height: 30),

            // ─── TEMPLATE: ERROR HANDLING COMPLETO ───────────────
            _titoloSezione("TEMPLATE: GESTIONE ERRORI COMPLETA"),

            _cardStatus(
              codice: "STEP 1",
              titolo: "Controlla lo statusCode",
              desc:
                  "Ogni risposta HTTP ha un codice. Non dare mai per scontato che la chiamata sia andata bene — verifica sempre.",
              colore: Colors.greenAccent,
            ),
            _cardStatus(
              codice: "STEP 2",
              titolo: "Cattura le eccezioni di rete",
              desc:
                  "Se non c'è connessione, il Future lancia un'eccezione prima ancora di ricevere un statusCode. Il try/catch esterno la intercetta.",
              colore: warningYellow,
            ),
            _cardStatus(
              codice: "STEP 3",
              titolo: "Mostra feedback all'utente",
              desc:
                  "Un errore silenzioso è peggio di un crash. Mostra sempre un messaggio — anche solo uno SnackBar — così l'utente sa cosa è successo.",
              colore: Colors.orange,
            ),
            _cardStatus(
              codice: "STEP 4",
              titolo: "Lancia eccezioni tipizzate",
              desc:
                  "Usa throw Exception() con messaggi chiari invece di stampare solo in console. Chi chiama la funzione potrà catturare e gestire l'errore nel modo giusto.",
              colore: errorRed,
            ),

            _boxCodice(
              '// ── Funzione fetch con gestione errori completa ──────\n'
              'Future<List<dynamic>> fetchDati(String url) async {\n'
              '  try {\n\n'
              '    // ── STEP 1: Chiamata e controllo statusCode ────────\n'
              '    final res = await http.get(Uri.parse(url));\n\n'
              '    switch (res.statusCode) {\n'
              '      case 200:\n'
              '        return jsonDecode(res.body); // tutto ok\n'
              '      case 401:\n'
              '      case 403:\n'
              '        throw Exception("Accesso negato: token assente o scaduto");\n'
              '      case 404:\n'
              '        throw Exception("Risorsa non trovata: controlla l\'URL");\n'
              '      case 500:\n'
              '        throw Exception("Errore interno del server: riprova più tardi");\n'
              '      default:\n'
              '        throw Exception("Errore imprevisto: \${res.statusCode}");\n'
              '    }\n\n'
              '  } on SocketException {\n'
              '    // ── STEP 2: Nessuna connessione internet ──────────\n'
              '    throw Exception("Nessuna connessione internet");\n'
              '  } on TimeoutException {\n'
              '    throw Exception("Il server non risponde: timeout");\n'
              '  } catch (e) {\n'
              '    throw Exception("Errore sconosciuto: \$e");\n'
              '  }\n'
              '}\n\n'
              '// ── Nel widget: mostra il feedback ───────────────────\n'
              'Future<void> caricaDati() async {\n'
              '  try {\n'
              '    final dati = await fetchDati("https://api.esempio.com/dati");\n'
              '    setState(() => _lista = dati);\n'
              '  } catch (e) {\n'
              '    // ── STEP 3: Feedback visibile all\'utente ──────────\n'
              '    ScaffoldMessenger.of(context).showSnackBar(\n'
              '      SnackBar(\n'
              '        content: Text(e.toString()),\n'
              '        backgroundColor: Colors.red,\n'
              '      ),\n'
              '    );\n'
              '  }\n'
              '}\n\n'
              '// ── Con FutureProvider: .when() gestisce tutto ────────\n'
              'ref.watch(datiProvider).when(\n'
              '  loading: () => const CircularProgressIndicator(),\n'
              '  // ── STEP 4: Errore leggibile nel widget ───────────\n'
              '  error: (err, _) => Text(\n'
              '    err.toString(),\n'
              '    style: const TextStyle(color: Colors.red),\n'
              '  ),\n'
              '  data: (dati) => ListView.builder(\n'
              '    itemCount: dati.length,\n'
              '    itemBuilder: (context, i) => Text(dati[i].toString()),\n'
              '  ),\n'
              ')',
            ),

            const SizedBox(height: 30),

            _notaMacabra(
              'Importa dart:io per SocketException e dart:async per TimeoutException. '
              'Senza questi import i catch specifici non funzioneranno e catturerai '
              'tutto con il generico catch(e) — che è meglio di niente, ma non ti dice cosa è andato storto.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _titoloSezione(String testo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 11,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _cardStatus({
    required String codice,
    required String titolo,
    required String desc,
    required Color colore,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A0A),
        border: Border.all(color: colore.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            codice,
            style: TextStyle(
              color: colore,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titolo,
                  style: TextStyle(color: colore, fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB39DDB),
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _notaMacabra(String testo) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF311B92).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Color(0xFFD1C4E9),
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
