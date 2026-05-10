import 'package:flutter/material.dart';
import 'dart:ui'; // Necessario per lerpDouble

class LezioneThemeExtensions extends StatelessWidget {
  final String titoloLezione;

  const LezioneThemeExtensions({super.key, required this.titoloLezione});

  @override
  Widget build(BuildContext context) {
    const Color neonIndigo = Color(0xFF7C4DFF);
    const Color electricPurple = Color(0xFFE040FB);
    const Color darkBackground = Color(0xFF000000);
    const Color surfaceGrey = Color(0xFF121212);
    const Color warningRed = Color(0xFFFF5252);

    return Scaffold(
      backgroundColor: darkBackground,
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
        backgroundColor: surfaceGrey,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: neonIndigo),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: neonIndigo.withOpacity(0.3), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── 1. IL PROBLEMA ─────────────────────────────────────────────
            _cardLezione(
              titolo: 'Criticità: Vincoli del Tema Base',
              colore: warningRed,
              icona: Icons.bug_report_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'Il sistema '),
                    _testoBold('ThemeData', warningRed),
                    const TextSpan(
                      text:
                          ' standard è un perimetro limitato. Spesso i requisiti di brand superano le categorie predefinite (primary/secondary).\n\n',
                    ),
                    _elementoLista(
                      'Gradienti',
                      'Impossibile mapparli nativamente nel tema.\n',
                      warningRed,
                    ),
                    _elementoLista(
                      'Token Custom',
                      'Difficoltà nel gestire colori come "Premium Gold" o "Ghost Grey".\n',
                      warningRed,
                    ),
                    _elementoLista(
                      'Dati Extra',
                      'Impossibile allegare logiche di spacing o font specifiche.',
                      warningRed,
                    ),
                  ],
                ),
              ),
            ),

            // ─── 2. L\'IDEA: IL MODELLO DEL DESIGN ──────────────────────────
            _cardLezione(
              titolo: '2. Visione: DTO di Stile',
              colore: neonIndigo,
              icona: Icons.auto_awesome_motion_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(text: 'La '),
                    _testoBold('ThemeExtension', neonIndigo),
                    const TextSpan(
                      text:
                          ' agisce come un contenitore atomico. Invece di trasportare dati utente, trasporta le direttive del sistema di design.',
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              'class MioTema extends ThemeExtension<MioTema> {\n'
              '  final Color sfondoGradiente;\n'
              '  final double fontSpeciale;\n\n'
              '  MioTema({required this.sfondoGradiente, required this.fontSpeciale});\n'
              '}',
            ),

            const SizedBox(height: 30),

            // ─── 3. IL RUOLO DI COPYWITH ────────────────────────────────────
            _cardLezione(
              titolo: '3. Protocollo Immutabilità',
              colore: Colors.deepOrange,
              icona: Icons.copy_all_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Flutter non altera gli oggetti esistenti. Durante lo switch tra Dark e Light Mode, il metodo ',
                    ),
                    _testoBold('copyWith', Colors.deepOrange),
                    const TextSpan(
                      text:
                          ' genera un nuovo stato del tema preservando l\'integrità dei dati non modificati.',
                    ),
                  ],
                ),
              ),
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

            const SizedBox(height: 30),

            // ─── 4. LERP: LA MAGIA DELLE ANIMAZIONI ─────────────────────────
            _cardLezione(
              titolo: '4. Algoritmo di Transizione: Lerp',
              colore: electricPurple,
              icona: Icons.animation_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Il passaggio tra temi non deve essere istantaneo. Il metodo ',
                    ),
                    _testoBold('lerp', electricPurple),
                    const TextSpan(
                      text:
                          ' (Linear Interpolation) calcola i frame intermedi tra due stati di design.',
                    ),
                  ],
                ),
              ),
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
              'Il fattore "t" (0.0 a 1.0) è la chiave: permette a Flutter di sfumare '
              'i colori mentre l\'utente cambia tema, garantendo un\'esperienza fluida.',
            ),

            const SizedBox(height: 30),

            // ─── 5. USO PRATICO ─────────────────────────────────────────────
            _cardLezione(
              titolo: '5. Implementazione nella UI',
              colore: Colors.greenAccent,
              icona: Icons.ads_click_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text: 'Interroga il sistema di design tramite il ',
                    ),
                    _testoBold('context', Colors.greenAccent),
                    const TextSpan(
                      text: ' per accedere ai token personalizzati:',
                    ),
                  ],
                ),
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
              '🎯 CONCLUSIONE: Con le ThemeExtensions, il tuo design diventa scalabile. '
              'Modificando una singola entry nel modello, l\'intera applicazione si '
              'allinea istantaneamente, mantenendo una coerenza visiva assoluta.',
            ),

            const SizedBox(height: 50),
            // ─── 6. TEMPLATE COMPLETO: CREA IL TUO TEMA ─────────────────────
            _cardLezione(
              titolo: '6. Template: Costruisci la Tua Estensione',
              colore: neonIndigo,
              icona: Icons.architecture_rounded,
              corpo: RichText(
                text: TextSpan(
                  style: _stileTestoBase(),
                  children: [
                    const TextSpan(
                      text:
                          'Un template completo e funzionante. Copia, rinomina e sostituisci i campi con i tuoi token di design.\n\n',
                    ),
                    _elementoLista(
                      'Step 1',
                      'Definisci i campi della tua classe (colori, font, spacing).\n',
                      neonIndigo,
                    ),
                    _elementoLista(
                      'Step 2',
                      'Implementa copyWith per l\'immutabilità.\n',
                      neonIndigo,
                    ),
                    _elementoLista(
                      'Step 3',
                      'Implementa lerp per le animazioni tra temi.\n',
                      neonIndigo,
                    ),
                    _elementoLista(
                      'Step 4',
                      'Registra l\'estensione nel tuo ThemeData.\n',
                      neonIndigo,
                    ),
                    _elementoLista(
                      'Step 5',
                      'Accedi ai token ovunque tramite context.',
                      neonIndigo,
                    ),
                  ],
                ),
              ),
            ),

            _boxCodice(
              '// ── STEP 1: Definisci la classe ──────────────────────\n'
              'class MioTema extends ThemeExtension<MioTema> {\n'
              '  final Color coloreAccent;      // Il tuo colore brand\n'
              '  final Color coloreGradiente;   // Per sfondi/cards\n'
              '  final double fontTitolo;       // Dimensione titoli\n'
              '  final double spacingBase;      // Unità di spaziatura\n\n'
              '  MioTema({\n'
              '    required this.coloreAccent,\n'
              '    required this.coloreGradiente,\n'
              '    required this.fontTitolo,\n'
              '    required this.spacingBase,\n'
              '  });\n\n'
              '  // ── STEP 2: copyWith ──────────────────────────────\n'
              '  @override\n'
              '  MioTema copyWith({\n'
              '    Color? coloreAccent,\n'
              '    Color? coloreGradiente,\n'
              '    double? fontTitolo,\n'
              '    double? spacingBase,\n'
              '  }) {\n'
              '    return MioTema(\n'
              '      coloreAccent: coloreAccent ?? this.coloreAccent,\n'
              '      coloreGradiente: coloreGradiente ?? this.coloreGradiente,\n'
              '      fontTitolo: fontTitolo ?? this.fontTitolo,\n'
              '      spacingBase: spacingBase ?? this.spacingBase,\n'
              '    );\n'
              '  }\n\n'
              '  // ── STEP 3: lerp ──────────────────────────────────\n'
              '  @override\n'
              '  MioTema lerp(ThemeExtension<MioTema>? other, double t) {\n'
              '    if (other is! MioTema) return this;\n'
              '    return MioTema(\n'
              '      coloreAccent: Color.lerp(coloreAccent, other.coloreAccent, t)!,\n'
              '      coloreGradiente: Color.lerp(coloreGradiente, other.coloreGradiente, t)!,\n'
              '      fontTitolo: lerpDouble(fontTitolo, other.fontTitolo, t)!,\n'
              '      spacingBase: lerpDouble(spacingBase, other.spacingBase, t)!,\n'
              '    );\n'
              '  }\n\n'
              '  // ── STEP 4: Istanze Light / Dark ──────────────────\n'
              '  static const light = MioTema(\n'
              '    coloreAccent: Color(0xFF7C4DFF),\n'
              '    coloreGradiente: Color(0xFFEDE7F6),\n'
              '    fontTitolo: 24.0,\n'
              '    spacingBase: 16.0,\n'
              '  );\n\n'
              '  static const dark = MioTema(\n'
              '    coloreAccent: Color(0xFFE040FB),\n'
              '    coloreGradiente: Color(0xFF1A1A2E),\n'
              '    fontTitolo: 24.0,\n'
              '    spacingBase: 16.0,\n'
              '  );\n'
              '}\n\n'
              '// ── STEP 4: Registra nel ThemeData ────────────────────\n'
              'ThemeData(\n'
              '  extensions: [MioTema.light], // oppure MioTema.dark\n'
              ')\n\n'
              '// ── STEP 5: Usa i token nel widget ────────────────────\n'
              'final tema = Theme.of(context).extension<MioTema>()!;\n\n'
              'Container(\n'
              '  color: tema.coloreAccent,\n'
              '  padding: EdgeInsets.all(tema.spacingBase),\n'
              '  child: Text("Titolo", style: TextStyle(fontSize: tema.fontTitolo)),\n'
              ')',
            ),

            _suggerimentoCreativo(
              'Le istanze static const light e dark ti permettono di switchare '
              'l\'intero sistema di design con una sola riga nel ThemeData — '
              'nessuna condizione if/else sparsa nel codice.',
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
        border: Border.all(color: Colors.purple.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.bolt_rounded, color: Color(0xFFE040FB), size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                color: Color(0xFFE040FB),
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
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.2)),
      ),
      child: Text(
        testo,
        style: const TextStyle(
          color: Colors.cyanAccent,
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
