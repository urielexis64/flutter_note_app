class NoteModel {
  int? id;
  String title;
  String body;
  DateTime creation_date;

  NoteModel({
    this.id,
    required this.title,
    required this.body,
    required this.creation_date,
  });

  // Create a function to convert our item into a map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creation_date": creation_date.toString()
    });
  }
}
