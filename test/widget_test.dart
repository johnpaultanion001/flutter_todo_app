import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  testWidgets('Test sqflite database', (WidgetTester tester) async {
      var db = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        await db
            .execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, value TEXT)');
      });

     // Insert some data
    await db.insert('Test', {'value': 'test value'});

    // Check content
    expect(await db.query('Test'), [
      {'id': 1, 'value': 'test value'}
    ]);

    await db.close();

  });
}
