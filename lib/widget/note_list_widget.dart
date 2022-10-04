import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../page/note_detail_page.dart';
import '../provider/notes.dart';
import 'note_card_widget.dart';

class NoteListWidget extends StatelessWidget {
  const NoteListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<NotesProvider>(
      builder: (context, provider, child){
        if(provider.items.isEmpty){
          return const Center(
              child: Text(
                'NO TASKS' ,
                style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            );
        }
        return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.items.length,
          staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            final note = provider.items[index];
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(note: note),
                ));
              },
              child: NoteCardWidget(note: note, index: index),
            );
          },
        );
      },  
    );
  }
}
