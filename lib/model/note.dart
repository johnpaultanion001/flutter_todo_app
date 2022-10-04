const String tableNotes = 'db_tasks';

class NoteFields{

  static final List<String> values = [
    id, isPriority, isCompleted, title, description, time
  ];

  static const String id = '_id';
  static const String isPriority = 'isPriority';
  static const String isCompleted = 'isCompleted';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
   final int? id;
   final bool isPriority;
   final bool isCompleted;
   final String title;
   final String description;
   final DateTime createdTime;

   const Note({
      this.id,
      this.isPriority = false,
      this.isCompleted = false,
      required this.title,
      required this.description,
      required this.createdTime,
   });
   
   Note copy({
    int? id,
    bool? isPriority,
    bool? isCompleted,
    String? title,
    String? description,
    DateTime? createdTime,
   }) => Note(
      id: id ?? this.id,
      isPriority: isPriority ?? this.isPriority,
      isCompleted: isCompleted ?? this.isCompleted,
      title:title ?? this.title,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
   );

   static Note fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int?,
      isPriority: json[NoteFields.isPriority] == 1,
      isCompleted: json[NoteFields.isCompleted] == 1,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.time] as String),

   );

   Map<String, Object?> toJson() => {
      NoteFields.id: id,
      NoteFields.isPriority: isPriority ? 1 : 0,
      NoteFields.isCompleted: isCompleted ? 1 : 0,
      NoteFields.title: title,
      NoteFields.description: description,
      NoteFields.time: createdTime.toIso8601String(),
   };
   
}