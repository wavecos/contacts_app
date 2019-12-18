import 'dart:io';

import 'package:agenda_app/core/models/contact.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ContactService {

  Stream<List<Contact>> getAllContacts();

  Future<String> save(Contact contact);

  StorageUploadTask uploadImage(String fileName, File image);

}