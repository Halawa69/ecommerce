import 'package:ecommerce/features/auth/data/datasource/userdatasource.dart';
import 'package:ecommerce/features/auth/domain/repo/user_repo.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<int> insertUser(User user) async {
    final userModel = UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      address: user.address,
      number: user.number,
      password: user.password,
      token: user.token,
    );
    return await dataSource.insertUser(userModel);
  }

  @override
  Future<User?> getUser() async {
    return await dataSource.getUser();
  }

  @override
  Future<User?> checkUser(String email, String username) async {
    return await dataSource.checkUser(email, username);
  }

  @override
  Future<User?> checkUserLog(String email, String password) async {
    return await dataSource.checkUserLogin(email, password);
  }
}
