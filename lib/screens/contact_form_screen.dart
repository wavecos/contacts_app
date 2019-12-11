import 'package:flutter/material.dart';

class ContactFormScreen extends StatefulWidget {
  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Contacto'),
      ),
      body: Column(
        children: <Widget>[
          firstNameTextField,
          lastNameTextField,
        ],
      ),
    );
  }
}
