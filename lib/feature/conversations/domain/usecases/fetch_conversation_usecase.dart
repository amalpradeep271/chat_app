import 'package:chat_app/feature/conversations/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversations/domain/repositories/conversation_repository.dart';

class FetchConversationUsecase {
  final ConversationRepository repository;

  FetchConversationUsecase(this.repository);

  Future<List<ConversationEntity>> call() async {
    return repository.fetchConversations();
  }
}
