import 'package:ecommerce/features/auth/domain/repo/user_repo.dart';
import '../../domain/entities/user.dart';

class InsertUser {
  final UserRepository repository;

  InsertUser(this.repository);

  Future<String?> call(User user) async {
    await repository.insertUser(user);
    return null;
  }
}
