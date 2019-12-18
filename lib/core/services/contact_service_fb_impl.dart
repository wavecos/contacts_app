import 'dart:io';

import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/services/contact_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContactServiceFbImpl implements ContactService {

  final Firestore _db = Firestore.instance;
  final String path = 'contacts';
  CollectionReference ref;

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://contacts-app-xio.appspot.com');

//  StorageUploadTask _uploadTask;

  ContactServiceFbImpl() {
    ref = _db.collection(path);
  }

  @override
  Stream<List<Contact>> getAllContacts() {
    Stream<QuerySnapshot> stream = ref.snapshots();

    return stream.map(
            (qshot) =>
            qshot.documents.map((doc) => Contact.fromMap(doc.data, doc.documentID))
                .toList()
    );
  }

  @override
  Future<String> save(Contact contact) async {
    DocumentReference contactRef = await ref.add(contact.toJson());
    return contactRef.documentID;
  }

  @override
  StorageUploadTask uploadImage(String fileName, File image) {
    String filePath = 'photos/${fileName}';

    return _storage.ref().child(filePath).putFile(image);
  }


}