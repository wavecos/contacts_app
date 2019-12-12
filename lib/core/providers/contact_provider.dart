import 'package:agenda_app/core/locator.dart';
import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/services/contact_service.dart';
import 'package:flutter/widgets.dart';

class ContactProvider extends ChangeNotifier {

  ContactService _contactService = locator.get<ContactService>();

  Stream<List<Contact>> fetchContacts() {
    return _contactService.getAllContacts();
  }

  Future<String> saveContact(Contact contact) {
    return _contactService.save(contact);
  }

}