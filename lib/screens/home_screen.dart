import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/providers/contact_provider.dart';
import 'package:agenda_app/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
      ),
      body: StreamBuilder<List<Contact>>(
          stream: contactProvider.fetchContacts(),
          builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
            if (snapshot.hasData) {
              final contacts = snapshot.data;

              return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (buildContext, index) {
                    return ContactCard(contact: contacts[index],);
                  }
              );
            } else {
              return Text('Loading...');
            }
          }
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
