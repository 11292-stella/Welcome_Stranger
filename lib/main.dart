import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nuova_app/theme/horror_theme.dart';
import 'package:nuova_app/schermata_iniziale.dart';

void main() {
  runApp(const ProviderScope(child: ManualeFlutterApp()));
}

class ManualeFlutterApp extends StatelessWidget {
  const ManualeFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Explainer',

      // CONFIGURAZIONE TEMA
      theme: ThemeData(
        useMaterial3: true,
        brightness:
            Brightness.dark, // Fondamentale per l'atmosfera Resident Evil
        scaffoldBackgroundColor: Colors.black,

        // 2. Inseriamo la ThemeExtension qui
        extensions: <ThemeExtension<dynamic>>[
          HorrorTheme(
            bloodRed: const Color(0xFF8B0000),
            moldGreen: const Color(0xFF2F4F4F),
            horrorTitle: GoogleFonts.creepster(
              fontSize: 28,
              color: const Color(0xFFB71C1C),
              shadows: [
                const Shadow(
                  color: Colors.black,
                  blurRadius: 15,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ],
      ),
      home: const SchermataIniziale(),
    );
  }
}
