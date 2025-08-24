import 'package:ecommerce/features/auth/domain/repo/user_repo.dart';

import '../../domain/entities/user.dart';

class CheckUserLogin {
  final UserRepository repository;

  CheckUserLogin(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.checkUserLog(email, password);
  }
}
