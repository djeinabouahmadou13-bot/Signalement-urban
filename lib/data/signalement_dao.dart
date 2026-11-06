import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/signalement.dart';

class SignalementDao {
  static Database? _db;

  Future<Database> get db async => _db ??= await _ouvrir();

  Future<Database> _ouvrir() async {
    final chemin = join(await getDatabasesPath(), 'signalements.db');
    return openDatabase(
      chemin,
      version: 1,
      onCreate: (d, version) async {
        await d.execute('''
          CREATE TABLE signalement(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT NOT NULL,
            titre TEXT NOT NULL,
            description TEXT,
            photo TEXT,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            statut TEXT NOT NULL DEFAULT 'nouveau',
            date TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> inserer(Signalement s) async {
    final d = await db;
    final donnees = s.toMap()..remove('id');
    return d.insert('signalement', donnees);
  }

  Future<List<Signalement>> lire({String? type}) async {
    final d = await db;
    final lignes = await d.query(
      'signalement',
      where: type != null ? 'type = ?' : null,
      whereArgs: type != null ? [type] : null,
      orderBy: 'date DESC',
    );
    return lignes.map(Signalement.fromMap).toList();
  }
}