import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<int> insertUser(UserModel user);
  Future<UserModel?> getUser();
  Future<UserModel?> checkUser(String email, String username);
  Future<UserModel?> checkUserLogin(String email, String password);
  Future<int> clearUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Future<Database> db;

  UserLocalDataSourceImpl(this.db);

  @override
  Future<int> insertUser(UserModel user) async {
    final dbClient = await db;
    return await dbClient.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<UserModel?> getUser() async {
    final dbClient = await db;
    final result = await dbClient.query('users', limit: 1);
    if (result.isNotEmpty) return UserModel.fromMap(result.first);
    return null;
  }

  @override
  Future<UserModel?> checkUser(String email, String username) async {
    final dbClient = await db;
    final res = await dbClient.query(
      'users',
      where: 'email = ? OR username = ?',
      whereArgs: [email, username],
    );
    if (res.isNotEmpty) return UserModel.fromMap(res.first);
    return null;
  }

  @override
  Future<UserModel?> checkUserLogin(String email, String password) async {
    final dbClient = await db;
    final res = await dbClient.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (res.isNotEmpty) return UserModel.fromMap(res.first);
    return null;
  }

  @override
  Future<int> clearUsers() async {
    final dbClient = await db;
    return await dbClient.delete('users');
  }
}
