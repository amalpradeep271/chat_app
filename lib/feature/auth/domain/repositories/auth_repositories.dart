import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> register(String username, String email, String password);
  Future<UserEntity> login(String email, String password);
}
