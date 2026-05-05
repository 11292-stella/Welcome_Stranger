import 'package:flutter/material.dart';
import 'package:nuova_app/screen/lezione_anatomia.dart';
import 'package:nuova_app/screen/lezione_context_nesting.dart';
import 'package:nuova_app/screen/lezione_data_models.dart';
import 'package:nuova_app/screen/lezione_debug_tree.dart';
import 'package:nuova_app/screen/lezione_form_input.dart';
import 'package:nuova_app/screen/lezione_layout.dart';
import 'package:nuova_app/screen/lezione_listview.dart';
import 'package:nuova_app/screen/lezione_nascita_widget.dart';
import 'package:nuova_app/screen/lezione_provider.dart';
import 'package:nuova_app/screen/lezione_riverpod_intro.dart';
import 'package:nuova_app/screen/lezione_state_lifting.dart';
import 'package:nuova_app/screen/lezione_stateless_stateful.dart';
import 'package:nuova_app/screen/lezione_struttura.dart';
import 'package:nuova_app/screen/lezione_theme_extensions.dart';
import 'package:nuova_app/widgets/inizio_card.dart';
import 'package:nuova_app/screen/creazione_progetto.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'FLUTTER ACADEMY',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
            ),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _sezioneTitolo("FONDAMENTA"),

          InizioCard(
            titolo: '1. Creazione Progetto',
            descrizione:
                'Dal terminale al primo "Hello World": setup professionale, pulizia codice e struttura cartelle.',
            colore: Colors.blueGrey.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreazioneProgetto(
                    titoloLezione: 'Creazione Progetto',
                  ),
                ),
              );
            },
          ),

          InizioCard(
            titolo: '2. Struttura e Gerarchia',
            descrizione: 'Lo Scaffold, la MaterialApp e l\'albero dei Widget.',
            colore: Colors.blue.shade700,
            onTap: () => _naviga(
              context,
              const LezioneStruttura(titoloLezione: 'Struttura & Gerarchia'),
            ),
          ),

          _sezioneTitolo("ANATOMIA E LOGICA"),

          InizioCard(
            titolo: '3. Nascita di un Widget',
            descrizione:
                'Classi, extends e costruttori: lo stampo del tuo codice.',
            colore: Colors.teal.shade700,
            onTap: () => _naviga(
              context,
              const LezioneNascitaWidget(titoloLezione: 'Classi & Costruttori'),
            ),
          ),

          InizioCard(
            titolo: '4. Context e Scatole Cinesi',
            descrizione:
                'Il BuildContext (GPS) e la logica del Nesting profondo.',
            colore: Colors.cyan.shade800,
            onTap: () => _naviga(
              context,
              const LezioneContextNesting(titoloLezione: 'Mappe e Strutture'),
            ),
          ),

          InizioCard(
            titolo: '5. Stateless vs Stateful',
            descrizione:
                'Gestione della memoria: quando il widget deve "cambiare".',
            colore: Colors.orange.shade900,
            onTap: () => _naviga(
              context,
              const LezioneStatelessStateful(titoloLezione: 'La Memoria'),
            ),
          ),

          _sezioneTitolo("COSTRUIRE L'INTERFACCIA"),

          InizioCard(
            titolo: '6. Row e Column',
            descrizione:
                'Allineamenti, MainAxis e CrossAxis. Organizza lo spazio.',
            colore: Colors.deepPurple.shade700,
            onTap: () => _naviga(
              context,
              const LezioneLayout(titoloLezione: 'Layout Flex'),
            ),
          ),

          InizioCard(
            titolo: '7. Liste Infinite (ListView)',
            descrizione: 'Ottimizzazione con .builder e gestione dello scroll.',
            colore: Colors.purple.shade600,
            onTap: () => _naviga(
              context,
              const LezioneListView(titoloLezione: 'ListView & ListTile'),
            ),
          ),
          InizioCard(
            titolo: '8. Data Models',
            descrizione:
                'Organizza i dati come un Pro: classi, costruttori factory e gestione JSON.',
            colore: Colors.brown.shade800,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LezioneDataModels(titoloLezione: 'Data Models'),
                ),
              );
            },
          ),
          //agg card
          InizioCard(
            titolo: '9. Theme Extensions',
            descrizione:
                'Design System avanzato: crea modelli per i tuoi colori brand, gradienti e animazioni tra temi.',
            colore: Colors.indigo.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LezioneThemeExtensions(
                    titoloLezione: 'Theme Extensions',
                  ),
                ),
              );
            },
          ),

          _sezioneTitolo("LIVELLO PRO"),

          InizioCard(
            titolo: '10. Sotto il Cofano',
            descrizione: 'Widget Tree vs Render Tree e Debug con i DevTools.',
            colore: Colors.red.shade900,
            onTap: () => _naviga(
              context,
              const LezioneDebugTree(titoloLezione: 'Architettura'),
            ),
          ),
          _sezioneTitolo("COMUNICAZIONE E DATI"),
          InizioCard(
            titolo: '11. State Lifting',
            descrizione:
                'Far parlare i widget tra loro: passa funzioni e dati tra padre e figli.',
            colore: Colors.deepOrange.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LezioneStateLifting(titoloLezione: 'State Lifting'),
                ),
              );
            },
          ),
          //aggiungi card
          InizioCard(
            titolo: '12. Form e Input',
            descrizione:
                'Gestire il testo, controller, validazione dei dati e tastiere.',
            colore: Colors.blue.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LezioneFormInput(titoloLezione: 'Form e Input'),
                ),
              );
            },
          ),
          //aggiungi card
          InizioCard(
            titolo: '13. Provider (State Management)',
            descrizione:
                'Gestione professionale dei dati: crea un magazzino centrale per la tua app.',
            colore: Colors.indigo.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LezioneProvider(titoloLezione: 'Provider Concept'),
                ),
              );
            },
          ),
          _sezioneTitolo("ARCHITETTURA MODERN (RIVERPOD)"),
          InizioCard(
            titolo: '14. Riverpod: Le Basi',
            descrizione:
                'Dì addio al context e al prop drilling. Introduzione al futuro di Flutter.',
            colore: Colors.cyan.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LezioneRiverpodIntro(
                    titoloLezione: 'Riverpod Intro',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Funzione helper per navigare senza ripetere codice
  void _naviga(BuildContext context, Widget pagina) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pagina));
  }

  // Widget per separare le sezioni
  Widget _sezioneTitolo(String testo) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 5),
      child: Text(
        testo,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey.shade400,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
