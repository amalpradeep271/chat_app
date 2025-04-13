import 'package:chat_app/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';
import 'package:chat_app/feature/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<UserEntity> login(String email, String password) async{
    return await authRemoteDatasource.login(email: email, password: password);
   }

  @override
  Future<UserEntity> register(String username, String email, String password) async{
    return await authRemoteDatasource.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
