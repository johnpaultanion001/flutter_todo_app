import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/note.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat('MMM d y – kk:mm:a').format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Column(
      children: [
        Card(
          color: color,
          child: Container(
            constraints: BoxConstraints(minHeight: minHeight),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      color: note.isCompleted == false ? Colors.white : Colors.green,
                      icon: const Icon(Icons.done),
                      onPressed: () => {},
                      ),
                    const SizedBox(width: 50),
                    IconButton(
                      color: note.isPriority == false ? Colors.white : Colors.green,
                      icon: const Icon(Icons.stars),
                      onPressed: () => {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }

  
}