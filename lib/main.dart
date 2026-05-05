import 'package:flutter/material.dart';
import 'package:nuova_app/academy_dashboard.dart';
import 'package:nuova_app/schermata_iniziale.dart';
import 'package:nuova_app/screen/home_page.dart'; // Assicurati che il percorso sia corretto

void main() {
  runApp(const ManualeFlutterApp());
}

class ManualeFlutterApp extends StatelessWidget {
  const ManualeFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Explainer',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const SchermataIniziale(),
    );
  }
}
