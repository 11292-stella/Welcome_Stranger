import 'package:flutter/material.dart';
// Importa il file dove hai definito HorrorTheme
import 'package:nuova_app/theme/horror_theme.dart';

class InizioCard extends StatelessWidget {
  final String titolo;
  final String descrizione;
  final Color colore;
  final VoidCallback onTap;

  const InizioCard({
    super.key,
    required this.titolo,
    required this.descrizione,
    required this.onTap,
    this.colore = const Color.fromARGB(255, 241, 35, 21), // Colore di fallback
  });

  @override
  Widget build(BuildContext context) {
    // Recuperiamo l'estensione del tema per coerenza nei font
    final horror = Theme.of(context).extension<HorrorTheme>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Sfondo scurissimo per distaccarsi dal nero del body
      color: const Color(0xFF0D0D0D),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          4,
        ), // Bordi meno arrotondati = più aggressivi
        side: BorderSide(
          color: colore.withOpacity(0.2), // Bordo sottile colorato
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // Effetto splash colorato al tocco
        splashColor: colore.withOpacity(0.1),
        highlightColor: const Color.fromARGB(0, 249, 13, 13),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            // Sostituiamo il bordo semplice con un gradiente leggero
            border: Border(left: BorderSide(color: colore, width: 4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titolo.toUpperCase(),
                  style:
                      horror?.horrorTitle?.copyWith(
                        fontSize: 16,
                        color: colore,
                        letterSpacing: 1.2,
                      ) ??
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colore,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  descrizione,
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 8, 255, 4),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'ACCEDI AL DOSSIER',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: colore.withOpacity(0.7),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: colore.withOpacity(0.7),
                    ),
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
