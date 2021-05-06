import 'package:note_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  // Creating the getter of the database
  Future<Database> get database async {
    // First let's check that we don't already have a db
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app_db"),
        onCreate: (db, version) async {
      // Notes table
      await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT, 
        body TEXT, 
        creation_date DATE
        )
      ''');
    }, version: 1);
  }

  // Function that will add a new note to our variable
  addNewNote(NoteModel note) async {
    final db = await database;
    db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Function that will fetch our database and return all the elements
  // inside the notes table
  Future<dynamic> getNotes() async {
    final db = await database;
    final res = await db.query("notes");
    if (res.length == 0) {
      return Null;
    } else {
      final resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  // Function to delete note from database
  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db.rawDelete('DELETE FROM NOTES WHERE ID = ?', [id]);
    return count;
  }
}
