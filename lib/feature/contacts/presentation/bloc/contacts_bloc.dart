// ignore: depend_on_referenced_packages
import 'package:chat_app/feature/contacts/domain/usecase/add_contacts_usecase.dart';
import 'package:chat_app/feature/contacts/domain/usecase/fetch_contacts_usecase.dart';
import 'package:chat_app/feature/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/feature/contacts/presentation/bloc/contacts_state.dart';
import 'package:chat_app/feature/conversations/domain/usecases/check_or_create_conversation_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUsecase fetchContactsUsecase;
  final AddContactsUsecase addContactsUsecase;
  final CheckOrCreateConversationUsecase checkOrCreateConversationUsecase;

  ContactsBloc({
    required this.checkOrCreateConversationUsecase,
    required this.fetchContactsUsecase,
    required this.addContactsUsecase,
  }) : super(ContactsInitial()) {
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
    on<CheckOrCreateConversationEvent>(_onCheckOrCreateConversation);
  }

  Future<void> _onCheckOrCreateConversation(
    CheckOrCreateConversationEvent event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      emit(ContactsLoading());
 
      final conversationId = await checkOrCreateConversationUsecase(contactId: event.contactId);
      emit(ConversationReady(conversationId:conversationId, contact:event.contact));
    } catch (e) {
      emit(ContactsError('Failed to start conversation'));
    }
  }

  Future<void> _onFetchContacts(
    FetchContacts event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactsUsecase();
      emit(ContactsLoaded(contacts));
    } catch (e) {
      emit(ContactsError('Failed to fetch contacts'));
    }
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      await addContactsUsecase(email: event.email);
      emit(ContactAdded());
      add(FetchContacts());
    } catch (e) {
      emit(ContactsError('Failed to fetch contacts'));
    }
  }
}
