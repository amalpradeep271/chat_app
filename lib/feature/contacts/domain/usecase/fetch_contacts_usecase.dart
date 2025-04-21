import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/feature/contacts/domain/repositories/contacts_repository.dart';

class FetchContactsUsecase {
  final ContactsRepository contactsRepository;

  FetchContactsUsecase({required this.contactsRepository});

  Future<List<ContactEntity>> call() async {
    return await contactsRepository.fetchContacts();
  }
}
