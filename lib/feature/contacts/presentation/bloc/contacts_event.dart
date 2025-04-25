import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';

abstract class ContactsEvent {}

class FetchContacts extends ContactsEvent {}

class AddContact extends ContactsEvent {
  final String email;
  AddContact(this.email);
}

class CheckOrCreateConversationEvent extends ContactsEvent {
  final String contactId;
  final ContactEntity contact;

  CheckOrCreateConversationEvent(this.contactId, this.contact);
}
