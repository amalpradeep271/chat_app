import 'package:chat_app/feature/conversations/domain/repositories/conversation_repository.dart';

class CheckOrCreateConversationUsecase {
  final ConversationRepository repository;

  CheckOrCreateConversationUsecase({required this.repository});

  Future<String> call({required String contactId}) async {
    return repository.checkOrCreateConversation(contactId: contactId);
  }
}
