import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/services/contact_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactServiceFbImpl implements ContactService {

  final Firestore _db = Firestore.instance;
  final String path = 'contacts';
  CollectionReference ref;

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
}