import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _age;

  void addContact(Contact contact) {
    print('Name: ${contact.name}, Age: ${contact.age}');
    final contactBox = Hive.box('contacts');
    contactBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _age = value,
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Add New Contact'),
            onPressed: () {
              _formKey.currentState!.save();
              final newContact = Contact(name: _name!, age: int.parse(_age!));
              addContact(newContact);
            },
          ),
        ],
      ),
    );
  }
}
