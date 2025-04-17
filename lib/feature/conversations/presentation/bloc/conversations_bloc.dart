import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/feature/conversations/domain/usecases/fetch_conversation_usecase.dart';
import 'package:chat_app/feature/conversations/presentation/bloc/conversations_event.dart';
import 'package:chat_app/feature/conversations/presentation/bloc/conversations_state.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationUsecase fetchConversationUsecase;
  final SocketService _socketService = SocketService();

  ConversationsBloc(this.fetchConversationUsecase)
    : super(ConversationsInitial()) {
    on<FetchConversations>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _initializeSocketListeners() {
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated);
    } catch (e) {
      print("Error initializing socket listeners :$e");
    }
  }

  Future<void> _onFetchConversations(
    FetchConversations event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(ConversationsLoading());
    try {
      final conversations = await fetchConversationUsecase();
      emit(ConversationsLoaded(conversations));
    } catch (e) {
      emit(ConversationsError('Failed to load conversations'));
    }
  }

  void _onConversationUpdated(data) {
    add(FetchConversations());
  }
}
