abstract class ContactsEvent {}

class FetchContacts extends ContactsEvent {}

class AddContact extends ContactsEvent {
  final String email;
  AddContact(this.email);
}

class CheckOrCreateConversationEvent extends ContactsEvent {
  final String contactId;
  final String contactName;

  CheckOrCreateConversationEvent(this.contactId, this.contactName);
}
