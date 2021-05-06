import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/model/note_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final data = snapshot.data;
              if (data == Null) {
                return Center(
                  child: Text("You don't have any notes yet, create one."),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: StaggeredGridView.countBuilder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title = data[index]['title'];
                      String body = data[index]['body'];
                      String creation_date = data[index]['creation_date'];
                      int id = data[index]['id'];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            final NoteModel note = NoteModel(
                                id: id,
                                title: title,
                                body: body,
                                creation_date: DateTime.parse(creation_date));
                            Navigator.pushNamed(context, '/showNote',
                                arguments: note);
                          },
                          title: Text(title),
                          subtitle: Text(
                            body,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    crossAxisCount: 2,
                  ),
                );
              }
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.note_add),
          onPressed: () {
            Navigator.pushNamed(context, '/addNote');
          }),
    );
  }
}
