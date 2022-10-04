// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/routes.dart';
import '../model/note.dart';
import '../provider/notes.dart';
import '../widget/note_form_widget.dart';
import '../common/constants.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isPriority;
  late bool isCompleted;
  late String title;
  late String description;
  late DateTime createdTime = DateTime.now();

  late NotesProvider _noteProvider;

  @override
  void initState() {
    super.initState();

    isPriority = widget.note?.isPriority ?? false;
    isCompleted = widget.note?.isCompleted ?? false;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    _noteProvider = Provider.of<NotesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        key: Key("saveButton"),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
        Navigator.popUntil(context,(route) => route.settings.name == Routes.notesHome,);
      } else {
        await addNote();
        Navigator.of(context).pop();
      }
      
    }
  }

  Future updateNote() async {
    await _noteProvider.addOrUpdate(title, description,createdTime, EditMode.update, widget.note?.id);

  }

  Future addNote() async {
    await _noteProvider.addOrUpdate(title, description,createdTime, EditMode.add);

  }
}