import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';

class ContactsModel extends ContactEntity {
  ContactsModel({
    required super.id,
    required super.username,
    required super.email,
    required super.profileImage,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],
      profileImage:
          json['profile_image'] ??
          'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
    );
  }
}
