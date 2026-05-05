import 'package:flutter/material.dart';
import 'dart:ui'; // Necessario per lerpDouble

class LezioneThemeExtensions extends StatelessWidget {
  final String titoloLezione;

  const LezioneThemeExtensions({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(titoloLezione.toUpperCase()),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. IL PROBLEMA ─────────────────────────────────────────────
            _cardLezione(
              titolo: '1. Il problema che risolve',
              colore: Colors.red.shade700,
              icona: Icons.bug_report_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Il tema base di Flutter è limitato. Hai solo colori standard come primary e secondary.',
                    style: _stileTestoBase(),
                  ),
                  const SizedBox(height: 12),
                  _elementoLista(
                    'Limiti',
                    'Non puoi gestire gradienti personalizzati.',
                  ),
                  _elementoLista(
                    'Brand',
                    'Difficile gestire colori specifici (es. "Oro", "Premium").',
                  ),
                  _elementoLista(
                    'Stili',
                    'Impossibile aggiungere dimensioni o logiche extra.',
                  ),
                ],
              ),
            ),

            // ─── 2. L\'IDEA: IL MODELLO DEL DESIGN ──────────────────────────
            _cardLezione(
              titolo: '2. L\'idea: Un Modello per il Design',
              colore: Colors.indigo.shade700,
              icona: Icons.auto_awesome_motion_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pensa alla ThemeExtension come a un Data Model (DTO), ma invece di dati utente, contiene dati di stile.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    'class MioTema extends ThemeExtension<MioTema> {\n'
                    '  final Color sfondoGradiente;\n'
                    '  final double fontSpeciale;\n\n'
                    '  MioTema({required this.sfondoGradiente, required this.fontSpeciale});\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 3. IL RUOLO DI COPYWITH ────────────────────────────────────
            _cardLezione(
              titolo: '3. copyWith: L\'Immutabilità',
              colore: Colors.deepOrange.shade700,
              icona: Icons.copy_all_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _testoBold(
                    'Perché è fondamentale?',
                    Colors.deepOrange.shade900,
                  ),
                  Text(
                    'Flutter NON modifica gli oggetti. Ne crea sempre nuove copie. Se cambi da Light a Dark, Flutter crea un nuovo "stato" del tema.',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '@override\n'
                    'MioTema copyWith({Color? sfondoGradiente, double? fontSpeciale}) {\n'
                    '  return MioTema(\n'
                    '    sfondoGradiente: sfondoGradiente ?? this.sfondoGradiente,\n'
                    '    fontSpeciale: fontSpeciale ?? this.fontSpeciale,\n'
                    '  );\n'
                    '}',
                  ),
                ],
              ),
            ),

            // ─── 4. LERP: LA MAGIA DELLE ANIMAZIONI ─────────────────────────
            _cardLezione(
              titolo: '4. lerp: Transizioni Fluide',
              colore: Colors.purple.shade700,
              icona: Icons.animation_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quando cambi tema, Flutter non scatta. Sfuma grazie a lerp (Linear Interpolation).',
                    style: _stileTestoBase(),
                  ),
                  _boxCodice(
                    '@override\n'
                    'MioTema lerp(ThemeExtension<MioTema>? other, double t) {\n'
                    '  if (other is! MioTema) return this;\n'
                    '  return MioTema(\n'
                    '    sfondoGradiente: Color.lerp(sfondoGradiente, other.sfondoGradiente, t)!,\n'
                    '    fontSpeciale: lerpDouble(fontSpeciale, other.fontSpeciale, t)!,\n'
                    '  );\n'
                    '}',
                  ),
                  _suggerimentoCreativo(
                    'Il valore "t" va da 0 a 1. Se t=0.5, Flutter crea un tema con i colori "a metà strada" tra quello vecchio e quello nuovo.',
                  ),
                ],
              ),
            ),

            // ─── 5. USO PRATICO ─────────────────────────────────────────────
            _cardLezione(
              titolo: '5. Come si usa nella UI',
              colore: Colors.green.shade700,
              icona: Icons.ads_click_rounded,
              corpo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: _stileTestoBase(),
                      children: [
                        const TextSpan(
                          text:
                              'Accedi ai tuoi colori personalizzati tramite il ',
                        ),
                        _testoCodiceInline('context'),
                        const TextSpan(text: ':'),
                      ],
                    ),
                  ),
                  _boxCodice(
                    'Container(\n'
                    '  color: Theme.of(context)\n'
                    '      .extension<MioTema>()!\n'
                    '      .sfondoGradiente,\n'
                    ')',
                  ),
                  _alertSuggerimento(
                    'Vantaggio Finale: Cambi un colore nel modello e tutta l\'app si aggiorna istantaneamente. Pulizia e coerenza totale.',
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
}
