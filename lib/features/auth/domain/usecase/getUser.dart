import 'package:ecommerce/features/auth/domain/repo/user_repo.dart';
import '../../domain/entities/user.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<User?> call() async {
    return await repository.getUser();
  }
}
