import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await createDatabase();
      return _db;
    } else
      return _db;
  }

  Future<Database> createDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "nootah.db");
    return await openDatabase(path, version: 1, onCreate: (database, version) {
      database.execute(
          "CREATE TABLE note (id INTEGER PRIMARY KEY ,title TEXT, description TEXT, date TEXT , time TEXT)");
    });
  }

  Future<int> addNoteToDatabase(
      String title, String description, String date, String time) async {
    Database db = await createDatabase();
    int response = await db.insert("note", {
      "title": title,
      "description": description,
      "date": date,
      "time": time
    });
    return response;
  }

  Future<List<Map>> getAllNotes() async {
    Database? mydb = await db;
    List<Map> list = await mydb!.rawQuery('SELECT * FROM note');
    return list;
  }

  Future<int> addNote(
      String title, String description, String date, String time) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(
        "INSERT INTO note(title, description, date , time) VALUES($title , $description , $date , $time)");
    return response;
  }

  Future getNote(int id) async {
    Database? myDb = await db;
    return await myDb!.query("note", where: 'id = ?', whereArgs: [id]);
  }

  Future deleteNote(int id) async {
    Database? myDb = await db;
    // Delete a record
    return await myDb!.rawDelete('DELETE FROM note WHERE id = ?', [id]);
  }

  Future updateNote(int id, String title, String description) async {
    Database? myDb = await db;
    // update a record
    // Update some record
    int count = await myDb!.rawUpdate(
        'UPDATE note SET title = ?, description = ? WHERE id = ?',
        [title, description, id]);
    return count;
  }
}
