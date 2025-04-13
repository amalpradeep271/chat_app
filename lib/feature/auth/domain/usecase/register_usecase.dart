import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:chat_app/feature/auth/domain/repositories/auth_repositories.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

  Future<UserEntity> call(String username, String email, String password) {
    return repository.register(username, email, password);
  }
}
