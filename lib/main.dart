import 'package:flutter/material.dart';
import 'data/signalement_dao.dart';
import 'models/signalement.dart';

void main() => runApp(const MaterialApp(home: Test()));

class Test extends StatefulWidget {
  const Test({super.key});
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final dao = SignalementDao();
  List<Signalement> liste = [];

  Future<void> ajouter() async {
    await dao.inserer(Signalement(
      type: 'voirie',
      titre: 'Nid-de-poule',
      description: 'Rue principale',
      latitude: 9.3,
      longitude: 13.4,
      date: DateTime.now().toIso8601String(),
    ));
    final res = await dao.lire();
    setState(() => liste = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test SQLite')),
      body: ListView(
        children: liste
            .map((s) => ListTile(title: Text(s.titre), subtitle: Text(s.type)))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ajouter,
        child: const Icon(Icons.add),
      ),
    );
  }
}