import 'package:flutter/material.dart';
import 'package:reka/pages/settingspage/Pachtnotes/components/pacht_list.dart';
import 'package:reka/pages/settingspage/Pachtnotes/model/pacht_model.dart';
import 'package:reka/widget/grundg.dart';

class Pachtnotes extends StatefulWidget {
  const Pachtnotes({Key? key}) : super(key: key);

  @override
  _PachtnotesState createState() => _PachtnotesState();
}

class _PachtnotesState extends State<Pachtnotes> {
  List<PachtData> recentPachtData = [];

  @override
  void initState() {
    super.initState();
    // Lade die Daten beim Initialisieren der Seite
    loadRecentPachtData();
  }

  Future<void> loadRecentPachtData() async {
    try {
      // Lade die Daten dynamisch von der JSON-Quelle
      recentPachtData = await PachtData.fetchPachtDataFromJson();
      setState(
          () {}); // Aktualisiere die Anzeige, nachdem die Daten geladen wurden
    } catch (e) {
      print('Fehler beim Laden der Daten: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return grundg(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "PachtNotes",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              // Überprüfe, ob Daten geladen wurden, bevor du die Karten anzeigst
              recentPachtData.isNotEmpty
                  ? Column(
                      children:
                          recentPachtData.map((e) => PachtListTile(e)).toList(),
                    )
                  : const CircularProgressIndicator(), // Ladeanzeige, während Daten geladen werden
            ],
          ),
        ),
      ),
    );
  }
}
