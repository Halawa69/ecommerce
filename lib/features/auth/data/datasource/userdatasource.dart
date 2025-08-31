import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class UserLocalDataSource {
  Future<int> insertUser(UserModel user);
  Future<UserModel?> getUser();
  Future<UserModel?> checkUser(String email, String username);
  Future<UserModel?> checkUserLogin(String email, String password);
  Future<int> clearUsers(); // استخدمها بس في logout مش في init
}
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Database db;

  UserLocalDataSourceImpl(this.db);

  @override
  Future<int> insertUser(UserModel user) async {
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort, // ما يمسحش القديم
    );
  }

  @override
  Future<UserModel?> getUser() async {
    final result = await db.query('users', limit: 1);
    if (result.isNotEmpty) return UserModel.fromMap(result.first);
    return null;
  }

  @override
  Future<UserModel?> checkUser(String email, String username) async {
    final res = await db.query(
      'users',
      where: 'email = ? OR username = ?',
      whereArgs: [email, username],
    );
    if (res.isNotEmpty) return UserModel.fromMap(res.first);
    return null;
  }

  @override
  Future<UserModel?> checkUserLogin(String email, String password) async {
    final res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (res.isNotEmpty) return UserModel.fromMap(res.first);
    return null;
  }

  @override
  Future<int> clearUsers() async {
    // استخدمها بس في logout مش في init
    return await db.delete('users');
  }
}
