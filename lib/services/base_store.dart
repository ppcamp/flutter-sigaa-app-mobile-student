import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = "StudentSigaaLocal";

// https://flutter.dev/docs/cookbook/persistence/sqlite
class Store {
  Future<Database>? database;

  initialize(String createQuery) async {
    // Open the database and store the reference.
    this.database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), "$DB_NAME.db"),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(createQuery);
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}

