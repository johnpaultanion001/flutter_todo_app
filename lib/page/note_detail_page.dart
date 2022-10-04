// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import '../page/edit_note_page.dart';
import '../provider/notes.dart';


class NoteDetailPage extends StatefulWidget {
  final Note? note;

  const NoteDetailPage({
    this.note,
    Key? key,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late String title;
  late String description;
  late int id;
  late bool isCompleted;
  late bool isPriority;

  @override
  void initState() {
    super.initState();
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    id = widget.note?.id ?? 0;
    isPriority = widget.note?.isPriority ?? false;
    isCompleted = widget.note?.isCompleted ?? false;
  }


  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            editButton(), deleteButton(), completedButton(), importantButton(), 
          ],
        ),
        body:Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

    Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEditNotePage(note: widget.note),
                ));
    });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final provider = Provider.of<NotesProvider>(context, listen:false);
          provider.deleteNote(id);
          Navigator.of(context).pop();
        },
      );

  Widget completedButton() => IconButton(
      icon: const Icon(Icons.done),
      color: isCompleted == false ? Colors.white : Colors.green,
      onPressed: () async {
          final provider = Provider.of<NotesProvider>(context, listen:false);
          provider.completedNote(id, isCompleted);
          Navigator.of(context).pop();
        }
    );

   Widget importantButton() => IconButton(
      icon: const Icon(Icons.stars),
      color: isPriority == false ? Colors.white : Colors.green,
      onPressed: () async {
          final provider = Provider.of<NotesProvider>(context, listen:false);
          provider.importantNote(id, isPriority);
          Navigator.of(context).pop();
        }
    );



 
      
}