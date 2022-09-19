import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';

class AppDatabase {
  Database? _database;

  Future<Database> get database async {
    return _database ??= await _openLocalDatabase();
  }

  Future<Database> _openLocalDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),
      // When the database is first created, create a table to store user information.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE ${DatabaseConstants.tableUsers}(${DatabaseConstants.tableUsersColEmail} TEXT PRIMARY KEY, name TEXT, phone TEXT, ${DatabaseConstants.tableUsersColPassword} TEXT, image TEXT, ${DatabaseConstants.tableUsersColLoggedIn} INTEGER DEFAULT "0")',
        );
      },
      version: 1,
    );
  }
}
