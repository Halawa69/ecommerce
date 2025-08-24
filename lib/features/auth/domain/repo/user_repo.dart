import 'package:ecommerce/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<int> insertUser(User user);
  Future<User?> getUser();
  Future<User?> checkUser(String email, String username);
  Future<User?> checkUserLog(String email, String password);
}
