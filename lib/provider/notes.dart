import 'package:flutter/cupertino.dart';
import '../common/constants.dart';
import '../db/notes_database.dart';
import '../model/note.dart';

class NotesProvider extends ChangeNotifier{
  final SQLiteHelper _db = SQLiteHelper();

  List<Note> _items = [];

  //Load all data in database
  Future<void> loadNotes() async {
    final List<Map<String, dynamic>> data = await _db.notes;
    _items = data.map((note) {
      return Note.fromJson(note);
    }).toList();

    notifyListeners();
  }

  //create or update function
  Future<void> addOrUpdate(
    String title,
    String description,
    DateTime createdTime,
    EditMode? editMode, [
    int? id,
  ]) async {
    final int idSaved = await _db.insertNote(
      Note(
        id: id,
        title: title,
        description: description,
        createdTime: createdTime,
      ).toJson(),
    );

    final Note note = Note(
      id: idSaved,
      title: title,
      description: description,
      createdTime: createdTime,
    );
    if (idSaved != 0) {
      if (editMode == EditMode.add) {
        _items.insert(0, note);
      } else if (editMode == EditMode.update) {
        _items[_items.indexWhere((element) => element.id == note.id)] = note;
      }
      loadNotes();
    }
  }

  //delete function
  Future<void> deleteNote(int id) async {
    _items.removeWhere((element) => element.id == id);
    await _db.deleteNote(id);
    notifyListeners();
  }

  //completed status changing function
  Future<void> completedNote(int id, bool status) async {
    status == true ? status = false : status = true;
    await _db.completed(id, status);
    loadNotes();
  }

  //completed status changing function
  Future<void> importantNote(int id, bool status) async {
    status == true ? status = false : status = true;
    await _db.important(id, status);
    loadNotes();
  }

  List<Note> get items => [..._items];
  List<Note> get completed => _items.where((note) => note.isCompleted == true).toList();
  List<Note> get priority => _items.where((note) => note.isPriority == true).toList();

}