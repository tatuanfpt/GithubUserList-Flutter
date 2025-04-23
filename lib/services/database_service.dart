// lib/services/database_service.dart
import 'package:github_users_app/models/github_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Manages local storage for caching users
class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('github_users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            login TEXT,
            avatarUrl TEXT,
            htmlUrl TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertUsers(List<GitHubUser> users) async {
    final db = await database;
    final batch = db.batch();
    for (var user in users) {
      batch.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  Future<List<GitHubUser>> fetchUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return maps.map((map) => GitHubUser.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}