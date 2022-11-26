import 'dart:io';
import 'package:university_app/screens/university_list/models/university_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  final String universityTable = 'uTable';

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'UniversityDataDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE $universityTable ('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'domains TEXT,'
          'state_province TEXT,'
          'country TEXT,'
          'web_pages TEXT,'
          'alpha_two_code TEXT'
          ')');
    });
  }

  Future<void> insertAll(List<UniversityModel> univData) async {
    Database? db = await database;
    Batch batch = db!.batch();
    for (UniversityModel univ in univData) {
      batch.insert(universityTable, univ.toLocalJson());
    }
    batch.commit();
  }

  Future<List<UniversityModel>> getAllUnivData() async {
    Database? db = await database;
    var res = await db!.query(universityTable);
    List<UniversityModel> univData = res.isNotEmpty
        ? res.map((univ) {
            return UniversityModel(
                name: univ['name'].toString(),
                country: univ['country'].toString(),
                stateProvince: univ['state_province'].toString(),
                alphaTwoCode: univ['alpha_two_code'].toString(),
                domains: univ['domains'].toString().split('_'),
                webPages: univ['web_pages'].toString().split('_'));
          }).toList()
        : [];
    return univData;
  }

  deleteAll() async {
    Database? db = await database;
    await db!.delete(universityTable);
  }
}
