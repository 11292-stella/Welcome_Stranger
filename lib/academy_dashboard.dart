import 'package:flutter/material.dart';
import 'package:nuova_app/screen/screenFlutter/home_page.dart';
import 'package:nuova_app/theme/horror_theme.dart';

class AcademyDashboard extends StatelessWidget {
  const AcademyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final horror = Theme.of(context).extension<HorrorTheme>()!;

    return Scaffold(
      backgroundColor: Colors.black, // Nero assoluto per contrasto neon
      appBar: AppBar(
        title: Text(
          'MY DEV ACADEMY',
          style: horror.horrorTitle?.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: [
          _cardModulo(
            context,
            titolo: 'FLUTTER',
            sottotitolo: 'App Mobile Pro',
            icona: Icons.flutter_dash_rounded,
            coloreBase: horror.bloodRed!,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ),
          ),
          _cardModulo(
            context,
            titolo: 'PYTHON',
            sottotitolo: 'AI & Automation',
            icona: Icons.terminal_rounded,
            coloreBase: horror.moldGreen!,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _cardModulo(
    BuildContext context, {
    required String titolo,
    required String sottotitolo,
    required IconData icona,
    required Color coloreBase,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F), // Più scuro per far risaltare il glow
          borderRadius: BorderRadius.circular(12),
          // Bordo più luminoso
          border: Border.all(color: coloreBase.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: coloreBase.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icona con bagliore
            Icon(
              icona,
              size: 45,
              color: coloreBase,
              shadows: [Shadow(color: coloreBase, blurRadius: 20)],
            ),
            const SizedBox(height: 12),
            Text(
              titolo,
              style: Theme.of(context)
                  .extension<HorrorTheme>()!
                  .horrorTitle
                  ?.copyWith(
                    fontSize: 16,
                    color: coloreBase,
                    // Sovrascriviamo l'ombra per adattarla al colore della card
                    shadows: [Shadow(color: coloreBase, blurRadius: 10)],
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              sottotitolo,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: coloreBase.withOpacity(
                  0.6,
                ), // Sottotitolo dello stesso colore ma tenue
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
