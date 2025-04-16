import 'package:chat_app/feature/chat/data/datasources/messages_remote_datasource.dart';
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/repository/message_repository.dart';

class MessagesRepositoryImpl implements MessageRepository {
  final MessagesRemoteDatasource remoteDatasource;

  MessagesRepositoryImpl({required this.remoteDatasource});
  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId)async {
  return await remoteDatasource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
  
}