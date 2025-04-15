import 'package:chat_app/feature/conversations/data/datasource/conversation_remote_data_source.dart';
import 'package:chat_app/feature/conversations/domain/entities/conversation_entity.dart';
import 'package:chat_app/feature/conversations/domain/repositories/conversation_repository.dart';

class ConversationsRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await remoteDataSource.fetchConversations();
  }
}
