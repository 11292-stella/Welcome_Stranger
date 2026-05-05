import 'package:flutter/material.dart';

class InizioCard extends StatelessWidget {
  final String titolo;
  final String descrizione;
  final Color colore;
  final VoidCallback onTap; // La funzione che verrà eseguita al click

  const InizioCard({
    super.key,
    required this.titolo,
    required this.descrizione,
    required this.onTap,
    this.colore = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      clipBehavior: Clip
          .antiAlias, // Serve per far sì che l'effetto click segua i bordi arrotondati
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: colore, width: 6)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titolo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colore,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descrizione,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Scopri di più',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
