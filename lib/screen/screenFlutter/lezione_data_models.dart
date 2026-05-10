import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LezioneDataModels extends StatelessWidget {
  final String titoloLezione;

  const LezioneDataModels({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color rustOrange = Color(0xFFD84315); // Arancio ruggine profondo
    const Color industrialGold = Color(0xFFFFB300);
    const Color darkSurface = Color(0xFF121212);
    const Color cyberBlue = Color(0xFF64FFDA);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: darkSurface,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: rustOrange),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: rustOrange.withOpacity(0.3), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRO: PERCHÉ I MODELLI ───────────────────────────────────
            _cardLezione(
              titolo: 'Protocollo: Sicurezza Dati',
              colore: rustOrange,
              icona: Icons.inventory_2_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'I Data Models sono "contenitori atomici" per i dati. Senza di essi, il sistema si affida a ',
                    ),
                    _testoBold('Mappe generiche', industrialGold),
                    const TextSpan(
                      text:
                          ', esponendo l\'interfaccia a errori di battitura fatali.\n\n',
                    ),
                    _elementoLista(
                      'Prevenzione Crash',
                      'L\'editor rileva chiavi errate prima della compilazione.\n',
                      rustOrange,
                    ),
                    _elementoLista(
                      'Auto-Completamento',
                      'L\'IDE suggerisce i campi disponibili in tempo reale.\n\n',
                      rustOrange,
                    ),
                    const TextSpan(text: 'Esempio di instabilità: '),
                    _testoCodiceInline('utente["nmoe"]'),
                    const TextSpan(
                      text:
                          ' causerà un crash solo a runtime. Un modello impedisce questa anomalia.',
                    ),
                  ],
                ),
              ),
            ),

            // ─── SEZIONE 1: ANATOMIA ────────────────────────────────────────
            _cardLezione(
              titolo: '1. Architettura del Modello',
              colore: Colors.blueGrey,
              icona: Icons.code_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'In Dart, sfruttiamo i '),
                    _testoBold('Costruttori Nominati', Colors.white),
                    const TextSpan(
                      text:
                          ' per garantire che ogni assegnazione sia esplicita e leggibile.\n\n',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              '// Definizione della struttura\n'
              'const Utente({\n'
              '  required this.id,\n'
              '  required this.nome,\n'
              '});\n\n'
              '// Istanza protetta\n'
              'final u = Utente(id: "001", nome: "Soggetto A");',
            ),

            _suggerimentoCreativo(
              '🛠️ OTTIMIZZAZIONE: Non usare i Getter classici. Dichiarando "final String nome", '
              'rendi il dato accessibile e immutabile con una sintassi minima.',
            ),

            const SizedBox(height: 30),

            // ─── SEZIONE 2: FROMJSON ────────────────────────────────────────
            _cardLezione(
              titolo: '2. Filtro Entrate: fromJson',
              colore: cyberBlue,
              icona: Icons.settings_ethernet_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Il factory '),
                    _testoBold('fromJson', cyberBlue),
                    const TextSpan(
                      text:
                          ' funge da membrana protettiva. "Pulisce" e valida i dati grezzi estratti dal web prima che contaminino il sistema.\n\n',
                    ),
                    _sottoTitolo('━━ Meccanismo di Difesa ━━', cyberBlue),
                    _elementoLista(
                      'Null Safety',
                      'Uso di ?? per fornire valori di fallback.\n',
                      cyberBlue,
                    ),
                    _elementoLista(
                      'Type Casting',
                      'Conversione forzata per evitare mismatch di tipi.',
                      cyberBlue,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'factory Utente.fromJson(Map<String, dynamic> json) {\n'
              '  return Utente(\n'
              '    id: json["id"]?.toString() ?? "0",\n'
              '    nome: json["full_name"] as String? ?? "Anonimo",\n'
              '    saldo: (json["balance"] as num?)?.toDouble() ?? 0.0,\n'
              '  );\n'
              '}',
            ),

            const SizedBox(height: 30),

            // ─── SEZIONE 3: COPYWITH ────────────────────────────────────────
            _cardLezione(
              titolo: '3. Persistenza: copyWith',
              colore: industrialGold,
              icona: Icons.content_copy_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Per preservare l\'immutabilità, non modifichiamo mai un oggetto. Ne generiamo una ',
                    ),
                    _testoBold('Copia Evoluta', industrialGold),
                    const TextSpan(text: '.\n\n'),
                    const TextSpan(
                      text:
                          'Questo permette a sistemi come Riverpod di intercettare il cambio di stato e rigenerare la UI in modo atomico.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'Utente copyWith({String? nome, double? saldo}) {\n'
              '  return Utente(\n'
              '    id: this.id, // L\'identità non muta\n'
              '    nome: nome ?? this.nome,\n'
              '    saldo: saldo ?? this.saldo,\n'
              '  );\n'
              '}',
            ),

            const SizedBox(height: 25),

            _alertSuggerimento(
              '🎯 CONCLUSIONE: I modelli sono lo scudo della tua applicazione. '
              'Trasformano JSON caotici in oggetti solidi, garantendo che ogni byte '
              'sia tipizzato e sicuro prima di raggiungere i Widget.',
            ),

            const SizedBox(height: 50),
            // ─── SEZIONE 4: TEMPLATE COMPLETO DATA MODEL ─────────
            _cardLezione(
              titolo: '4. Template: Data Model Completo',
              colore: cyberBlue,
              icona: Icons.architecture_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Template pronto all\'uso. Rinomina la classe e sostituisci i campi con i tuoi dati — la struttura è già completa e sicura.\n\n',
                    ),
                    _elementoLista(
                      'Step 1',
                      'Definisci i campi final con i loro tipi.\n',
                      cyberBlue,
                    ),
                    _elementoLista(
                      'Step 2',
                      'Crea il costruttore con i parametri required.\n',
                      cyberBlue,
                    ),
                    _elementoLista(
                      'Step 3',
                      'Implementa fromJson per leggere dati dal web.\n',
                      cyberBlue,
                    ),
                    _elementoLista(
                      'Step 4',
                      'Implementa copyWith per modifiche immutabili.',
                      cyberBlue,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'class MioModello {\n\n'
              '  // ── STEP 1: Campi immutabili ──────────────────────\n'
              '  final String id;\n'
              '  final String nome;        // sostituisci con i tuoi campi\n'
              '  final double valore;      // int, bool, String, ecc.\n'
              '  final String? opzionale;  // nullable se può essere null\n\n'
              '  // ── STEP 2: Costruttore ───────────────────────────\n'
              '  const MioModello({\n'
              '    required this.id,\n'
              '    required this.nome,\n'
              '    required this.valore,\n'
              '    this.opzionale,          // non required se nullable\n'
              '  });\n\n'
              '  // ── STEP 3: fromJson ─────────────────────────────\n'
              '  factory MioModello.fromJson(Map<String, dynamic> json) {\n'
              '    return MioModello(\n'
              '      id: json["id"]?.toString() ?? "0",\n'
              '      nome: json["nome"] as String? ?? "Sconosciuto",\n'
              '      valore: (json["valore"] as num?)?.toDouble() ?? 0.0,\n'
              '      opzionale: json["opzionale"] as String?,\n'
              '    );\n'
              '  }\n\n'
              '  // ── STEP 4: copyWith ─────────────────────────────\n'
              '  MioModello copyWith({\n'
              '    String? nome,\n'
              '    double? valore,\n'
              '    String? opzionale,\n'
              '  }) {\n'
              '    return MioModello(\n'
              '      id: id,                        // id non si modifica mai\n'
              '      nome: nome ?? this.nome,\n'
              '      valore: valore ?? this.valore,\n'
              '      opzionale: opzionale ?? this.opzionale,\n'
              '    );\n'
              '  }\n'
              '}',
            ),

            _suggerimentoCreativo(
              'Per ogni campo in fromJson segui sempre questo schema: '
              'json["chiave_esatta_dal_server"] as Tipo? ?? valoreDiDefault. '
              'Il ?? ti salva dai crash quando il server restituisce null inattesi.',
            ),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI SUPPORTO ──────────────────────────────────────────

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
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colore.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colore.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(icona, color: colore, size: 24),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    titolo.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colore,
                      letterSpacing: 0.5,
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
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        codice,
        style: const TextStyle(
          color: Color(0xFFB2FF59),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _suggerimentoCreativo(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D121F),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.build_circle_outlined,
            color: Colors.orangeAccent,
            size: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 13,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertSuggerimento(String testo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1500),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.amberAccent,
          fontSize: 14,
          height: 1.6,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14, height: 1.6);

  TextSpan _testoBold(String testo, Color colore) {
    return TextSpan(
      text: testo,
      style: TextStyle(fontWeight: FontWeight.bold, color: colore),
    );
  }

  TextSpan _testoCodiceInline(String testo) {
    return TextSpan(
      text: ' $testo ',
      style: const TextStyle(
        fontFamily: 'monospace',
        color: Color(0xFFB2FF59),
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.white10,
      ),
    );
  }

  TextSpan _sottoTitolo(String testo, Color colore) {
    return TextSpan(
      text: '\n$testo\n',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: colore,
        fontSize: 11,
        letterSpacing: 1.0,
        height: 2.5,
      ),
    );
  }

  TextSpan _elementoLista(String termine, String descrizione, Color colore) {
    return TextSpan(
      children: [
        TextSpan(
          text: '• $termine: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colore.withOpacity(0.7),
          ),
        ),
        TextSpan(text: descrizione),
      ],
    );
  }
}
