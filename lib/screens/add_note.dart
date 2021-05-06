import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/model/note_model.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String _title;
  late String _body;
  late DateTime _date;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  FocusNode titleFocus = FocusNode(), bodyFocus = FocusNode();

  bool _disabledState = true;

  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
  }

  _checkTextFields() {
    setState(() {
      // If both textfields are empty so we are going to disable the save button
      final titleText = _titleController.text;
      final bodyText = _bodyController.text;

      if (titleText.isNotEmpty && bodyText.isNotEmpty) {
        _disabledState = false;
      } else {
        _disabledState = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _titleController.addListener(_checkTextFields);
    _bodyController.addListener(_checkTextFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Note')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            TextField(
              focusNode: titleFocus,
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, labelText: 'Note title'),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              focusNode: bodyFocus,
              controller: _bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, labelText: 'Description'),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: !_disabledState
            ? () {
                setState(() {
                  _title = _titleController.text;
                  _body = _bodyController.text;
                  _date = DateTime.now();
                });
                NoteModel note =
                    NoteModel(title: _title, body: _body, creation_date: _date);
                addNote(note);

                // Now when we save the note it will automatically return to the home page
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            : () {
                if (_titleController.text.isEmpty)
                  titleFocus.requestFocus();
                else
                  bodyFocus.requestFocus();
              },
        label: Text('Save Note'),
        icon: Icon(Icons.save),
        backgroundColor: _disabledState ? Colors.grey : Colors.blue,
      ),
    );
  }
}
