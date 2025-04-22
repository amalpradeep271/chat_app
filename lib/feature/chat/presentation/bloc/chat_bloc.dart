// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/feature/chat/domain/entities/message_entity.dart';
import 'package:chat_app/feature/chat/domain/usecase/fetch_message_usecase.dart';
import 'package:chat_app/feature/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/feature/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessageUsecase fetchMessageUsecase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({required this.fetchMessageUsecase}) : super(ChatLoadingState()) {
    on<LoadMessageEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessages);
    on<ReceiveMessageEvent>(_onReceiveMessages);
  }

  Future<void> _onLoadMessages(
    LoadMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      final messages = await fetchMessageUsecase(event.conversationId);
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(_messages)));

      _socketService.socket.off('newMessage');

      // Join the socket room for this conversation
      log('[SOCKET] Joining conversation: ${event.conversationId}');
      _socketService.socket.emit('joinConversation', event.conversationId);

      // Prevent adding multiple listeners on rebuild
      _socketService.socket.off('newMessage');

      _socketService.socket.on('newMessage', (data) {
        log('[SOCKET] 📥 Received newMessage: $data');
        add(ReceiveMessageEvent(data));
      });
    } catch (e) {
      log('[ERROR] Failed to load messages: $e');
      emit(ChatErrorState('Failed to load messages'));
    }
  }

  Future<void> _onSendMessages(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    String userId = await _storage.read(key: 'userId') ?? '';
    log('[SEND] userId: $userId');

    final newMessage = {
      'conversationId': event.conversationId,
      'content': event.content,
      'senderId': userId,
    };

    log('[SEND] Sending message: $newMessage');
    _socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> _onReceiveMessages(
    ReceiveMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      log('[RECEIVE] ✅ ReceiveMessageEvent triggered');
      log('[RECEIVE] Raw payload: ${event.message}');

      final message = MessageEntity(
        id: event.message['id'] ?? '',
        conversationId: event.message['conversation_id'] ?? '',
        senderId: event.message['sender_id'] ?? '',
        content: event.message['content'] ?? '',
        createdAt: event.message['created_at'] ?? '',
      );

      _messages.add(message);
      log('[RECEIVE] 📥 Message added: $message');

      emit(ChatLoadedState(List.from(_messages)));
      log(
        '[RECEIVE] ✅ ChatLoadedState emitted with ${_messages.length} messages',
      );
    } catch (e) {
      log('[RECEIVE] 🚨 Error parsing received message: $e');
      emit(ChatErrorState('Failed to process incoming message'));
    }
  }
}
