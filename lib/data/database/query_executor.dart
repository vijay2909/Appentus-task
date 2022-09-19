import 'package:flutter/cupertino.dart';
import 'package:sqflite/sql.dart';

import '../../domain/models/user.dart';
import 'app_database.dart';
import 'database_constants.dart';

class QueryExecutor {
  final AppDatabase appDatabase;

  QueryExecutor(this.appDatabase);

  Future<int> insertUser(User user) async {
    final db = await appDatabase.database;
    // Insert the user into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same user is inserted twice.
    //
    // In this case, replace any previous data.
    return await db.insert(
      DatabaseConstants.tableUsers,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final db = await appDatabase.database;

    String whereString =
        '${DatabaseConstants.tableUsersColEmail} = ? AND ${DatabaseConstants.tableUsersColPassword} = ?';

    List<dynamic> whereArguments = [email, password];

    debugPrint(whereString);
    debugPrint(whereArguments.toString());

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> results = await db.query(
      DatabaseConstants.tableUsers,
      where: whereString,
      whereArgs: whereArguments,
    );

    if (results.isNotEmpty) {
      final userMap = results[0];

      debugPrint(userMap.toString());

      final user = User(
        name: userMap['name'],
        email: userMap['email'],
        phone: userMap['phone'],
        password: userMap['password'],
        image: userMap['image'],
      );

      await db.update(
        DatabaseConstants.tableUsers,
        user.toMap(isLoggedIn: true),
        where: whereString,
        whereArgs: whereArguments,
      );
    }

    return results.isNotEmpty;
  }

  Future<bool> logout(User user) async {
    final db = await appDatabase.database;

    String whereString = '${DatabaseConstants.tableUsersColLoggedIn} = ?';

    List<dynamic> whereArguments = [1];

    final result = await db.update(
      DatabaseConstants.tableUsers,
      user.toMap(isLoggedIn: false),
      where: whereString,
      whereArgs: whereArguments,
    );

    return result > 0;
  }

  Future<User?> getLoggedInUser() async {
    final db = await appDatabase.database;

    String whereString = '${DatabaseConstants.tableUsersColLoggedIn} = ?';

    List<dynamic> whereArguments = [1];

    // Query the table for all The users.
    final List<Map<String, dynamic>> results = await db.query(
      DatabaseConstants.tableUsers,
      where: whereString,
      whereArgs: whereArguments,
    );

    debugPrint("getUsers called => users length: ${results.length}");

    if (results.isNotEmpty) {
      final userMap = results[0];
      return User(
        name: userMap['name'],
        email: userMap['email'],
        phone: userMap['phone'],
        image: userMap['image'],
        password: userMap['password'],
      );
    }
    return null;
  }
}
