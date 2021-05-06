import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/model/note_model.dart';

class ShowNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context)!.settings.arguments as NoteModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Note'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DatabaseProvider.db.deleteNote(note.id!);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              note.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              note.body,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
