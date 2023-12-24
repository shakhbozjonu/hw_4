import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String thumbnailUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.thumbnailUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}

class DatabaseHelper {
  static final String tableName = 'users';

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    _database ??= await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        thumbnailUrl TEXT
      )
    ''');
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> userMaps = await db.query(tableName);
    print('Retrieved user maps from database: $userMaps');
    final List<User> users = userMaps.map((map) => User.fromMap(map)).toList();
    print('Parsed users from retrieved maps: $users');
    return users;
  }

}

class SavedUserListScreen extends StatefulWidget {
  @override
  _SavedUserListScreenState createState() => _SavedUserListScreenState();
}

class _SavedUserListScreenState extends State<SavedUserListScreen> {
  List<User> savedUsers = [];

  @override
  void initState() {
    super.initState();
    fetchSavedUsers();
  }

  Future<void> fetchSavedUsers() async {
    final List<User> users = await DatabaseHelper.instance.getUsers();
    setState(() {
      savedUsers = users;
      print('Fetched saved users: $savedUsers');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building SavedUserListScreen with users: $savedUsers');
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved User List'),
      ),
      body: ListView.builder(
        itemCount: savedUsers.length,
        itemBuilder: (context, index) {
          final user = savedUsers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.thumbnailUrl),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}