import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.token,
    required super.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      token: json['token'],
      username: json['username'],
      profileImage: json['profile_image'],
    );
  }
}
