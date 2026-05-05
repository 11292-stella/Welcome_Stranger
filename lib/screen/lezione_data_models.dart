import 'package:flutter/material.dart';

class LezioneDataModels extends StatelessWidget {
  final String titoloLezione;

  const LezioneDataModels({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRO: PERCHÉ I MODELLI ───────────────────────────────────
            _cardLezione(
              titolo: '📦 Perché usare i Modelli?',
              colore: Colors.brown.shade700,
              icona: Icons.inventory_2_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I Data Models sono "contenitori intelligenti" per i tuoi dati. '
                    'Senza di essi, saresti costretto a usare mappe generiche, rischiando errori di battitura fatali.\n\n'
                    'Esempio di rischio:\n'
                    'Map<String, dynamic> utente = {"nome": "Mario"}\n'
                    'Se scrivi utente["nmoe"], l\'app crasha solo quando la avvii.\n\n'
                    'Con un modello, l\'editor ti avvisa dell\'errore mentre scrivi.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Sicurezza Totale',
                    'Sai sempre se un dato è una Stringa, un numero o una lista.',
                  ),
                  _elementoLista(
                    'Suggerimenti automatici',
                    'Scrivi "utente." e l\'IDE ti mostra subito cosa puoi usare.',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 1: ANATOMIA ────────────────────────────────────────
            _cardLezione(
              titolo: '1. Anatomia di un Modello Dart',
              colore: Colors.blueGrey.shade800,
              icona: Icons.code_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In Dart usiamo parametri nominati tra {}. Questo rende chiaro cosa stiamo assegnando a colpo d\'occhio.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '// Dichiarazione pulita ed esplicita\n'
                    'const Utente({\n'
                    '  required this.id, \n'
                    '  required this.nome\n'
                    '});\n\n'
                    '// Utilizzo sicuro\n'
                    'final u = Utente(id: "1", nome: "Mario");',
                  ),
                  _suggerimentoCreativo(
                    '💡 Nota: Non servono i "Getter". Se dichiari "final String nome", '
                    'accedi al dato semplicemente con "utente.nome".',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 2: IL MIRACOLO DEL FROMJSON ────────────────────────
            _cardLezione(
              titolo: '2. Factory Constructor: Il Filtro Dati',
              colore: Colors.teal.shade800,
              icona: Icons.settings_ethernet_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il factory "fromJson" è il ponte tra il web e la tua app. '
                    'Serve a "pulire" i dati grezzi prima che entrino nel tuo codice.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'factory Utente.fromJson(Map<String, dynamic> json) {\n'
                    '  return Utente(\n'
                    '    // toString() e ?? ci salvano dai dati nulli o errati\n'
                    '    id: json["id"]?.toString() ?? "0",\n'
                    '    nome: json["full_name"] as String? ?? "Anonimo",\n'
                    '    // Protezione per i decimali\n'
                    '    saldo: (json["balance"] as num?)?.toDouble() ?? 0.0,\n'
                    '  );\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 3: COPYWITH ────────────────────────────────────────
            _cardLezione(
              titolo: '3. copyWith: Modificare in sicurezza',
              colore: Colors.deepOrange.shade800,
              icona: Icons.content_copy_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In Flutter non modifichiamo gli oggetti esistenti. Ne creiamo una copia con la modifica desiderata. '
                    'Questo permette a Riverpod e Flutter di accorgersi del cambiamento e aggiornare l\'interfaccia.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'Utente copyWith({String? nome, double? saldo}) {\n'
                    '  return Utente(\n'
                    '    id: this.id, // L\'id non cambia mai\n'
                    '    nome: nome ?? this.nome, \n'
                    '    saldo: saldo ?? this.saldo,\n'
                    '  );\n'
                    '}',
                  ),
                  _suggerimentoCreativo(
                    '💡 Esempio: utente = utente.copyWith(nome: "Luca");\n'
                    'Hai creato un nuovo utente "Luca" mantenendo l\'ID di quello precedente.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _alertSuggerimento(
              '🎯 CONCLUSIONE: I modelli proteggono la tua app. '
              'I dati entrano come JSON disordinati, vengono filtrati dal fromJson e '
              'diventano oggetti solidi pronti per essere mostrati nei tuoi Widget.',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // --- Helper per lo stile (metodini interni per pulizia) ---
  TextStyle _stileTestoBase() =>
      const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4);

  Widget _boxCodice(String codice) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'monospace',
          fontSize: 13,
        ),
      ),
    );
  }
}
//─── COMPONENTI GRAFICI DI SUPPORTO  ──────────────────

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
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: colore.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colore.withOpacity(0.05),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Row(
            children: [
              Icon(icona, color: colore, size: 28),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  titolo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: colore,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(22), child: corpo),
      ],
    ),
  );
}

Widget _boxCodice(String codice) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF232931),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.deepOrange.shade200.withOpacity(0.3)),
    ),
    child: Text(
      codice,
      style: const TextStyle(
        color: Color(0xFFB2FF59),
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.5,
      ),
    ),
  );
}

Widget _suggerimentoCreativo(String testo) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.deepOrange.shade100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lightbulb_outline, color: Colors.deepOrange.shade700),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            testo,
            style: TextStyle(
              color: Colors.deepOrange.shade900,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _alertSuggerimento(String testo) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Text(
      testo,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 15,
        height: 1.5,
      ),
    ),
  );
}

TextStyle _stileTestoBase() =>
    const TextStyle(color: Color(0xFF37474F), fontSize: 15, height: 1.7);

// Questo mancava ed è fondamentale per i titoli in grassetto colorati
Widget _testoBold(String testo, Color colore) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      testo,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: colore,
        fontSize: 16,
      ),
    ),
  );
}

// Questo mancava: serve per creare i punti elenco con termine e descrizione
Widget _elementoLista(String termine, String descrizione) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: RichText(
      text: TextSpan(
        style: _stileTestoBase(),
        children: [
          TextSpan(
            text: '• $termine: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextSpan(text: descrizione),
        ],
      ),
    ),
  );
}

// Questo serve per evidenziare il codice inline tipo `setState`
TextSpan _testoCodiceInline(String testo) {
  return TextSpan(
    text: ' `$testo` ',
    style: TextStyle(
      fontFamily: 'monospace',
      color: Colors.pink.shade700,
      fontWeight: FontWeight.bold,
      backgroundColor: Colors.grey.shade200,
    ),
  );
}
