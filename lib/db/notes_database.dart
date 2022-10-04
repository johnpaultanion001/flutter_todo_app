// ignore_for_file: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/note.dart';

class SQLite {
  static late Database _db;

  static Future<void> _onCreate(Database db, int ver) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    await db.execute('''
      CREATE TABLE $tableNotes ( 
        ${NoteFields.id} $idType, 
        ${NoteFields.isPriority} $boolType,
        ${NoteFields.isCompleted} $boolType,
        ${NoteFields.title} $textType,
        ${NoteFields.description} $textType,
        ${NoteFields.time} $textType
        )
      ''');
  }

  static Future<void> init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'db_tasks.db'),
      version: 2,
      onCreate: _onCreate,
    );
  }

  static Database get db => _db;
}

class SQLiteHelper {
  
  Future<List<Map<String, dynamic>>> get notes async {
    final orderBy = '${NoteFields.isPriority.toString()} DESC , ${NoteFields.title} ASC';

    return SQLite.db.query(
      tableNotes,
      orderBy: orderBy,
    );
  }

  Future<int> insertNote(Map<String, dynamic> note) async {
    return SQLite.db.insert(
      tableNotes,
      note,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteNote(int id) async {
    return SQLite.db.delete(
      tableNotes,
      where: '_id=?',
      whereArgs: [id],
    );
  }

  Future<int> completed(int id, bool status) async {
     return SQLite.db.update(
      tableNotes,
      {'isCompleted': status},
      where: '_id=?',
      whereArgs: [id],
    );
  }

  Future<int> important(int id, bool status) async {
     return SQLite.db.update(
      tableNotes,
      {'isPriority': status},
      where: '_id=?',
      whereArgs: [id],
    );
  }
  

}
