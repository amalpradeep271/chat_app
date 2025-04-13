import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:chat_app/feature/auth/domain/repositories/auth_repositories.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase({required this.repository});

  Future<UserEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}
