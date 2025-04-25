import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/feature/conversations/domain/entities/conversation_entity.dart';

abstract class ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactEntity> contacts;

  ContactsLoaded(this.contacts);
}

class ContactsInitial extends ContactsState {}

class ContactsError extends ContactsState {
  final String message;

  ContactsError(this.message);
}

class ContactAdded extends ContactsState {}

class ConversationReady extends ContactsState {
  final String conversationId;
  final ContactEntity contact;

  ConversationReady({required this.conversationId, required this.contact});
}
