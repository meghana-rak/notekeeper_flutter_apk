
///Note Model


class NoteModel {
  final int? id;
  final String? title;
  final String? content;

  NoteModel({this.id, this.title, this.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
