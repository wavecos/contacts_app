import 'package:agenda_app/core/models/contact.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {

  final Contact contact;

  ContactCard({
    Key key,
    this.contact
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        elevation: 10.0,
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CircleAvatar(
                  maxRadius: 40.0,
                  backgroundImage: NetworkImage(contact.profilePhotoUrl),
                )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(contact.firstName),
                  Text(contact.email),
                  Text(contact.mobileNumber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
