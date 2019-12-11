import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/services/contact_service.dart';

class ContactServiceImpl implements ContactService {

  final contacts = [
    Contact(firstName: 'Juan', lastName: 'Perez', email: 'juanp@mail.com', mobileNumber: '98765456', profilePhotoUrl: 'https://gpluseurope.com/wp-content/uploads/Mauro-profile-picture.jpg'),
    Contact(firstName: 'Carlos', lastName: 'Lujan', email: 'carlos@mail.com', mobileNumber: '98765456', profilePhotoUrl: 'https://gpluseurope.com/wp-content/uploads/Mauro-profile-picture.jpg'),
    Contact(firstName: 'Ramiro', lastName: 'Ulloa', email: 'ramiro@mail.com', mobileNumber: '98765456', profilePhotoUrl: 'https://gpluseurope.com/wp-content/uploads/Mauro-profile-picture.jpg'),
  ];

  @override
  Stream<List<Contact>> getAllContacts() {
    return Stream.fromFuture(listAsync());
  }

  Future<List<Contact>> listAsync() async {
    await Future<String>.delayed(const Duration(seconds: 5));
    return contacts;
  }

}