import 'package:flutter/material.dart';

class LezioneFormInput extends StatelessWidget {
  final String titoloLezione;

  const LezioneFormInput({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    // Palette Colori Input
    const Color inputBlue = Color(0xFF0D47A1);
    const Color controllerPurple = Color(0xFF4527A0);
    const Color validGreen = Color(0xFF2E7D32);
    const Color darkSurface = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: Text(
          titoloLezione.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: inputBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. IL CONTROLLER: IL PONTE DI COMUNICAZIONE ────────────────
            _cardLezione(
              titolo: 'TextEditingController: Il Cervello',
              colore: controllerPurple,
              icona: Icons.memory_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In Flutter, i widget di input sono "stupidi": non sanno cosa hanno scritto dentro. Il Controller è l\'oggetto esterno che tiene traccia del testo.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Lettura/Scrittura',
                    desc:
                        'Usi controller.text per leggere o cambiare il testo via codice.',
                    colore: controllerPurple,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Lifecycle',
                    desc:
                        'Deve essere creato in initState e distrutto in dispose per evitare memory leak.',
                    colore: Colors.orangeAccent,
                  ),
                  _boxCodice(
                    'late TextEditingController _nameController;\n\n'
                    '@override\n'
                    'void initState() {\n'
                    '  _nameController = TextEditingController();\n'
                    '}\n\n'
                    '@override\n'
                    'void dispose() {\n'
                    '  _nameController.dispose(); // 👈 Obbligatorio!\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 2. FORMSTATE E GLOBALKEY ────────────────────────────────────
            _cardLezione(
              titolo: 'Form e GlobalKey: Il Telecomando',
              colore: inputBlue,
              icona: Icons.app_registration_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per convalidare 10 campi insieme, non controlli ogni campo uno ad uno. Usi un Form con una GlobalKey.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _alertSuggerimento(
                    'La GlobalKey<FormState> è il "telecomando" che permette di dire al Form: "Ehi, controlla se tutti i tuoi figli sono validi!".',
                  ),
                  _boxCodice(
                    'final _formKey = GlobalKey<FormState>();\n\n'
                    'Form(\n'
                    '  key: _formKey,\n'
                    '  child: Column(children: [...]),\n'
                    ');\n\n'
                    '// Per validare tutto:\n'
                    'if (_formKey.currentState!.validate()) {\n'
                    '  // Se arrivi qui, tutti i campi sono OK\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 3. TEXTFORMFIELD E VALIDATOR ───────────────────────────────
            _cardLezione(
              titolo: 'TextFormField: La Logica',
              colore: validGreen,
              icona: Icons.fact_check_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A differenza di TextField, TextFormField ha la proprietà validator. È una funzione che analizza il testo in tempo reale.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _buildLegenda(
                    testo: 'Se restituisci una Stringa',
                    desc: 'Verrà mostrata come errore sotto il campo.',
                    colore: Colors.redAccent,
                  ),
                  _buildLegenda(
                    testo: 'Se restituisci null',
                    desc: 'Il campo è considerato valido.',
                    colore: validGreen,
                  ),
                  _boxCodice(
                    'TextFormField(\n'
                    '  validator: (valore) {\n'
                    '    if (valore!.isEmpty) return "Scrivi qualcosa!";\n'
                    '    if (valore.length < 3) return "Troppo corto!";\n'
                    '    return null; // Tutto bene\n'
                    '  },\n'
                    ')',
                  ),
                ],
              ),
            ),

            // ─── 4. FOCUS E KEYBOARD ACTIONS ────────────────────────────────
            _cardLezione(
              titolo: 'Focus e UX: Dettagli che contano',
              colore: Colors.orange.shade800,
              icona: Icons.keyboard_rounded,
              corpo: Column(
                children: [
                  _buildPuntoChiave(
                    titolo: 'TextInputAction.next',
                    desc:
                        'Fa apparire il tasto "Avanti" sulla tastiera per saltare al campo dopo.',
                    colore: Colors.orange.shade800,
                  ),
                  _buildPuntoChiave(
                    titolo: 'ObscureText',
                    desc:
                        'Indispensabile per le password (nasconde i caratteri).',
                    colore: Colors.orange.shade800,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ─── TEMPLATE: FORM COMPLETO ─────────────────────────
            _cardLezione(
              titolo: 'Template',
              colore: validGreen,
              icona: Icons.architecture_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Template pronto all\'uso per un form con più campi, validazione e gestione corretta del lifecycle dei controller.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 15),
                  _buildPuntoChiave(
                    titolo: 'Step 1 — GlobalKey e Controller',
                    desc:
                        'Dichiarati fuori dal build(), vivono per tutta la vita del widget.',
                    colore: validGreen,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 2 — initState e dispose',
                    desc:
                        'Inizializza in initState, distruggi in dispose. Senza dispose hai un memory leak.',
                    colore: Colors.orangeAccent,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 3 — TextFormField con validator',
                    desc:
                        'Restituisce una String per mostrare l\'errore, null se il campo è valido.',
                    colore: inputBlue,
                  ),
                  _buildPuntoChiave(
                    titolo: 'Step 4 — Bottone di submit',
                    desc:
                        'Chiama validate() sul form — se tutti i campi sono null procede.',
                    colore: controllerPurple,
                  ),
                  _boxCodice(
                    '// ── STEP 1: Dichiarazioni ────────────────────────────\n'
                    'final _formKey = GlobalKey<FormState>();\n'
                    'late TextEditingController _nomeController;\n'
                    'late TextEditingController _emailController;\n'
                    'late TextEditingController _passwordController;\n\n'
                    '// ── STEP 2: Lifecycle ────────────────────────────────\n'
                    '@override\n'
                    'void initState() {\n'
                    '  super.initState();\n'
                    '  _nomeController = TextEditingController();\n'
                    '  _emailController = TextEditingController();\n'
                    '  _passwordController = TextEditingController();\n'
                    '}\n\n'
                    '@override\n'
                    'void dispose() {\n'
                    '  _nomeController.dispose();     // obbligatorio per ogni controller\n'
                    '  _emailController.dispose();\n'
                    '  _passwordController.dispose();\n'
                    '  super.dispose();\n'
                    '}\n\n'
                    '// ── STEP 3: Il Form ──────────────────────────────────\n'
                    'Form(\n'
                    '  key: _formKey,\n'
                    '  child: Column(\n'
                    '    children: [\n\n'
                    '      TextFormField(\n'
                    '        controller: _nomeController,\n'
                    '        decoration: const InputDecoration(labelText: "Nome"),\n'
                    '        textInputAction: TextInputAction.next, // tasto "Avanti"\n'
                    '        validator: (v) {\n'
                    '          if (v == null || v.isEmpty) return "Campo obbligatorio";\n'
                    '          if (v.length < 2) return "Troppo corto";\n'
                    '          return null; // valido\n'
                    '        },\n'
                    '      ),\n\n'
                    '      TextFormField(\n'
                    '        controller: _emailController,\n'
                    '        decoration: const InputDecoration(labelText: "Email"),\n'
                    '        keyboardType: TextInputType.emailAddress,\n'
                    '        textInputAction: TextInputAction.next,\n'
                    '        validator: (v) {\n'
                    '          if (v == null || v.isEmpty) return "Campo obbligatorio";\n'
                    '          if (!v.contains("@")) return "Email non valida";\n'
                    '          return null;\n'
                    '        },\n'
                    '      ),\n\n'
                    '      TextFormField(\n'
                    '        controller: _passwordController,\n'
                    '        decoration: const InputDecoration(labelText: "Password"),\n'
                    '        obscureText: true,              // nasconde i caratteri\n'
                    '        textInputAction: TextInputAction.done,\n'
                    '        validator: (v) {\n'
                    '          if (v == null || v.isEmpty) return "Campo obbligatorio";\n'
                    '          if (v.length < 6) return "Minimo 6 caratteri";\n'
                    '          return null;\n'
                    '        },\n'
                    '      ),\n\n'
                    '      // ── STEP 4: Submit ──────────────────────────────\n'
                    '      ElevatedButton(\n'
                    '        onPressed: () {\n'
                    '          if (_formKey.currentState!.validate()) {\n'
                    '            // tutti i validator hanno restituito null\n'
                    '            final nome = _nomeController.text;\n'
                    '            final email = _emailController.text;\n'
                    '            // procedi con login, registrazione, ecc.\n'
                    '          }\n'
                    '        },\n'
                    '        child: const Text("Invia"),\n'
                    '      ),\n'
                    '    ],\n'
                    '  ),\n'
                    ')',
                  ),
                ],
              ),
            ),

            _alertSuggerimento(
              '⚠️ Ogni TextEditingController che crei in initState DEVE avere il suo dispose(). '
              'Dimenticarne anche uno causa un memory leak che rallenta l\'app nel tempo.',
            ),

            _suggerimentoCreativo(
              '🚀 Sfida: Prova a usare InputBorder.none per creare campi di testo minimalisti senza la classica linea sotto!',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI DI SUPPORTO ──────────────────────────────────────────────

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

  Widget _buildLegenda({
    required String testo,
    required String desc,
    required Color colore,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.white70),
          children: [
            TextSpan(
              text: '$testo: ',
              style: TextStyle(fontWeight: FontWeight.bold, color: colore),
            ),
            TextSpan(text: desc),
          ],
        ),
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
      margin: const EdgeInsets.only(bottom: 15),
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
        border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
      ),
      child: Text(
        "💡 $testo",
        style: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  TextStyle _stileTestoBase() =>
      const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6);
}
