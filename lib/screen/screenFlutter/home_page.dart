import 'package:flutter/material.dart';
import 'package:nuova_app/screen/screenFlutter/creazione_progetto.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_context_nesting.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_crud_horror.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_data_models.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_debug_tree.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_error_handling_horror.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_form_input.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_layout.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_listview.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_nascita_widget.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_networking_intro.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_provider.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_real_app_step_by_step.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_riverpod_intro.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_state_lifting.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_stateless_stateful.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_struttura.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_theme_extensions.dart';
import 'package:nuova_app/screen/screenFlutter/lezione_riverpod_pilastri.dart';
// Importiamo il tema personalizzato
import 'package:nuova_app/theme/horror_theme.dart';

// Import delle lezioni (Assicurati che i path siano corretti nel tuo progetto)

import 'package:nuova_app/widgets/inizio_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final horror = Theme.of(context).extension<HorrorTheme>()!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'FLUTTER ACADEMY',
          style: horror.horrorTitle?.copyWith(fontSize: 22, letterSpacing: 2),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF080808),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // SEZIONE 1
          _sezioneTitolo("FONDAMENTA"),
          InizioCard(
            titolo: '1. Creazione Progetto',
            descrizione: 'Setup professionale e struttura cartelle.',
            colore: const Color(0xFF00E5FF), // Cyan Neon Rosso Neon acceso
            onTap: () => _naviga(
              context,
              const CreazioneProgetto(titoloLezione: 'Creazione Progetto'),
            ),
          ),
          InizioCard(
            titolo: '2. Struttura e Gerarchia',
            descrizione: 'Lo Scaffold e l\'albero dei Widget.',
            colore: const Color(0xFF00FF41), // Verde Matrix acceso
            onTap: () => _naviga(
              context,
              const LezioneStruttura(titoloLezione: 'Struttura & Gerarchia'),
            ),
          ),

          // SEZIONE 2
          _sezioneTitolo("ANATOMIA E LOGICA"),
          InizioCard(
            titolo: '3. Nascita di un Widget',
            descrizione: 'Classi, extends e costruttori.',
            colore: const Color.fromARGB(255, 138, 35, 207),
            onTap: () => _naviga(
              context,
              const LezioneNascitaWidget(titoloLezione: 'Classi & Costruttori'),
            ),
          ),
          InizioCard(
            titolo: '4. Context e Scatole Cinesi',
            descrizione: 'Il BuildContext (GPS) e il Nesting.',
            colore: const Color.fromARGB(255, 249, 136, 6),
            onTap: () => _naviga(
              context,
              const LezioneContextNesting(titoloLezione: 'Mappe e Strutture'),
            ),
          ),
          InizioCard(
            titolo: '5. Stateless vs Stateful',
            descrizione: 'Gestione della memoria e del cambiamento.',
            colore: const Color(0xFFFF0000),
            onTap: () => _naviga(
              context,
              const LezioneStatelessStateful(titoloLezione: 'La Memoria'),
            ),
          ),

          // SEZIONE 3
          _sezioneTitolo("COSTRUIRE L'INTERFACCIA"),
          InizioCard(
            titolo: '6. Row e Column',
            descrizione: 'Allineamenti e Flex Layout.',
            colore: const Color.fromARGB(255, 218, 246, 8),
            onTap: () => _naviga(
              context,
              const LezioneLayout(titoloLezione: 'Layout Flex'),
            ),
          ),
          InizioCard(
            titolo: '7. Liste Infinite',
            descrizione: 'Ottimizzazione con ListView.builder.',
            colore: const Color(0xFFFF0000),
            onTap: () => _naviga(
              context,
              const LezioneListView(titoloLezione: 'ListView & ListTile'),
            ),
          ),
          InizioCard(
            titolo: '8. Data Models',
            descrizione: 'Classi, costruttori factory e JSON.',
            colore: const Color(0xFF00FF41),
            onTap: () => _naviga(
              context,
              const LezioneDataModels(titoloLezione: 'Data Models'),
            ),
          ),
          InizioCard(
            titolo: '9. Theme Extensions',
            descrizione: 'Design System e modelli di colore personalizzati.',
            colore: const Color(0xFFBB86FC), // Viola acceso
            onTap: () => _naviga(
              context,
              const LezioneThemeExtensions(titoloLezione: 'Theme Extensions'),
            ),
          ),

          // SEZIONE 4
          _sezioneTitolo("LIVELLO PRO"),
          InizioCard(
            titolo: '10. Sotto il Cofano',
            descrizione: 'Widget Tree vs Render Tree.',
            colore: const Color(0xFFFF9100), // Arancio Neon
            onTap: () => _naviga(
              context,
              const LezioneDebugTree(titoloLezione: 'Architettura'),
            ),
          ),

          // SEZIONE 5
          _sezioneTitolo("COMUNICAZIONE E DATI"),
          InizioCard(
            titolo: '11. State Lifting',
            descrizione: 'Passaggio di funzioni e dati tra widget.',
            colore: const Color.fromARGB(255, 7, 123, 201),
            onTap: () => _naviga(
              context,
              const LezioneStateLifting(titoloLezione: 'State Lifting'),
            ),
          ),
          InizioCard(
            titolo: '12. Form e Input',
            descrizione: 'Validazione dati e controller di testo.',
            colore: const Color.fromARGB(255, 225, 27, 215),
            onTap: () => _naviga(
              context,
              const LezioneFormInput(titoloLezione: 'Form e Input'),
            ),
          ),
          InizioCard(
            titolo: '13. Provider',
            descrizione: 'Gestione centrale dello stato.',
            colore: const Color(0xFFFF0000),
            onTap: () => _naviga(
              context,
              const LezioneProvider(titoloLezione: 'Provider Concept'),
            ),
          ),

          // SEZIONE 6
          _sezioneTitolo("ARCHITETTURA MODERN"),
          InizioCard(
            titolo: '14. Riverpod: Le Basi',
            descrizione: 'Il futuro della gestione stato in Flutter.',
            colore: const Color(0xFF00E5FF), // Cyan Neon
            onTap: () => _naviga(
              context,
              const LezioneRiverpodIntro(titoloLezione: 'Riverpod Intro'),
            ),
          ),
          // Lezione 15: I 3 Pilastri (La nuova lezione)
          InizioCard(
            titolo: '15. I 3 Pilastri di Riverpod',
            descrizione: 'State, Notifier e Future: il trio del controllo.',
            colore: const Color(
              0xFF00E5FF,
            ), // Mantieni il Cyan per coerenza di sezione
            onTap: () => _naviga(
              context,
              const LezioneRiverpodPilastri(titoloLezione: 'I 3 Pilastri'),
            ),
          ),

          _sezioneTitolo("NETWORKING"),

          InizioCard(
            titolo: '16. Networking & API REST',
            descrizione: 'Come collegare l\'app al mondo esterno (HTTP).',
            colore: const Color(
              0xFF00C853,
            ), // Verde Smeraldo per il "collegamento"
            onTap: () => _naviga(
              context,
              const LezioneNetworkingIntro(
                titoloLezione: 'Il Ponte verso il Back-end',
              ),
            ),
          ),
          // --- NUOVA LEZIONE 17: CRUD (DA AGGIUNGERE ORA) ---
          InizioCard(
            titolo: '17. CRUD: Ciclo di Vita e Morte',
            descrizione: 'I quattro rituali per manipolare i dati remoti.',
            colore: const Color(0xFFFF1744), // Rosso Neon / Death Red
            onTap: () => _naviga(
              context,
              const LezioneCRUDHorror(titoloLezione: 'I Rituali del CRUD'),
            ),
          ),

          // --- LEZIONE 18: ERROR HANDLING ---
          InizioCard(
            titolo: '18. Error Handling & Status Codes',
            descrizione:
                'Impara a sopravvivere quando il server risponde dall\'abisso.',
            colore: const Color(0xFF9C27B0), // Viola Veleno
            onTap: () => _naviga(
              context,
              const LezioneErrorHandlingHorror(
                titoloLezione: 'Le Voci dell\'Abisso',
              ),
            ),
          ),

          // --- LEZIONE 19: CREAZIONE REAL APP ---
          InizioCard(
            titolo: '19. L\'Invocazione: Real App',
            descrizione:
                'Costruiamo un\'app vera che consuma API in tempo reale.',
            colore: const Color(0xFF39FF14), // Neon Green
            onTap: () => _naviga(
              context,
              const LezioneRealAppStepByStep(
                titoloLezione: 'Real App Step by Step',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _naviga(BuildContext context, Widget pagina) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pagina));
  }

  // TITOLO SEZIONE: Grigio chiaro molto più leggibile (come da immagine)
  Widget _sezioneTitolo(String testo) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 15, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            testo,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Color(0xFFB0B0B0), // Grigio chiaro visibile
              letterSpacing: 5,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 1,
            width: 30,
            color: const Color(0xFFB0B0B0).withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
