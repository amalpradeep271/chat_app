import 'package:chat_app/feature/contacts/data/datasource/contact_remote_datasource.dart';
import 'package:chat_app/feature/contacts/domain/entities/contact_entity.dart';
import 'package:chat_app/feature/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactRemoteDatasource remoteDatasource;

  ContactsRepositoryImpl({required this.remoteDatasource});
  @override
  Future<void> addContacts({required String email}) async {
    return await remoteDatasource.addContact(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
    return await remoteDatasource.fetchContacts();
  }
}
