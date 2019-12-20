import 'dart:io';

import 'package:agenda_app/core/models/contact.dart';
import 'package:agenda_app/core/providers/contact_provider.dart';
import 'package:agenda_app/screens/home_screen.dart';
import 'package:agenda_app/utils/common.dart';
import 'package:agenda_app/widgets/photo_selector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class ContactFormScreen extends StatefulWidget {
  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameTextController;
  TextEditingController _lastNameTextController;
  TextEditingController _emailTextController;

  // Focus
  FocusNode _firstNameFocusNode;
  FocusNode _lastNameFocusNode;
  FocusNode _emailFocusNode;

  File _imageSelected;

  @override
  void initState() {
    super.initState();
    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    // Focus
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _emailTextController.dispose();
    // Focus
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
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
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );

    final emailTextField = TextFormField(
      controller: _emailTextController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Correo Electrónico',
      ),
      focusNode: _emailFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return 'El email es requerido';
        } else if (!isEmail(value)) {
          return 'El correo no es válido';
        } else {
          return null;
        }
      },
      textInputAction: TextInputAction.done,
    );

    final registerButton = RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {

          Contact contact = Contact(
            firstName: _firstNameTextController.text,
            lastName: _lastNameTextController.text,
            email: _emailTextController.text
          );

          String contactId = await contactProvider.saveContact(contact);

          await contactProvider.uploadPhotoProfile(contactId, _imageSelected);


          changeScreen(context, HomeScreen(), false);
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
//              Stack(
//                alignment: AlignmentDirectional.center,
//                children: <Widget>[
//                  CircleAvatar(
//                    backgroundColor: Colors.black12,
//                    backgroundImage: _imageSelected == null ? AssetImage('assets/images/empty-profile.png') : FileImage(_imageSelected),
//                    maxRadius: 60.0,
//                    minRadius: 40.0,
//                  ),
//                  FloatingActionButton(
//                      child: Icon(Icons.add),
//                      mini: true,
//                      onPressed: () {
//                        _showPhotoSelector();
//                      }
//                  ),
//                ],
//              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _showPhotoSelector();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage: _imageSelected == null ? AssetImage(
                          'assets/images/empty-profile.png') : FileImage(
                          _imageSelected),
                      maxRadius: 60.0,
                      minRadius: 40.0,
                    ),
                  ),
                ],
              ),
              firstNameTextField,
              lastNameTextField,
              emailTextField,
              registerButton,
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoSelector() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PhotoSelector(onImageSelected: (File imageSelected) {
            setState(() {
              _imageSelected = imageSelected;
            });
          },);
        });
  }


}
