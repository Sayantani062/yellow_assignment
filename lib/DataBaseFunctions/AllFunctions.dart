import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AllFunctions {
  Future<List<Map>> addItem(
      {@required name, @required director, @required link}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Movies (id INTEGER PRIMARY KEY, movie_name TEXT, director_name TEXT, link STRING)');
    });
    await database.transaction((txn) async {
      int count = await txn.rawInsert(
          'INSERT INTO Movies(movie_name, director_name, link) VALUES(?, ?, ?)',
          [
            name,
            director,
            link == null
                ? ''
                : link
          ]);
      print(count);
    });
    List<Map> moviesTable = await database.rawQuery('SELECT * FROM Movies');
    print(moviesTable);
    return moviesTable;
  }

  Future<List<Map>> getDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Movies (id INTEGER PRIMARY KEY, movie_name TEXT, director_name TEXT, link STRING)');
    });
    List<Map> moviesTable = await database.rawQuery('SELECT * FROM Movies');
    return moviesTable;
  }

  Future<List<Map>> deleteItem({@required id}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Movies (id INTEGER PRIMARY KEY, movie_name TEXT, director_name TEXT, link STRING)');
    });

    await database.rawDelete('DELETE FROM Movies WHERE id = ?', [id]);

    List<Map> moviesTable = await database.rawQuery('SELECT * FROM Movies');
    return moviesTable;
  }

  Future<List<Map>> updateItem(
      {@required id,
      @required name,
      @required director,
      @required link}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Movies (id INTEGER PRIMARY KEY, movie_name TEXT, director_name TEXT, link STRING)');
    });
    await database.rawUpdate(
        'UPDATE Movies SET movie_name = ?, director_name = ?, link = ? WHERE id = ?',
        [
          name,
          director,
          link == null
              ? 'https://www.fostercity.org/sites/default/files/styles/gallery500/public/imageattachments/parksrec/page/10791/thursday_movie.png?itok=XakMswGX'
              : link,
          id
        ]);
    List<Map> moviesTable = await database.rawQuery('SELECT * FROM Movies');
    return moviesTable;
  }
}
