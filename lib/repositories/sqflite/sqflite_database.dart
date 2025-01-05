import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: ''' CREATE TABLE imcscript(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          altura REAL,
          peso REAL,
          imc REAL,
          resultado TEXT
  );
     '''
};

class SQFLiteDataBase {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Future iniciarBancoDeDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'databaseimc.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i < scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    });
    return db;
  }
}
