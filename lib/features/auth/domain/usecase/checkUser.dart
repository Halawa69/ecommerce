import 'package:ecommerce/features/auth/domain/repo/user_repo.dart';

import '../../domain/entities/user.dart';

class CheckUser {
  final UserRepository repository;

  CheckUser(this.repository);

  Future<User?> call(String email, String username) async {
    return await repository.checkUser(email, username);
  }
}
