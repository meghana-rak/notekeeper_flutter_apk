import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();
  static Database? _database;

  NoteDatabase._init();
  ///Initialise Database
  Future<void> init() async {
    _database = await _initDB('notes.db');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  ///create Database With Query
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE,
      password TEXT
    )
  ''');
  }

  ///registerUser
  Future<int> registerUser(String username, String password) async {
    final db = await database;

    try {
      return await db.insert(
        'users',
        {'username': username, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } catch (e) {
      return -1;
    }
  }

  ///login User
  Future<bool> loginUser(String username, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  ///add Note
  Future<int> addNote(NoteModel note) async {
    final db = await database;
    return await db.insert('notes', note.toJson());
  }

  ///get All Notes From Database
  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final notes = await db.query('notes', orderBy: 'id DESC');
    return notes.map((e) => NoteModel.fromJson(e)).toList();
  }

  ///update Notes
  Future<int> updateNote(NoteModel note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  ///delete Notes
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
