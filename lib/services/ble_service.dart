import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/message.dart';

class DBService {
  static Database? _db;

  static Future<Database> getDb() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'messages.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE messages(id TEXT PRIMARY KEY, fromId TEXT, toId TEXT, text TEXT, timestamp TEXT, status TEXT)',
        );
      },
      version: 1,
    );
    return _db!;
  }

  static Future<void> saveMessage(Message msg) async {
    final db = await getDb();
    await db.insert(
      'messages',
      msg.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Message>> getMessages() async {
    final db = await getDb();
    final maps = await db.query('messages', orderBy: "timestamp DESC");
    return List.generate(maps.length, (i) => Message.fromJson(maps[i]));
  }
}