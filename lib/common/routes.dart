// ignore_for_file: no_duplicate_case_values

import 'package:flutter/material.dart';
import '../page/edit_note_page.dart';
import '../page/notes_page.dart';
import '../page/note_detail_page.dart';
import '../common/not_found_page.dart';

/// Manage all named routes used in the app.
class Routes {
  
  const Routes._();

  /// Named route to navigate home page.
  static const String notesHome = '/';
  static const String noteDetail = '/edit-note';
  static const String editNote = '/edit-note';

  /// Returns a route by [settings] name if exist otherwise return a [NotFoundPage].
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case notesHome:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NotesPage(),
        );
      case noteDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NoteDetailPage(),
        );
      case editNote:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AddEditNotePage(),
        );
    
    
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NotFoundPage(),
        );
    }
  }

  /// Returns a initial routes based in your [initialRoute] name.
  static List<Route<dynamic>> generateInitialRoutes(String initialRoute) {
    return [
      generateRoute(const RouteSettings(name: notesHome)),
    ];
  }
}
