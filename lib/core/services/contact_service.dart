import 'package:agenda_app/core/models/contact.dart';

abstract class ContactService {

  Stream<List<Contact>> getAllContacts();

  Future<String> save(Contact contact);

}