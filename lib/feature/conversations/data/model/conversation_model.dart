import 'package:chat_app/feature/conversations/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.participantName,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.participantImage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['conversation_id'],
      participantName: json['participant_name'],
      participantImage:  json['profile_image'] ??
          'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
      lastMessage: json['last_message'],
      lastMessageTime: DateTime.parse(json['last_message_time']),
    );
  }
}
