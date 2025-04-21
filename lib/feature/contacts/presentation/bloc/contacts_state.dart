import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';

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
