import 'package:flutter/material.dart';
import 'package:nuova_app/academy_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

class SchermataIniziale extends StatefulWidget {
  const SchermataIniziale({super.key});

  @override
  State<SchermataIniziale> createState() => _SchermataInizialeState();
}

class _SchermataInizialeState extends State<SchermataIniziale> {
  bool _aperto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // Rende cliccabile tutta l'area nera
        onTap: () => setState(() => _aperto = true),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Effetto combinato dissolvenza + leggera espansione
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: _aperto ? const AcademyDashboard() : _buildMercanteIntro(),
        ),
      ),
    );
  }

  Widget _buildMercanteIntro() {
    return Container(
      key: const ValueKey('Mercante'),
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // IMMAGINE: BoxFit.cover la estende su tutto lo schermo
          // Se preferisci non tagliare nulla usa BoxFit.contain,
          // ma con lo sfondo nero del container si fonderà comunque.
          SizedBox.expand(
            child: Image.asset('assets/img.png', fit: BoxFit.contain),
          ),

          // OVERLAY GRADIENTE: Opzionale, serve a scurire la parte bassa
          // per far risaltare il testo se l'immagine è troppo chiara sotto.
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                  stops: const [0.7, 1.0],
                ),
              ),
            ),
          ),

          // TESTO ANIMATO: Posizionato nel terzo inferiore
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _TestoPulsante(),
                const SizedBox(height: 18),
                Text(
                  "( TAP TO ENTER THE SHOP )",
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TestoPulsante extends StatefulWidget {
  const _TestoPulsante();

  @override
  State<_TestoPulsante> createState() => _TestoPulsanteState();
}

class _TestoPulsanteState extends State<_TestoPulsante>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text(
        "WELCOME, STRANGER...",
        textAlign: TextAlign.center,
        style: GoogleFonts.creepster(
          // Usiamo Creepster per lo stile RE
          textStyle: const TextStyle(
            color: Color(0xFFB71C1C), // Un rosso sangue più cupo
            fontSize: 28, // Aumentato perché i font horror sono più sottili
            fontWeight: FontWeight.normal,
            letterSpacing: 2,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 15, offset: Offset(2, 2)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
