import 'package:flutter_riverpod_movie_app/data/core/models/database/movie_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MovieDBHelper {
  static late Database _db;

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    final documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER, $TITLE TEXT, $IMAGE TEXT, $ISFAVOURITE BOOLEAN, $DATE TEXT)");
  }

  Future<MovieDBModel> save(MovieDBModel movie) async {
    var dbClient = await db;
    movie.id = await dbClient.insert(TABLE, movie.toMap());
    return movie;
  }

  Future<List<MovieDBModel>> getMovies() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(TABLE,
        columns: [ID, TITLE, IMAGE, ISFAVOURITE, DATE], orderBy: DATE);
    List<MovieDBModel> movies = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        movies.add(MovieDBModel.fromMap(maps[i]));
      }
    }
    return movies;
  }

  Future<int> deleteMovie(int id) async {
    var dbClient = await db;
    return dbClient.delete(
      TABLE,
      where: '$ID = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
