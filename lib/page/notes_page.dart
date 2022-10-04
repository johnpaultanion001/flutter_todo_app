// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../page/edit_note_page.dart';
import '../provider/notes.dart';
import '../widget/note_list_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NotesProvider>(context, listen: false).loadNotes(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return _Scaffold();
        }
        return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
        );
      },
    );
  }
}

class _Scaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesProvider>(context);
    final priority = provider.priority.length;
    final completed = provider.completed.length;

    return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Tasks',
              style: TextStyle(fontSize: 24),
            ),
            actions: [
              Row(
                children: [
                  Column(
                    children:  [
                       SizedBox(height: 8),
                       Icon(
                        Icons.stars,
                        color: Colors.green,
                      ),
                      Text('$priority Priority'),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      SizedBox(height: 8),
                        Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      
                      Text('$completed Completed'),
                    ],
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ],
          ),
          body: const NoteListWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddEditNotePage())
              );
            },
          ),
          
        );
  }
}