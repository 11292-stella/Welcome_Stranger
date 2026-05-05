// Esempio di come diventerebbe la tua nuova Home
import 'package:flutter/material.dart';
import 'package:nuova_app/screen/home_page.dart';

class AcademyDashboard extends StatelessWidget {
  const AcademyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('MY DEV ACADEMY'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade900,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2, // Due colonne
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _cardModulo(
            titolo: 'FLUTTER',
            sottotitolo: 'App Mobile Pro',
            icona: Icons.flutter_dash_rounded,
            colore: Colors.blue.shade700,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ),
          ),
          _cardModulo(
            titolo: 'PYTHON',
            sottotitolo: 'AI & Automation',
            icona: Icons.terminal_rounded,
            colore: Colors.orange.shade800,
            onTap: () {
              /* Prossimamente */
            },
          ),
          _cardModulo(
            titolo: 'DATABASE',
            sottotitolo: 'SQL & NoSQL',
            icona: Icons.storage_rounded,
            colore: Colors.teal.shade700,
            onTap: () {
              /* Prossimamente */
            },
          ),
          _cardModulo(
            titolo: 'BACKEND',
            sottotitolo: 'Node.js & Go',
            icona: Icons.cloud_queue_rounded,
            colore: Colors.deepPurple.shade700,
            onTap: () {
              /* Prossimamente */
            },
          ),
        ],
      ),
    );
  }

  // Componente grafico per la dashboard
  Widget _cardModulo({
    required String titolo,
    required String sottotitolo,
    required IconData icona,
    required Color colore,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colore.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icona, size: 45, color: colore),
            const SizedBox(height: 12),
            Text(
              titolo,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: colore,
              ),
            ),
            Text(
              sottotitolo,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
