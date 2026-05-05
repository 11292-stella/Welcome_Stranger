import 'package:flutter/material.dart';

class LezioneFormInput extends StatelessWidget {
  final String titoloLezione;

  const LezioneFormInput({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor:
            Colors.blue.shade900, // Cambiamo colore per questa categoria
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── INTRODUZIONE ──────────────────────────────────────────────
            _cardLezione(
              titolo: '⌨️ L\'interazione con l\'utente',
              colore: Colors.blue.shade800,
              icona: Icons.edit_note_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gestire l\'input significa catturare ciò che l\'utente scrive o seleziona. In Flutter abbiamo due modi principali:\n',
                    style: _stileTestoBase(),
                  ),
                  _elementoLista(
                    'TextField',
                    'Per input semplici (una ricerca, un commento veloce).',
                  ),
                  _elementoLista(
                    'Form + TextFormField',
                    'Per gruppi di dati (registrazione, login) che richiedono validazione (es. "la password è troppo corta").',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 1: IL CONTROLLER (IL CERVELLO) ─────────────────────
            _cardLezione(
              titolo: '1. Il TextEditingController',
              colore: Colors.deepPurple.shade700,
              icona: Icons.settings_input_component_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Per leggere cosa c\'è scritto in un campo di testo, non puoi semplicemente "chiedere" al widget. Hai bisogno di un controllore.\n\n'
                    'Il controller è l\'oggetto che mantiene il testo in memoria e ti permette di:\n'
                    '• Leggere il valore attuale.\n'
                    '• Modificare il testo via codice (es. un tasto "Cancella").\n'
                    '• Spostare il cursore.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '// 1. Dichiara il controller nello Stato\n'
                    'final myController = TextEditingController();\n\n'
                    '// 2. Collegalo al widget\n'
                    'TextField(controller: myController),\n\n'
                    '// 3. Leggi il valore quando serve\n'
                    'print(myController.text);',
                  ),
                  _alertSuggerimento(
                    '⚠️ Importante: Ricordati sempre di fare il "dispose()" del controller per non sprecare memoria!',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 2: TEXTFIELD (INPUT VELOCE) ────────────────────────
            _cardLezione(
              titolo: '2. Personalizzare il TextField',
              colore: Colors.blue.shade600,
              icona: Icons.input_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Puoi controllare ogni aspetto visivo e funzionale tramite l\'attributo `decoration` (InputDecoration):\n',
                    style: _stileTestoBase(),
                  ),
                  _elementoLista(
                    'labelText',
                    'Il titolo che "vola" in alto quando clicchi.',
                  ),
                  _elementoLista(
                    'hintText',
                    'Il testo suggerimento che scompare.',
                  ),
                  _elementoLista(
                    'prefixIcon',
                    'Un\'icona all\'inizio del campo.',
                  ),
                  _elementoLista(
                    'keyboardType',
                    'Cambia la tastiera (solo numeri, email, ecc).',
                  ),
                  _boxCodice(
                    'TextField(\n'
                    '  keyboardType: TextInputType.emailAddress,\n'
                    '  decoration: InputDecoration(\n'
                    '    border: OutlineInputBorder(),\n'
                    '    labelText: "Email",\n'
                    '    hintText: "inserisci la tua email",\n'
                    '    prefixIcon: Icon(Icons.email),\n'
                    '  ),\n'
                    ')',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 3: FORM E VALIDAZIONE ──────────────────────────────
            _cardLezione(
              titolo: '3. Validazione con Form',
              colore: Colors.green.shade800,
              icona: Icons.verified_user_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quando hai un modulo intero, usi il widget `Form`. Questo ti permette di controllare tutti i campi insieme con un unico comando.\n\n'
                    'Il segreto è la `GlobalKey<FormState>`, che è come un "telecomando" per il Form.\n',
                    style: _stileTestoBase(),
                  ),
                  _testoBold('Il Validator:', Colors.green.shade900),
                  Text(
                    'È una funzione che restituisce un errore (String) se i dati non vanno bene, o `null` se è tutto ok.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'TextFormField(\n'
                    '  validator: (value) {\n'
                    '    if (value == null || value.isEmpty) {\n'
                    '      return "Campo obbligatorio";\n'
                    '    }\n'
                    '    return null;\n'
                    '  },\n'
                    ')',
                  ),
                ],
              ),
            ),

            // ─── SEZIONE 4: FOCUS E INVIO ───────────────────────────────────
            _cardLezione(
              titolo: '4. Gestire il Focus',
              colore: Colors.orange.shade800,
              icona: Icons.ads_click_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Puoi decidere quale campo deve essere attivo all\'apertura della pagina usando `autofocus: true`, oppure spostare il focus al campo successivo quando l\'utente preme "Invio" sulla tastiera.',
                    style: _stileTestoBase(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _suggerimentoCreativo(
              '🚀 Pro-tip: Usa `obscureText: true` per i campi password, così i caratteri verranno nascosti!',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ─── COMPONENTI GRAFICI DI SUPPORTO (DA AGGIUNGERE SOTTO) ──────────────────

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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
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
        border: Border.all(color: Colors.blue.shade200.withOpacity(0.3)),
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.blue.shade700),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: TextStyle(
                color: Colors.blue.shade900,
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

  Widget _elementoLista(String termine, String descrizione) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
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

  TextSpan _testoCodiceInline(String testo) {
    return TextSpan(
      text: ' `$testo` ',
      style: TextStyle(
        fontFamily: 'monospace',
        color: Colors.blue.shade900,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.blue.shade50,
      ),
    );
  }
}
