import 'package:chat_app/feature/conversations/domain/entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<List<ConversationEntity>> fetchConversations();
  Future<String> checkOrCreateConversation({required String contactId});
}
