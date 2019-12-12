import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/providers/contact_provider.dart';
import 'package:agenda_app/screens/home_screen.dart';
import 'package:agenda_app/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactFormScreen extends StatefulWidget {
  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameTextController;
  TextEditingController _lastNameTextController;

  // Focus
  FocusNode _firstNameFocusNode;
  FocusNode _lastNameFocusNode;

  @override
  void initState() {
    super.initState();
    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    // Focus
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    // Focus
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    final firstNameTextField = TextFormField(
      controller: _firstNameTextController,
      keyboardType: TextInputType.text,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Nombre',
        helperText: 'Coloca tu primer nombre'
      ),
      focusNode: _firstNameFocusNode,
      textInputAction: TextInputAction.next,
      validator: (value) => (value.isEmpty) ? 'El campo es requerido' : null,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
      },
    );

    final lastNameTextField = TextFormField(
      controller: _lastNameTextController,
      keyboardType: TextInputType.text,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Apellido',
      ),
      focusNode: _lastNameFocusNode,
      textInputAction: TextInputAction.done,
    );

    final registerButton = RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {

          Contact contact = Contact(
            firstName: _firstNameTextController.text,
            lastName: _lastNameTextController.text
          );

          await contactProvider.saveContact(contact);

          changeScreen(context, HomeScreen());
        }
      },
      child: const Text('Guardar'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              firstNameTextField,
              lastNameTextField,
              registerButton,
            ],
          ),
        ),
      ),
    );
  }
}
