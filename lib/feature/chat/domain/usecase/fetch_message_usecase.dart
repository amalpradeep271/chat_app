import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repository/message_repository.dart';

class FetchMessageUsecase {
  final MessageRepository messageRepository;

  FetchMessageUsecase({required this.messageRepository});

  Future<List<MessageEntity>> call(String conversationId) async {
    return await messageRepository.fetchMessages(conversationId);
  }
}
